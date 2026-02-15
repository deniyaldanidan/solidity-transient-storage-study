// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test, console2} from "../lib/forge-std/src/Test.sol";
import {TransientStudy1, ITransientStudy} from "../src/TransientStudy.sol";

abstract contract BaseTransientStudyTest is Test {
    ITransientStudy study;

    function setUp() public virtual {
        study = new TransientStudy1();
    }

    function testTransientStudy() external {
        uint256 initialTrVal = study.viewT();
        study.storeT();
        uint256 storedVal = study.viewT();
        study.multiplyT();
        uint256 multipliedVal = study.viewT();

        console2.log(initialTrVal, storedVal, multipliedVal);

        assertEq(initialTrVal, 0);
        assertEq(storedVal, 100);
        assertEq(multipliedVal, 500);

        // Since this is a single transaction the Transient State will persist
    }

    function testTransientWontPersist() external view {
        uint256 storedValue = study.viewT();

        assertEq(storedValue, 0);
        console2.log(storedValue);
    }
}
