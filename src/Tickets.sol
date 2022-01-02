// @format
// SPDX-License-Identifier: GPL-3.0-only
// Copyright (c) Tim Daubenschütz.
pragma solidity ^0.8.6;

import "indexed-sparse-merkle-tree/StateTree.sol";

contract Tickets {
    mapping(address => bytes32) public roots;
    mapping(address => uint256) public prices;
    mapping(address => uint256) public indexes;

    function init(uint256 _price) external {
        require(roots[msg.sender] == 0x0, "already initialized");
        roots[msg.sender] = StateTree.empty();
        prices[msg.sender] = _price;
    }

    function withdraw() external {
        uint256 balance = getBalance();
        require(balance > 0);
        payable(msg.sender).transfer(balance);
    }

    function getBalance() public view returns (uint256) {
        return prices[msg.sender] * indexes[msg.sender];
    }

    function buy(
		bytes32[] calldata _proofs,
        address _provider
    ) external payable {
        require(msg.value >= prices[_provider], "not enough eth");
        uint256 index = indexes[_provider];
        roots[_provider] = StateTree.write(
            _proofs,
            (index == 0 ? 0 : StateTree.bitmap(index)),
            index,
            keccak256(abi.encode(msg.sender)),
            0,
            roots[_provider]
        );
        indexes[_provider] += 1;
    }

	function validate(
		bytes32[] calldata _proofs,
      	uint256 _index,
        address _buyer,
        address _provider
	) external view returns (bool) {
        return StateTree.validate(
            _proofs,
            (_index == 0 ? 0 : StateTree.bitmap(_index)),
            _index,
            keccak256(abi.encode(_buyer)),
            roots[_provider]
        );
	}
}
