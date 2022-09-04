// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Token.sol";
import "./Utils.sol";

contract TokenTest is Test, TestUtils {
    Token public token;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() public {
       token = new Token("Token", "TKN", 18);
    }

    function testDecimals() public {
        assertEq(token.decimals(), 18);
    }

    function testMint() public {
        token.mint(address(this), 1 ether);
        assertEq(token.balanceOf(address(this)), 1 ether);
    }

    function testBurn() public {
        testMint();
        token.burn(address(this), 1 ether);
        assertEq(token.balanceOf(address(this)), 0);
    }

    function testMintOwnership() public {
        useExpectOwnership(msg.sender);
        token.mint(msg.sender, 1 ether);
    }

    function testBurnOwnership() public {
        useExpectOwnership(msg.sender);
        token.burn(msg.sender, 1 ether);
    }

    function testTransferEvent() public {
        testMint();
        // Refer to https://book.getfoundry.sh/forge/cheatcodes for details.
        vm.expectEmit(true, true, true, true);
        // The expected event.
        emit Transfer(address(this), msg.sender, 0.01 ether);
        // Trigger emit of actual event.
        token.transfer(msg.sender, 0.01 ether);
    }
}
