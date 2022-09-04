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
}
