# KIRA Network Public Testnet

## Hardware & Software Prerequisites
* 4 vCPU cores (ARM64 or x64)
* Minimum 8GB of RAM
* Minimum 32GB+ of the free storage space
* Storage space required to persist blockchain state and snapshots (512 GB recommended)
* Disposable cloud instance or VM
* Ubuntu 20.04 LTS installed on the host instance or VM
* Stable internet connection with at least 10 Mbps Up/Dn speed
* Static IP address or dynamic DNS
* Access to router or otherwise your local network configuration


## Infrastructure Setup

### Overview
* Execute Setup Instruction
  * As branch name input chain-id, e.g `testnet-4`
* Verify Kira Manager Checksum
  * Click [V] to accept 
* Select Sentry or Validator Mode
* Select Quick Mode
  * Input Address of the [Public Seed Node](https://testnet-rpc.kira.network/download/peers.txt)
* Backup Auto-Generated Private Keys

### Setup Instructions

```
sudo -s

cd /tmp && read -p "Input branch name: " BRANCH && \
 wget https://raw.githubusercontent.com/KiraCore/kira/$BRANCH/workstation/init.sh -O ./i.sh && \
 chmod 555 -v ./i.sh && H=$(sha256sum ./i.sh | awk '{ print $1 }') && read -p "Is '$H' a [V]alid SHA256 ?: "$'\n' -n 1 V && \
 [ "${V,,}" == "v" ] && ./i.sh "$BRANCH" || echo "ERROR: Setup failed or was cancelled by the user. Try again init command."
```

_NOTE: Branch name should be the same as chain-id. When prompted to verify checksum press [V] to proceed_

### Keys Backup Instructions

To persist your private keys type `cat /home/<username>/.secrets/mnemonics.env` and save the content so that you can recover your accounts easily. Remember to replace `<username>` with your user name otherwise instruction above will fail.

### Keys Recovery Instructions

To recover accounts type `cd /home/<username> && mkdir ./.secrets && nano ./.secrets/mnemonics.env`, then paste your saved secrets and press a combination of  `Ctrl+o`, `[ENTER]`, `Ctrl+x` to preserve changes. The command above has to be executed before infrastructure setup takes place otherwise it will not take effect during setup. Remember to replace `<username>` with your user name otherwise new set of keys will be generated.

### Joining Validator Set

After [submitting request form](https://forms.gle/3UPeksBrp9yDMNSA8) to join Public Testnet you will receive an on-chain permission to submit claim validator seat transaction. You will see that your node has `WAITING` status and after sending following transaction from within `validator` container you will become a KIRA Testnet Validator:

```
sekaid tx customstaking claim-validator-seat --from validator --keyring-backend=test --home=$SEKAID_HOME \
  --moniker="<Public-Name-Of-Your-Node>" \
  --social="<Social-Media-URL-e.g.-Twitter>" \
  --website="<Your-Official-Website-URL>" \
  --identity="<Proof-Of-Identity-e.g.-Keybase-ID>" \
  --chain-id=$NETWORK_NAME --fees=100ukex --gas=1000000 \
  --broadcast-mode=async --yes | txAwait
```

_NOTE: After sending claim-validator-seat transaction you will NOT be able to change/edit any of the informations submitted in that transaction, so make sure that all data such as URL's, Names and so on are valid and up to date_

## Networks, Checksums & References

### Testnet-4 (latest)
* Chain Identifier: `testnet-4`
* Kira Manager Checksum: `d2de922720744da7e5fa501f78c94d5ce7901744eca81a1796e3a308d7114e31`
* Genesis File Checksum: `240b0fe67095e7e25a1e98ba2062231dca0ece81c24f12e8371a31798ade276b`
* Genesis File Source: [link](./testnet-4/genesis.json)
* Public Seed Nodes List: [link](https://testnet-rpc.kira.network/download/peers.txt)
* Public RPC Addresses: 
    * `testnet-rpc.kira.network`

### Testnet-3
* Chain Identifier: `testnet-3`
* Kira Manager Checksum: `1837ccd10c21d5e1633751a8c8ce7d7a226ea63a569010a5ff93ad2f02b82d62`
* Genesis File Checksum: `85b30bd1e9334299ccfdb39e9385c423f7b43959082ef1d68160ade79c2d6b66`
* Genesis File Source: [link](./testnet-3/genesis.json)
* Block Height Reached: `465099`

#### Post Mortem

> State machine fault while changing validator set

### Testnet-2
* Chain Identifier: `testnet-2`
* Kira Manager Checksum: `e0dcfa5b4b4feba8bdc8665fb47cd0fa587e65984a743b3bc13f2250032e74df`
* Genesis File Checksum: `918a64a5ca548b2b4803b96afd06c99cad5302521bdca8271e19e03ffbe879e5`
* Genesis File Source: [link](./testnet-2/genesis.json)
* Block Height Reached: `204503`

#### Post Mortem

> Old release of TM caused [Denial of Service 2](https://forum.cosmos.network/t/tendermint-core-vulnerability-retrospective-security-advisory-mulberry-january-19-2021/4336) resulting in the network halt 

### Testnet-1
* Chain Identifier: `testnet-1`
* Kira Manager Checksum: `26237215b968ecfd201d92c61a13b4c4ce84aa65d57465fe949b2b49f8e66db0`
* Genesis File Checksum: `d00fd0d0b846a68d93f425ba9655bebae18c31ee5687999935899e5d96b4d0be`
* Genesis File Source: [link](./testnet-1/genesis.json)
* Block Height Reached: `49999`

#### Post Mortem

> Duplication of the validator when it's added to the validator set by the state machine. Most likely cause was a validator reactivation & validator claim call occurring at the same time or pause/unpause transaction sent in the same block.


## Unjailing Stopped Validator Nodes

It might happen that your running validator stops producing blocks due to hardware or software malfunction. As the result of your node halted block production it might become `INACTIVE` (removed from consensus for ~10 minutes) and thus require sending an activate transaction, by selecting option [A]ctivate in the KIRA Manager main menu, or by inspecting `validator` container and posting following command into the console:

```
sekaid tx customslashing activate --from validator --keyring-backend=test --home=$SEKAID_HOME --chain-id=$NETWORK_NAME --fees=1000ukex --broadcast-mode=async --log_format=json --gas=1000000 --broadcast-mode=async --yes | txAwait
```

![picture 2](https://i.imgur.com/HC79dRk.png)  


When validator becomes inactive it's rank on the validators leeboard decreases. To prevent that from happening you can enable [M]aintenance mode which will inform the network that the downtime is planned. After you are ready to join validator set again you can disable the [M]aintenance mode and your validator will again join network operators set without decreasing its ranking position.

You can also enable/disable maintenance mode manually by inspecting your `validator` container and sending following command to the console window:

```
# Pausing ACTIVE Node (enabling maintenance)
sekaid tx customslashing pause --from validator --keyring-backend=test --home=$SEKAID_HOME --chain-id=$NETWORK_NAME --fees=1000ukex --broadcast-mode=async --log_format=json --gas=1000000 --broadcast-mode=async --yes | txAwait

# UnPausing PAUSED Node (disabling maintenance mode)
sekaid tx customslashing unpause --from validator --keyring-backend=test --home=$SEKAID_HOME --chain-id=$NETWORK_NAME --fees=1000ukex --broadcast-mode=async --log_format=json --gas=1000000 --broadcast-mode=async --yes | txAwait
```

![picture 1](https://i.imgur.com/G0o9Qn5.png)  




