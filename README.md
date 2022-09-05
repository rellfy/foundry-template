# foundry-template
A ✨ blazing fast ✨template for template for Solidity development with [Foundry][1].

Refer to the [📖 Foundry Book][2] for documentation on Foundry.

## Structure
- `lib/`: git submodules containing dependency repositories
- `script/`: Solidity scripts (e.g. deployment)
- `src/`: Solidity source
- `test/`: Solidity tests
- `deploy.sh`: Deployment helper script

## Commands
### Running unit tests
```shell
forge test
```

### Deploying via script
The helper script works on Unix-like systems (e.g. Linux/Mac)

1. Configure the `.env` file (see `.env.development`)
2. Run the helper script, passing the script name as the first argument.
For example, to deploy `src/Token.sol` with `script/DeployToken.s.sol`:
```shell
./deploy DeployToken
```

[1]: https://github.com/foundry-rs/foundry
[2]: https://book.getfoundry.sh
