// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Joinfab.sol";

contract JoinfabTest is DSTest {
    Joinfab joinfab;

    function setUp() public {
        joinfab = new Joinfab();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
