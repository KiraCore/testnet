# KIRA Network Public Testnet

## Hardware & Software Prerequisites
* `4 vCPU` cores (ARM64 or x64)
* Minimum `8GB` of RAM
* Storage space required to persist blockchain state and snapshots (`512GB+` recommended)
* Minimum `32GB+` of the **free** storage space available at all times
* Disposable cloud instance or VM
* Ubuntu `20.04 LTS` installed on the **host** instance or VM
* Stable internet connection with minimum `10 Mbps` Up/Dn speed
* Static IP address or dynamic DNS
* Access to router or otherwise your local network configuration

## Infrastructure Setup

### Overview
* Execute Setup Instruction
  * As branch name input `testnet-*` (* - see list below for the latest number)
* Verify Kira Manager Checksum
  * Click [V] to accept 
* Select Sentry or Validator Mode
* Click [S] to start setup
  * Input Address of the [Public Seed Node](https://testnet-rpc.kira.network/download/peers.txt) and follow instructions on the screen.
* Backup Auto-Generated Private Keys

### Setup Instructions

```
sudo -s

cd /tmp && read -p "Input branch name: " BRANCH && \
 wget https://raw.githubusercontent.com/KiraCore/kira/$BRANCH/workstation/init.sh -O ./i.sh && \
 chmod 555 -v ./i.sh && H=$(sha256sum ./i.sh | awk '{ print $1 }') && read -p "Is '$H' a [V]alid SHA256 ?: "$'\n' -n 1 V && \
 [ "${V,,}" != "v" ] && echo "INFO: Setup was cancelled by the user." || ./i.sh "$BRANCH"
```

_NOTE: Branch name should be the same as chain-id. When prompted to verify checksum press [V] to proceed_

### Keys Backup Instructions

To persist your private keys type `cat /home/<username>/.secrets/mnemonics.env` and save the content so that you can recover your accounts easily. Remember to replace `<username>` with your user name otherwise instruction above will fail.

### Keys Recovery Instructions

If you are installing KIRA Manager for the first time on the clean instance you will be prompted during setup to input mnemonic or auto generate a new one, you can also manually recover all your secrets as follows:

Type `cd /home/<username> && mkdir ./.secrets && nano ./.secrets/mnemonics.env`, then paste your saved secrets and press a combination of  `Ctrl+o`, `[ENTER]`, `Ctrl+x` to preserve changes. The command above has to be executed before infrastructure setup takes place otherwise it will not take effect during setup. Remember to replace `<username>` with your user name otherwise new set of keys will be generated.

### Joining Validator Set

After [submitting request form](https://forms.gle/3UPeksBrp9yDMNSA8) to join Public Testnet you will receive an on-chain permission to submit claim validator seat transaction. You will see that your node has `WAITING` status and after sending following transaction from within `validator` container you will become a KIRA Testnet Validator:

```
sekaid tx customstaking claim-validator-seat --from validator --keyring-backend=test --home=$SEKAID_HOME \
  --moniker="<Public-Name-Of-Your-Node>" \
  --chain-id=$NETWORK_NAME --fees=100ukex \
  --broadcast-mode=async --yes | txAwait
```

_NOTE: If you are using KIRA Manager simply select [J]oin validator set option. To update your validator moniker, website and other info see the "Identity Registrar & Launch Roadmap" article on the blog.kira.network._

### Hard Forks & Soft Forks

All hard and soft forks can be detected via KIRA Manager CLI command `showNextPlan` or by querying `/api/kira/upgrade/next_plan` INTERX endpoint, which contains detailed information in regards to time and upcoming software releases. If the `instate_upgrade` property is set to `false` a hard fork is expected and genesis file changes are necessary after halt of the chain. If the network is halted due to ongoing hard fork, then validators who do NOT use KIRA Manager should export genesis with the `sekaid export` command and then convert the exported genesis into a new genesis using `sekaid new-genesis-from-exported` command. More details in regards to the Hard & Soft forks can be found in the [Infrastructure Overview 2.0](https://blog.kira.network/kira-infrastructure-overview-2-0-b3bf94ba647) article.

## Networks, Checksums & References


### Testnet-7 (latest)
* Chain Identifier: `testnet-7`
* Kira Manager Checksum: `0feca1c125f2291596dd115ff2cf720032a7098030f8aa97c164afa9ca79644e`
* Genesis File Checksum: `15468bc041c31622aabdb83d5bac33d4fae9d2593c295825a609c5de9b28764a`
* Genesis File Source: [link](./testnet-7/genesis.json)
* Public Seed Nodes List: [link](https://testnet-rpc.kira.network/download/peers.txt)
* Public RPC Addresses: 
    * `testnet-rpc.kira.network`

### Testnet-6
* Chain Identifier: `testnet-6`
* Expected Launch Time: `1635028200`
* Kira Manager Checksum: `199a3454d4e88a152d8ea05dde33ad9cb8e7475eddbdf0488b4ebff5b2c9ac02`
* Genesis File Checksum: `bf08fe3cd574ec36eabf165fc4be15ee0e06673e145b3e16ed8480f0829d7ea6`
* Genesis File Source: [link](./testnet-6/genesis.json)
* Initial Block Height: `243887`
* Block Height Reached: `243887`

#### Post Mortem

> Failed to reach 2/3+1 of active validators after hard fork upgrade

### Testnet-5
* Chain Identifier: `testnet-5`
* Kira Manager Checksum: `35cfa0e7cee9eaab8c5e84986bbe81780d8c02c6ec76ad385953dc1148d457c0`
* Genesis File Checksum: `26efc7a3deb6fe8a1932cfffbbdf47a86f16811defc0b4a9a00575de6d0868cb`
* Genesis File Source: [link](./testnet-5/genesis.json)
* Block Height Reached: `243887`

#### Post Mortem

> Depreciated due to planned hard fork at 10:30 PM 2021-10-23

### Testnet-4
* Chain Identifier: `testnet-4`
* Kira Manager Checksum: `d2de922720744da7e5fa501f78c94d5ce7901744eca81a1796e3a308d7114e31`
* Genesis File Checksum: `240b0fe67095e7e25a1e98ba2062231dca0ece81c24f12e8371a31798ade276b`
* Genesis File Source: [link](./testnet-4/genesis.json)
* Block Height Reached: `1271603+`

#### Post Mortem

> Depreciated with a hard fork in order to include automated upgrade module & identity registrar

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
sekaid tx customslashing pause --from validator --keyring-backend=test --home=$SEKAID_HOME --chain-id=$NETWORK_NAME --fees=1000ukex --broadcast-mode=async --log_format=json --broadcast-mode=async --yes | txAwait

# UnPausing PAUSED Node (disabling maintenance mode)
sekaid tx customslashing unpause --from validator --keyring-backend=test --home=$SEKAID_HOME --chain-id=$NETWORK_NAME --fees=1000ukex --broadcast-mode=async --log_format=json --broadcast-mode=async --yes | txAwait
```

![picture 1](https://i.imgur.com/G0o9Qn5.png)  




