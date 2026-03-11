# Doubler Verification

Bytecode verification for the Doubler contract at [`0x2ff2a65b0a324c04747bfdc63f4bf525d43e5c62`](https://etherscan.io/address/0x2ff2a65b0a324c04747bfdc63f4bf525d43e5c62).

## Contract Details

| Field | Value |
|-------|-------|
| Address | `0x2ff2a65b0a324c04747bfdc63f4bf525d43e5c62` |
| Block | 883,117 (~December 2015) |
| ETH Balance | 25 ETH (locked) |
| Runtime Size | 235 bytes |
| Creator | `0xbc4b27f7da7db9cd5dae154390750a77fdafddec` |
| Hardcoded Owner | `0xdbf03b407c01e7cd3cbea99509d93f8dddc8c6fb` |
| Compiler | solc v0.1.5 through v0.2.0 (no optimizer) |

## What It Does

A simple "doubler" contract. When ETH is sent to it (via fallback), it calculates `msg.value * 2`, caps it at the contract's balance, and sends that amount to the hardcoded owner address.

The `add_funds()` function is a no-op that allows the contract to receive ETH via a named function call.

The 25 ETH is effectively locked, only retrievable by the hardcoded owner.

## Verification

Both runtime (235 bytes) and creation (315 bytes) bytecodes match exactly.

```bash
./verify.sh
```

## Match Details

- **Runtime**: Exact match (235 bytes)
- **Creation**: Exact match (315 bytes)
- **Compiler versions tested**: v0.1.5, v0.1.6, v0.1.7, v0.2.0 (all produce identical output without optimizer)
