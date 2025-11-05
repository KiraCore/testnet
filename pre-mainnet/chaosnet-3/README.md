# Chaosnet-3 (Pre-Mainnet)

Welcome to Chaosnet-3, a pre-mainnet testnet for the KIRA network.

## Network Information

- **Chain ID**: chaosnet-3
- **Network Type**: Pre-Mainnet
- **Telegram**: https://tg.kira.network
- **Genesis SHA256**: `<GENESIS_SHA256_CHECKSUM>`

## Seed Nodes

Initial seed nodes for connecting to the network:

```
<seed_node_1>
<seed_node_2>
<seed_node_3>
```

## Deployment

### 1. Bootstrap a New Node

To set up a new node from scratch, run the bootstrap script:

```bash
wget -O bootstrap.sh https://raw.githubusercontent.com/KiraCore/sekin/refs/heads/main/scripts/bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

### 2. Join the Network

Download the join script:

```bash
wget -O join-network.sh https://raw.githubusercontent.com/KiraCore/sekin/refs/heads/main/scripts/00-sekaid-join.sh
chmod +x join-network.sh
```

Edit `join-network.sh` and add:
- Your validator mnemonic phrase
- IP address of a seed node from the list above

Then run:

```bash
./join-network.sh
```

**IMPORTANT SECURITY STEPS:**

1. **Save your mnemonic** in a secure location before proceeding
2. **Securely delete the script** after use to prevent mnemonic exposure:

```bash
dd if=/dev/zero of=join-network.sh bs=1M
rm join-network.sh
```

## Validator Registration

After your node is running, register as a validator by submitting a pull request to this repository.

1. Copy `validator-template.json`
2. Fill in your information
3. Save as `validators/<your-moniker>.json`
4. Submit a PR

**Note**: Your validator will be reviewed and approved after the first PR submission.

## Support

- **Telegram**: https://tg.kira.network
- **GitHub Issues**: https://github.com/KiraCore/testnet
