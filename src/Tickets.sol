// @format
pragma solidity ^0.8.6;

import "indexed-sparse-merkle-tree/StateTree.sol";

contract Tickets {
    bytes32 public root;

    constructor(address _owner) {
        root = StateTree.empty();
    }

    function enter(
        string calldata _entry,
        bytes32[] calldata _proofs,
        uint8 _bits
    ) public payable {
        require(msg.value > 0);
        root = StateTree.write(
            _proofs,
            _bits,
            size,
            keccak256(abi.encode(_entry)),
            0x290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563,
            root
        );
        size += 1;
        emit Entry(msg.sender, _entry, msg.value);
    }
}
