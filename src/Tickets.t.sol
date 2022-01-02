// @format
pragma solidity ^0.8.6;
import "ds-test/test.sol";

import "./Tickets.sol";

contract TicketsTest is DSTest {
    Tickets t;

    receive() external payable { }
    function setUp() public {
        t = new Tickets(address(this));
    }
}
