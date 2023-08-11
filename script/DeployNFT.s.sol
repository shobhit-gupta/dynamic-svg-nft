// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {NFT} from "../src/NFT.sol";

contract DeployNFT is Script {
    function run() external returns (NFT) {
        vm.startBroadcast();
        NFT nft = new NFT();
        vm.stopBroadcast();
        return nft;
    }
}
