
# Module Evidence:


```
Apr 19 18:55:11 vmi287466 sekaid[17583]: 6:55PM INF Evidence already pending, ignoring this one ev={
	"Timestamp": "2021-04-11T17:28:23.185097187Z",
	"TotalVotingPower": 182,
	"ValidatorPower": 1,
	"vote_a": {
		"block_id": {
			"hash": "",
			"parts": {
				"hash": "",
				"total": 0
			}
		},
		"height": 138651,
		"round": 0,
		"signature": "NwQpF5a/CyyO/LNEsZMJBfJH6liioPX9FumKifJOJulNpHYRpyLeO4LTXi8adDT8mwvVR6deS+tTJ5R5cperAg==",
		"timestamp": "2021-04-11T17:28:28.808703115Z",
		"type": 1,
		"validator_address": "8AE9FEC1C8F4CD7A2BACDA24299298E962D6B3A7",
		"validator_index": 97
	},
	"vote_b": {
		"block_id": {
			"hash": "F00C2D6EB103748010B2328C95B990B83215E4A123BB5BE624E2018346F42E3B",
			"parts": {
				"hash": "77A3F4AD8DF9AFC4320552C9D37DC46113EAABAD25E9527B8A01411355C6CCCC",
				"total": 1
			}
		},
		"height": 138651,
		"round": 0,
		"signature": "upE6NSwH9mr5birnzdIk40SyN5SZeavuSws5bByrAsUjqh/YLrBapcUeOT2xTW3GNn9AFNDN44iRhaGj4nxEAw==",
		"timestamp": "2021-04-11T17:28:28.699597672Z",
		"type": 1,
		"validator_address": "8AE9FEC1C8F4CD7A2BACDA24299298E962D6B3A7",
		"validator_index": 97
	}
} module=evidence
```

# Stopping reason:

> Apr 19 18:29:30 vmi287466 sekaid[17583]: 6:29PM ERR Stopping peer for error err="Invalid evidence: evidence has a different time to the block it is associated with (2021-04-19 06:35:35.153998512 +0000 UTC != 2021-04-19 06:35:35.139384858 +0000 UTC). Evidence: 

> DuplicateVoteEvidence{VoteA: Vote{121:EDE57AD238BA 202750/00/SIGNED_MSG_TYPE_PREVOTE(Prevote) 000000000000 3F217FEB0350 @ 2021-04-19T06:35:40.997618902Z}, 

> VoteB: Vote{121:EDE57AD238BA 202750/00/SIGNED_MSG_TYPE_PREVOTE(Prevote) 1C12699D9E05 841F6EDA4A46 @ 2021-04-19T06:35:41.160062686Z}}" module=p2p peer={"Data":{},"Logger":{}}


# Validator Info:


> {
	"top": "148",
	"address": "kira1f6p5schwj4573w3mpkax8lcqq4z4jhaznpx6qg",
	"valkey": "kiravaloper1f6p5schwj4573w3mpkax8lcqq4z4jhazq86ecy",
	"pubkey": "kiravalconspub1zcjduepqeaygp5v7xhrrrkrde73gk0j066ztpmdzuukh35yf9fj6nw6jwvdq9j60ln",
	"proposer": "8AE9FEC1C8F4CD7A2BACDA24299298E962D6B3A7",
	"moniker": "0ldfart",
	"website": "",
	"social": "https://twitter.com/Mare_12345",
	"identity": "",
	"commission": "0.000000000000000000",
	"status": "PAUSED",
	"rank": "1",
	"streak": "1",
	"mischance": "0",
	"start_height": "125613",
	"index_offset": "2245",
	"inactive_until": "1970-01-01T00:00:00Z",
	"tombstoned": "false",
	"missed_blocks_counter": "483",
	"produced_blocks_counter": "1762"
}


# Other Logs

```
4:30PM INF Evidence already pending, ignoring this one ev={"Timestamp":"2021-04-19T06:35:35.153998512Z","TotalVotingPower":133,"ValidatorPower":1,"vote_a":{"block_id":{"hash":"","parts":{"hash":"","total":0}},"height":202750,"round":0,"signature":"PyF/6wNQLuvRiDMj/tJM/Yu+cxxPUvEVWYRF7UmoX/970U8Z/CPCX7CFh48QByma2x1Q8yfO/5vp6p3vfDvvAA==","timestamp":"2021-04-19T06:35:40.997618902Z","type":1,"validator_address":"EDE57AD238BA4A7644AFBC6F043340D09C096C56","validator_index":121},"vote_b":{"block_id":{"hash":"1C12699D9E057090953A846475E68EA5D8A43561E44E11C7CCEFEEE4073DC29E","parts":{"hash":"FE2054D563B25C16A5E49C7A3E037339474D2181269064EC42C3691F054B9623","total":1}},"height":202750,"round":0,"signature":"hB9u2kpGTy7QpzwOtUd862BGkNMsYg69v5OAAbLqD+W/ZvyV+PA4cURHnJWeATaMQ/wv0D4emjHy1kjRtsLhCw==","timestamp":"2021-04-19T06:35:41.160062686Z","type":1,"validator_address":"EDE57AD238BA4A7644AFBC6F043340D09C096C56","validator_index":121}} module=evidence


Apr 19 17:31:00 vmi287466 sekaid[17583]: 5:31PM ERR Stopping peer for error err="Invalid evidence: evidence has a different time to the block it is associated with (2021-04-19 06:35:35.153998512 +0000 UTC != 2021-04-19 06:35:35.139384858 +0000 UTC). Evidence: DuplicateVoteEvidence{VoteA: Vote{121:EDE57AD238BA 202750/00/SIGNED_MSG_TYPE_PREVOTE(Prevote) 000000000000 3F217FEB0350 @ 2021-04-19T06:35:40.997618902Z}, VoteB: Vote{121:EDE57AD238BA 202750/00/SIGNED_MSG_TYPE_PREVOTE(Prevote) 1C12699D9E05 841F6EDA4A46 @ 2021-04-19T06:35:41.160062686Z}}" module=p2p peer={"Data":{},"Logger":{}}
```
