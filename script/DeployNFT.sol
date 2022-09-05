// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./Utils.sol";
import "../src/NFT.sol";

contract DeployNFT is Script, DeployUtils {
    string constant NAME = "TOKEN";
    string constant SYMBOL = "TKN";
    uint8 constant MAX_SUPPLY = 18;
    address constant FIXED_OWNER = address(0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF);
    string constant BASE_URI = "https://i.need.token.price.go.up/";

    function run() public {
        deploy();
    }

    // All code in this function is broadcast to the blockchain.
    function deploy() public broadcastCode {
        new NFT(NAME, SYMBOL, MAX_SUPPLY, FIXED_OWNER, BASE_URI);
    }
}
