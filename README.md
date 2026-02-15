# Transient Storage Study

> [!TIP]
> **Transient Storage** is a Key-Value pair like Storage but only exists in Single Transaction.

## Simple demonstration of TransientStorage [Assume everything is in one Transaction]
```c
push1 0xff // [0xff]
push1 0x00 // [0x00, 0xff]
tstore // slot 0 value 0xff

push1 0xfa // [0xfa]
push1 0x01 // [0x00, 0xfa]
tstore // slot 1 value 0xfa

push1 0xa2 // [0xa2]
push1 0x02 // [0x02, 0xa2]
tstore // slot 2 value 0xa2

// load from slot 0
push1 0x00
tload

// load from slot 2
push1 0x02
tload
```


> [!WARNING]
> Transient storage as defined by EIP-1153 can break the composability of smart contracts: Since transient storage is cleared only at the end of the transaction and not at the end of the outermost call frame to the contract within a transaction, your contract may unintentionally misbehave when invoked multiple times in a complex transaction. To avoid this, be sure to clear all transient storage at the end of any call to your contract. The use of transient storage for reentrancy guards that are cleared at the end of the call is safe.(2394). _- EXTRACTED (COPIED) FROM VSCODE WARNING_

## References:
- https://eips.ethereum.org/EIPS/eip-1153
- https://coinsbench.com/transient-storage-an-efficient-temporary-data-solution-in-solidity-b2fdd3563625
- https://medium.com/@organmo/demystifying-eip-1153-transient-storage-faeabbadd0d
- https://www.soliditylang.org/blog/2024/01/26/transient-storage/
- https://www.cyfrin.io/glossary/transient-storage-solidity-code-example
- https://solidity-by-example.org/transient-storage/

### Other Useful links:
- https://solidity-by-example.org/hacks/re-entrancy/
- https://hacken.io/discover/uniswap-v4-transient-storage-security/
- https://hacken.io/discover/auditing-uniswap-v4-hooks/

- https://youtu.be/0-hiB5I39Mk?si=z9Ax9LlixfkCXowh
- https://youtu.be/wESjoSXZB2M?si=xYDCgwTMfKshsiAm
- https://www.youtube.com/@HappyGill-n7c/videos

---