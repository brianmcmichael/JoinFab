// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity >=0.5.12;

import "ds-test/test.sol";

import "dss/vat.sol";
import "./JoinFab.sol";

contract MockProxy {

}

contract JoinFabTest is DSTest {

    Vat vat;
    MockProxy mockProxy;

    JoinFab joinFab;

    function setUp() public {
        vat = new Vat();
        mockProxy = new MockProxy();
        joinFab = new JoinFab(address(vat));
    }

    function testVat() public {
        assertEq(joinFab.vat(), address(vat));
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
