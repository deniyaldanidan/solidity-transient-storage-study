// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface ITransientStudy {
    function storeT() external;

    function multiplyT() external;

    function viewT() external view returns (uint256 myVal);
}

contract TransientStudy1 is ITransientStudy {
    bytes32 public constant MY_TRANSIENT_SLOT =
        0x3a2dc4f178a05471b2399015de6aff9e11b6f56295ee4c97ab1aefce79cd1f13;
    // bytes32(uint256(keccak256("MY_TRANSIENT_SLOT")) - 1)

    function storeT() public {
        assembly {
            tstore(MY_TRANSIENT_SLOT, 100)
        }
    }

    function multiplyT() public {
        assembly {
            tstore(MY_TRANSIENT_SLOT, mul(5, tload(MY_TRANSIENT_SLOT)))
        }
    }

    function viewT() public view returns (uint256 myVal) {
        assembly {
            myVal := tload(MY_TRANSIENT_SLOT)
        }
    }
}

contract TransientStudy2 is ITransientStudy {
    uint256 transient trnValue;

    function storeT() public {
        trnValue = 100;
    }

    function multiplyT() public {
        trnValue = trnValue * 5;
    }

    function viewT() public view returns (uint256) {
        return trnValue;
    }
}
