// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./Utils.sol";
import "../src/Token.sol";

contract DeployToken is Script, DeployUtils {
    string constant NAME = "TOKEN";
    string constant SYMBOL = "TKN";
    uint8 constant DECIMALS = 18;
    uint256 constant OWNER_MINT = 10_000 * (10**DECIMALS);

    function run() public {
        deploy();
    }

    // All code in this function is broadcast to the blockchain.
    function deploy() public broadcastCode {
        Token token = new Token(NAME, SYMBOL, DECIMALS);
        token.mint(msg.sender, OWNER_MINT);
    }
}
