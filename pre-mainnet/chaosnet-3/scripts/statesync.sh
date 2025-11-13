#!/bin/bash
set -e

cd /home/km/sekin

echo "=== KIRA State Sync ==="
echo "Working directory: $(pwd)"
echo ""

# Stop all containers
echo "Stopping containers with docker compose..."
docker compose down

# Get state sync parameters from genesis node
RPC_NODE=""
echo "Fetching latest block from genesis node..."
LATEST=$(curl -s $RPC_NODE/block | jq -r '.result.block.header.height')

# Find nearest snapshot height (140000 or 141000)
# Round down to nearest 1000
SNAPSHOT_HEIGHT=$((LATEST / 1000 * 1000))
TRUST_HEIGHT=$SNAPSHOT_HEIGHT
TRUST_HASH=$(curl -s $RPC_NODE/block?height=$TRUST_HEIGHT | jq -r '.result.block_id.hash')

echo "Latest Height: $LATEST"
echo "Using Snapshot Height: $SNAPSHOT_HEIGHT"
echo "Trust Height: $TRUST_HEIGHT"
echo "Trust Hash: $TRUST_HASH"
echo ""

# Backup config
echo "Creating config backup..."
cp /home/km/sekin/sekai/config/config.toml /home/km/sekin/sekai/config/config.toml.backup.$(date +%Y%m%d_%H%M%S)

# Update config.toml for state sync
echo "Configuring state sync..."

# Update with proper sed for any existing values
sed -i -e 's/^  enable = .*/  enable = true/' \
       -e "s|^  rpc_servers = .*|  rpc_servers = \"$RPC_NODE,$RPC_NODE\"|" \
       -e "s/^  trust_height = .*/  trust_height = $TRUST_HEIGHT/" \
       -e "s/^  trust_hash = .*/  trust_hash = \"$TRUST_HASH\"/" \
       /home/km/sekin/sekai/config/config.toml

# Verify changes
echo ""
echo "State sync configuration:"
grep -A 8 "\[statesync\]" /home/km/sekin/sekai/config/config.toml | head -9
echo ""

# Verify it actually changed
if grep -q "enable = true" /home/km/sekin/sekai/config/config.toml && \
   grep -q "trust_height = $TRUST_HEIGHT" /home/km/sekin/sekai/config/config.toml && \
   grep -q "trust_hash = \"$TRUST_HASH\"" /home/km/sekin/sekai/config/config.toml; then
    echo "✓ Configuration updated successfully"
else
    echo "✗ ERROR: Configuration update failed!"
    echo "Expected values:"
    echo "  trust_height = $TRUST_HEIGHT"
    echo "  trust_hash = \"$TRUST_HASH\""
    exit 1
fi

echo ""

# Clear blockchain data completely
echo "Clearing blockchain data..."
rm -rf /home/km/sekin/sekai/data
mkdir -p /home/km/sekin/sekai/data

# Recreate priv_validator_state.json
echo '{
  "height": "0",
  "round": 0,
  "step": 0
}' > /home/km/sekin/sekai/data/priv_validator_state.json

echo ""
echo "Data cleared. Disk usage:"
du -sh /home/km/sekin/sekai/data/
echo ""

# Start containers
echo "Starting containers with docker compose..."
docker compose up -d

echo "Starting sekai..."
bash /home/km/sekin/scripts/05-sekaid-start.sh

sleep 5

echo ""
echo "=== State sync initiated! ==="
echo ""
echo "The node will now:"
echo "  1. Discover available snapshots from genesis node"
echo "  2. Download snapshot chunks (from height $SNAPSHOT_HEIGHT)"
echo "  3. Apply snapshot to reach height ~$TRUST_HEIGHT"
echo "  4. Continue syncing normally to current height"
echo ""
echo "This should take 5-15 minutes depending on network speed."
echo ""
echo "Monitoring logs (press Ctrl+C to exit)..."
echo "Look for: 'Discovering snapshots', 'Fetching snapshot chunk', 'State sync complete'"
echo ""

## Add RPC_node to persistent peer, helps with obtaining snapshots
## Edit: 	/home/km/sekin/sekia/config/config.yml
## Field: 	persisted_peers = ""
## Change to:	persisted_peers = "RPC_NODE_IP@RPC_NODE_IP_ADDRESS:26656"
## To get id:	curl -s RPC_NODE_IP:11000/api/status | jq .node_info.id
