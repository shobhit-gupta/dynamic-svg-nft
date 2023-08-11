// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../../script/DeployMoodNFT.s.sol";
import {MoodNFT} from "../../src/MoodNFT.sol";

contract MoodNFTIntegrationTest is Test {
    DeployMoodNFT s_deployer;
    MoodNFT private s_moodNFT;
    address private s_user = makeAddr("user");

    function setUp() public {
        s_deployer = new DeployMoodNFT();
        s_moodNFT = s_deployer.run();
    }

    function testIntegration_viewTokenURI() public {
        vm.prank(s_user);
        s_moodNFT.mintNFT();
        console.log(s_moodNFT.tokenURI(0));
    }

    function test_flipTokenToSad() public {
        vm.startPrank(s_user);
        s_moodNFT.mintNFT();
        assert(s_moodNFT.s_moods(0) == MoodNFT.Mood.HAPPY);
        s_moodNFT.flipMood(0);
        vm.stopPrank();
        assert(s_moodNFT.s_moods(0) == MoodNFT.Mood.SAD);
    }
}
