// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.9.0;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        string memory happySVG = vm.readFile("./img/happy.svg");
        string memory sadSVG = vm.readFile("./img/sad.svg");

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(
            svgToImageURI(happySVG),
            svgToImageURI(sadSVG)
        );
        vm.stopBroadcast();
        return moodNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        // Example:
        // Params:
        // - svg: <svg xmlns="http://www.w3.org/2000/svg" width="500" ...>
        // Returns:
        // data:image/svg+xml;base64,PHN2ZyB2aWV3Qm...
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
