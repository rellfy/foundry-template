#!/bin/bash
# Check if input is correct.
if [ -z "$1" ]; then
  echo "usage: ./deploy.sh ScriptName"
  exit 1
fi
# Load environment variables
source .env
FILE_NAME=$1.s.sol
CONTRACT_NAME=$1
echo Deploying with script: "$FILE_NAME"
# Pass verification commands to variable, only use if not deploying locally.
VERIFICATION_COMMANDS=
if [[ $RPC_URL == *"localhost"* ]] || [[ $RPC_URL == *"127.0.0.1"* ]]; then
  VERIFICATION_COMMANDS="--etherscan-api-key $ETHERSCAN_KEY --verify"
fi
# Run script to deploy and verify
forge script \
  script/"$FILE_NAME":"$CONTRACT_NAME" \
  --rpc-url "$RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --broadcast \
  -vvvv \
  -- "$VERIFICATION_COMMANDS"
