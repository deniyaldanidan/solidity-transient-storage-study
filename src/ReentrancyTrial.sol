// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract ReentrancyTrial {
    bool transient locked;
    mapping(address => uint256) userBalance;

    modifier nonReentrantLock() {
        require(!locked, "Reentrancy Lock is enabled");
        locked = true;
        _;

        locked = false; // cleanup
    }

    function deposit() external payable {
        require(msg.value > 0, "zero amount not allowed");
        userBalance[msg.sender] += msg.value;
    }

    function withdraw() external {
        _withdraw();
    }

    function withdrawWithGuard() external nonReentrantLock {
        uint256 bal = userBalance[msg.sender];
        require(bal > 0, "Insufficient Balance");

        (bool success, ) = payable(msg.sender).call{value: bal}("");
        require(success, "transfer failed");

        userBalance[msg.sender] = 0;
    }

    function _withdraw() internal {
        uint256 bal = userBalance[msg.sender];
        require(bal > 0, "Insufficient Balance");

        (bool success, ) = payable(msg.sender).call{value: bal}("");
        require(success, "transfer failed");

        userBalance[msg.sender] = 0;
    }
}
