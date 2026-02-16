// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test, console2} from "../lib/forge-std/src/Test.sol";

import {TransientClash} from "../src/TransientClash.sol";

contract TransientClashTest is Test {
    TransientClash clashContract;

    address user = makeAddr("user");

    function setUp() external {
        clashContract = new TransientClash();
        vm.deal(user, 10 ether);
    }

    function testClash() external {
        vm.startPrank(user);

        clashContract.deposit{value: 10 ether}();

        clashContract.withdrawHalf();

        vm.expectRevert("ReentrancyLock is ON!");
        clashContract.withdrawAll();

        vm.stopPrank();
    }
}
