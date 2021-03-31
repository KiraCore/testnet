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
  * As branch name input chain-id, e.g `testnet-1`
* Verify Kira Manager Checksum
  * Click [V] to accept 
* Select Sentry or Validator Mode
* Select Quick Mode
  * Input Address of the trusted Public Seed Node
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

To persist your private keys type `cat $HOME/.secrets/mnemonics.env` and save the content so that you can recover your accounts easily. Note, tht you have to run above command as non-sudo user.

### Keys Recovery Instructions

To recover accounts type `mkdir -p $HOME/.secrets && nano $HOME/.secrets/mnemonics.env`, then paste your saved secrets and press a combination of  `Ctrl+o`, `[ENTER]`, `Ctrl+x` to save changes. The command above has to be executed before infrastructure setup takes place otherwise it will not take effect during setup. Note, tht you have to run above command as non-sudo user.

### Joining Validator Set

After [submitting request form](https://forms.gle/3UPeksBrp9yDMNSA8) to join Public Testnet you will receive an on-chain permission to submit claim validator seat transaction. You will see that your node has WAITING status and after sending following transaction you will become a KIRA Testnet Validator:

```
sekaid tx customstaking claim-validator-seat --from validator --keyring-backend=test --home=$SEKAID_HOME \
  --moniker="<Public-Name-Of-Your-Node>" \
  --social="<Social-Media-URL-e.g.-Twitter>" \
  --website="<Your-Official-Website-URL>" \
  --identity="<Proof-Of-Identity-e.g.-Keybase-ID>" \
  --chain-id=$NETWORK_NAME --fees=100ukex --yes | jq
```

_NOTE: After sending claim-validator-seat transaction you will NOT be able to change/edit any of the informations submitted in that transaction, so make sure that all data such as URL's, Names and so on are valid and up to date_

## Networks, Checksums & References

### Testnet-1 (latest)
* Chain Identifier: `testnet-1`
* Kira Manager Checksum: `26237215b968ecfd201d92c61a13b4c4ce84aa65d57465fe949b2b49f8e66db0`
* Genesis File Checksum: `d00fd0d0b846a68d93f425ba9655bebae18c31ee5687999935899e5d96b4d0be`
* Genesis File Source: [link](./genesis/testnet-1.json)
* Public Seed Addresses:
    *  `3.11.224.235`
    *  `3.11.25.53`
* Public RPC Addresses: 
    * `https://testnet-1-rpc.kira.network` 
* Public Frontend Addresses: 
    * `https://testnet-1-ui.kira.network` 


## Unjailing Stopped Validator Nodes

It might happen that your running validator stops producing blocks due to hardware or software malfunction. As the result of your node halted block production it might become inactive (removed from consensus) and thus require sending an activate transaction:

```
sekaid tx customslashing activate --from validator --keyring-backend=test --home=$SEKAID_HOME --chain-id=$NETWORK_NAME --fees=1000ukex --yes | jq
```

When validator becomes inactive it's rank on the validators leeboard decreases. To prevent that from happening you can enable [M]aintenance mode which will inform the network that the downtime is planned. After you are ready to join validator set again you can simply disable the [M]aintenance mode and your validator will again join network operators set without decreasing its ranking position.

![picture 1](https://i.imgur.com/G0o9Qn5.png)  






