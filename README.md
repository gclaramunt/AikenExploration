# Aiken exploration

## Functionality Overview

This is a simple smart contract that requires a specific signature to unlock funds.
When locking the funds, the datum captures the signature that can unlock.
When unlocking and executing the contract, validates that the signature in the datum is present in the signers of the transaction, thus releasing the funds.

## Instructions

### Building

```sh
aiken build
```

### Testing

There are two simple test: one that validates the contract pays to the signature in the datum and one that validates it doesn't pay if is not signed by the singature in the datum.

To run all tests, simply do:

```sh
aiken check
```

You should get:


```sh
    ┍━ assignment ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    │ PASS [mem: 36266, cpu: 12321269] pays_to_owner
    │ PASS [mem: 39403, cpu: 13428495] doesnt_pay_if_not_owner
    ┕━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2 tests | 2 passed | 0 failed
```

### Run on-chain (Testnet/Mainnet)

(Note: The scripts use blockfrost to interact with cardano blockchain, it requires a project id in the env variable `BLOCKFROST_PROJECT_ID` )


Optional: generate credentials

```sh
  deno run --allow-net --allow-write generate-credentials.ts
```

Lock funds

```sh
deno run --allow-net --allow-read --allow-env lock-funds.ts
```

Unlock funds

```sh
deno run --allow-net --allow-read --allow-env unlock-funds.ts <lock transaction Id>
```

