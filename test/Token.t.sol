// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Token.sol";

contract TokenTest is Test {
    Token public token;
    
    function setUp() public {
       token = new Token("Token", "TKN", 18);
    }

    function testDecimals() public {
        assertEq(token.decimals(), 18);
    }

    function testMint() public {
        token.mint(msg.sender, 1 ether);
        assertEq(token.balanceOf(msg.sender), 1 ether);
    }

    function testBurn() public {
        testMint();
        token.burn(msg.sender, 1 ether);
        assertEq(token.balanceOf(msg.sender), 0);
    }

    function testMintOwnership() public {
        address impersonator = useExpectOwnership();
        token.mint(impersonator, 1 ether);
    }

    function testBurnOwnership() public {
        address impersonator = useExpectOwnership();
        token.burn(impersonator, 1 ether);
    }

    function useExpectOwnership() private returns (address) {
        // The call should revert.
        vm.expectRevert("Ownable: caller is not the owner");
        // Impersonate address for the next call.
        address impersonator = 0xBEeFbeefbEefbeEFbeEfbEEfBEeFbeEfBeEfBeef;
        vm.prank(impersonator);
        return impersonator;
    }
}
