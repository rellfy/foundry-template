// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFT.sol";
import "./Utils.sol";

contract NftTest is Test, TestUtils {
    NFT public nft;

    function setUp() public {
       nft = new NFT(
            "ERC721Token",
            "NFT",
            100,
            address(1337),
            "https://the.future.of.money.is.ape.pictures.com/"
       );
    }

    function testMintNotInitiallyActive() public {
        assertEq(nft.isMintEnabled(), false);
    }

    function testMintToggle() public {
        nft.toggleMintStatus();
        assertEq(nft.isMintEnabled(), true);
    }

    function testMinToggleOwnership() public {
        useExpectOwnership(msg.sender);
        nft.toggleMintStatus();
    }

    function testMintDuringInactive() public {
        vm.expectRevert("Minting is not enabled");
        nft.mint(1, address(1337));
    }

    function testMintOwnership() public {
        testMintToggle();
        useExpectOwnership(msg.sender);
        nft.mint(100, msg.sender);
    }
}
