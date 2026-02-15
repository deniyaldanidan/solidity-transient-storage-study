// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {TransientStudy2} from "../src/TransientStudy.sol";
import {BaseTransientStudyTest} from "./BaseTransientStudy1Test.t.sol";

contract TransientStudy2Test is BaseTransientStudyTest {
    function setUp() public override {
        study = new TransientStudy2();
    }
}
