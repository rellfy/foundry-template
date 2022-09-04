// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract TestUtils is Test {
    function useExpectOwnership(address impersonator) internal {
        // The call should revert.
        vm.expectRevert("Ownable: caller is not the owner");
        // Impersonate address for the next call.
        vm.prank(impersonator);
    }
}