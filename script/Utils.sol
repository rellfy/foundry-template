// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract DeployUtils is Script {
    modifier broadcastCode() {
        vm.startBroadcast();
        _;
        vm.stopBroadcast();
    }
}
