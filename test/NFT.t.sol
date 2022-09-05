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
    
    function testMint() public {
        testMintToggle();
        nft.mint(5, msg.sender);
        assertEq(nft.getLastTokenId(), 5);
    }
    
    function testTokenUri() public {
        testMint();
        uint256 currentTokenId = nft.getLastTokenId();
        bytes memory currentTokenUri = bytes(nft.tokenURI(currentTokenId));
        bytes memory baseUri = bytes(nft.getBaseURI());
        bytes memory fullUri = abi.encodePacked(
            baseUri,
            "/",
            currentTokenId,
            ".json"
        );
        assertEq(keccak256(currentTokenUri), keccak256(fullUri));
    }

    function testNonexistentTokenUri() public {
        testMint();
        uint256 lastTokenId = nft.getLastTokenId();
        vm.expectRevert("Nonexistent token");
        nft.tokenURI(lastTokenId + 1);
    }

    function testMintLimit() public {
        testMintToggle();
        vm.expectRevert("Not enough tokens remaining to mint");
        nft.mint(101, msg.sender);
    }

    function testSetBaseTokenUri() public {
        nft.setBaseURI("https://bitcoin.is.old.tech/");
        assertEq(nft.getBaseURI(), "https://bitcoin.is.old.tech/");
    }
    
    function testRenounceOwnership() public {
        // Try renouncing as user.
        useExpectOwnership(msg.sender);
        nft.renounceOwnership();
        // Renounce as owner.
        nft.renounceOwnership();
        // Should have set owner to fixed owner address.
        assertEq(nft.owner(), address(1337));
        // Should fail to renounce again as the previous owner.
        useExpectOwnership(address(this));
        nft.renounceOwnership();
    }
}
