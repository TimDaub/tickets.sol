// @format
// SPDX-License-Identifier: GPL-3.0-only
// Copyright (c) Tim Daubenschütz.
pragma solidity ^0.8.6;
import "ds-test/test.sol";

import "./Tickets.sol";
import "indexed-sparse-merkle-tree/StateTree.sol";

contract TicketsTest is DSTest {
    Tickets t;

    receive() external payable { }

    function setUp() public {
        t = new Tickets();
    }

    function testInit() external {
        uint256 price = 1;
        t.init(price);
        assertEq(t.roots(address(this)), StateTree.empty());
        assertEq(t.prices(address(this)), price);
    }

    function testBuyAndValidate() external {
        uint256 price = 1;
        t.init(price);
        assertEq(t.roots(address(this)), StateTree.empty());
		bytes32[] memory proofs = new bytes32[](0);
        t.buy{value: 1}(proofs, address(this));
        assertEq(t.indexes(address(this)), 1);
		bytes32[] memory proofs2 = new bytes32[](1);
        proofs2[0] = keccak256(abi.encode(address(this)));
        assertTrue(t.validate(proofs2, 0, address(this), address(this)), "resulting tree is false");
    }

    function testBalanceAndWithdrawing() external {
        uint256 price = 1;
        t.init(price);
        assertEq(t.roots(address(this)), StateTree.empty());
		bytes32[] memory proofs = new bytes32[](0);
        t.buy{value: 1}(proofs, address(this));
        assertEq(t.indexes(address(this)), 1);
		bytes32[] memory proofs2 = new bytes32[](1);
        proofs2[0] = keccak256(abi.encode(address(this)));
        assertTrue(t.validate(proofs2, 0, address(this), address(this)), "resulting tree is false");

        assertEq(address(t).balance, 1);
        assertEq(t.indexes(address(this)), 1);
        assertEq(t.prices(address(this)), 1);
        t.withdraw();
        assertEq(address(t).balance, 0);
    }
}
