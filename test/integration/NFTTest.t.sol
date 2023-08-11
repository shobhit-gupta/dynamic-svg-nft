// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.9.0;

import {Test} from "forge-std/Test.sol";
import {DeployNFT} from "../../script/DeployNFT.s.sol";
import {NFT} from "../../src/NFT.sol";

contract NFTTest is Test {
    NFT s_nft;
    address public s_user = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external {
        DeployNFT deployer = new DeployNFT();
        s_nft = deployer.run();
    }

    function test_nameIsCorrect() public view {
        string memory expectedName = "Atomic";
        string memory actualName = s_nft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function test_mint_updatesBalance() public {
        vm.prank(s_user);
        s_nft.mintNFT(PUG);
        assert(s_nft.balanceOf(s_user) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(s_nft.tokenURI(0)))
        );
    }
}
