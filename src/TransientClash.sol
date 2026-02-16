// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract TransientClash {
    bool public transient lock;
    mapping(address => uint256) userBalance;

    modifier _ReentrantLock() {
        require(!lock, "ReentrancyLock is ON!");
        lock = true;
        _;
    }

    function deposit() external payable {
        require(msg.value > 0, "Zero Amount not allowed");
        userBalance[msg.sender] += msg.value;
    }

    function withdrawHalf() external _ReentrantLock {
        uint256 bal = userBalance[msg.sender];
        require(bal > 0, "Insufficient Fund");

        uint256 amount = bal / 2;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer Failed");

        userBalance[msg.sender] = amount;
    }

    function withdrawAll() external _ReentrantLock {
        uint256 bal = userBalance[msg.sender];
        require(bal > 0, "Insufficient Fund");

        (bool success, ) = payable(msg.sender).call{value: bal}("");
        require(success, "Transfer Failed");

        userBalance[msg.sender] = 0;
    }
}
