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
 [ "${V,,}" == "v" ] && ./i.sh "$BRANCH" || echo "Hash was NOT accepted by the user"
```

_NOTE: Branch name should be the same as chain-id. When prompted to verify checksum press [V] to proceed_

### Keys Backup Instructions

To persist your private keys type `cat $HOME/.secrets/mnemonics.env` and save the content so that you can recover your accounts easily. Note, tht you have to run above command as non-sudo user.

### Keys Recovery Instructions

To recover accounts type `mkdir -p $HOME/.secrets && nano $HOME/.secrets/mnemonics.env`, then paste your saved secrets and press a combination of  `Ctrl+o`, `[ENTER]`, `Ctrl+x` to save changes. The command above has to be executed before infrastructure setup takes place otherwise it will not take effect during setup. Note, tht you have to run above command as non-sudo user.

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




