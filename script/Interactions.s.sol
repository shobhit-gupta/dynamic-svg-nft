// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {NFT} from "../src/NFT.sol";

contract MintNFT is Script {
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function mintNFTOnContract(address nft) public {
        vm.startBroadcast();
        NFT(nft).mintNFT(PUG);
        vm.stopBroadcast();
    }

    function run() external {
        address latestDeployedNFT = DevOpsTools.get_most_recent_deployment(
            "NFT",
            block.chainid
        );
        mintNFTOnContract(latestDeployedNFT);
    }
}
