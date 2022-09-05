#!/bin/bash
# Check if input is correct.
if [ -z "$1" ]; then
  echo "usage: ./deploy.sh ScriptName"
  exit 1
fi
# Load environment variables
source .env
# Run script to deploy and verify
FILE_NAME=$1.s.sol
CONTRACT_NAME=$1
echo Deploying with script: "$FILE_NAME"
forge script \
  script/"$FILE_NAME":"$CONTRACT_NAME" \
  --rpc-url "$RPC_URL" \
  --private-key "$PRIVATE_KEY" \
  --etherscan-api-key "$ETHERSCAN_KEY" \
  --broadcast \
  --verify \
  -vvvv
