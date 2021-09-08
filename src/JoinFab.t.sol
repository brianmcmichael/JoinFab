// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity >=0.5.12;

import "ds-test/test.sol";

import "./JoinFab.sol";

contract JoinFabTest is DSTest {
    JoinFab joinFab;

    function setUp() public {
        joinFab = new JoinFab();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
