# Transient Storage Study

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