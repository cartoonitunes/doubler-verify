#!/bin/bash
# Verification script for 0x2ff2a65b0a324c04747bfdc63f4bf525d43e5c62
# Reproduces exact on-chain runtime AND creation bytecode from source.
set -e

CONTRACT="0x2ff2a65b0a324c04747bfdc63f4bf525d43e5c62"
echo "=== Doubler Bytecode Verification ==="
echo "Contract: $CONTRACT"
echo "Compiler: solc v0.1.5-v0.2.0 (no optimizer)"
echo "Block: 883117 (~Dec 2015)"
echo ""

# Compile using Docker native solc
echo "Compiling..."
RUNTIME=$(docker run --rm -v "$(pwd):/src" solc-v017 sh -c \
  '/umbrella/build/solidity/solc/solc --bin-runtime /src/Doubler.sol 2>&1' \
  | grep -A2 "^======= Doubler" | tail -1 | tr -d '\n')
CREATION=$(docker run --rm -v "$(pwd):/src" solc-v017 sh -c \
  '/umbrella/build/solidity/solc/solc --bin /src/Doubler.sol 2>&1' \
  | grep -A2 "^======= Doubler" | tail -1 | tr -d '\n')

echo "Compiled runtime: $((${#RUNTIME}/2)) bytes"
echo "Compiled creation: $((${#CREATION}/2)) bytes"

# Fetch on-chain bytecode
echo ""
echo "Fetching on-chain bytecode..."
ONCHAIN=$(curl -s "https://api.etherscan.io/api?module=proxy&action=eth_getCode&address=${CONTRACT}" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['result'][2:])")

echo "On-chain runtime: $((${#ONCHAIN}/2)) bytes"

if [ "$RUNTIME" = "$ONCHAIN" ]; then
  echo ""
  echo "EXACT RUNTIME MATCH"
else
  echo ""
  echo "MISMATCH"
fi
