# Guestbook

## Deployments

- görli: [0x6ab21b94077b718d2cc7c4421a056eb597206212](https://goerli.etherscan.io/address/0x6ab21b94077b718d2cc7c4421a056eb597206212)

## Demo

- This
  [tx](https://goerli.etherscan.io/tx/0xc920c632991b40c9dd954a4eb15437648441e7160157e10c0cb5a55d1e4006d9)
  shows a transaction where the actual message was only submitted on chain as
  calldata, hence making its storage cheaper than if it was stored in storage.
- All entries and their creators can be fetched via the `Entry` event

### Why?

I wrote a [gas-optimized sparse merkle
tree](https://github.com/rugpullindex/indexed-sparse-merkle-tree) and I wanted
to test it with a simple use case.

## Prerequisites

- Have [dapptools](https://github.com/dapphub/dapptools#installation) installed

## Run Tests

```bash
dapp test -vv
```

## LICENSE

See LICENSE file.
