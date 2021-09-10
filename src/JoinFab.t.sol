// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity >=0.5.12;

import "ds-test/test.sol";

import "dss/vat.sol";
import "./JoinFab.sol";

contract MockProxy {
}

contract MockToken {
    uint8 dec;
    address impl;
    constructor(uint8 _dec) public {
        dec = _dec;
        impl = address(new MockProxy());
    }
    function decimals() external view returns (uint8) {
        return dec;
    }

    // GemJoin6
    function implementation() external view returns (address) {
        return impl;
    }
    // GemJoin7
    function upgradedAddress() external view returns (address) {
        return impl;
    }
    // GemJoin8
    function erc20Impl() external view returns (address) {
        return impl;
    }
}

contract JoinFabTest is DSTest {

    Vat vat;
    MockToken mockToken;
    MockProxy mockProxy;
    bytes32 ilk;

    JoinFab joinFab;

    function setUp() public {
        vat = new Vat();
        mockToken = new MockToken(18);
        mockProxy = new MockProxy();
        joinFab = new JoinFab(address(vat));
        ilk = "GOLD-A";
    }

    function testVat() public {
        assertEq(joinFab.vat(), address(vat));
    }

    function testGemJoin() public {
        _testJoin(address(joinFab.newGemJoin(address(mockProxy), ilk, address(mockToken))), mockToken.decimals());
    }

    function testGemJoin2() public {
        _testJoin(address(joinFab.newGemJoin2(address(mockProxy), ilk, address(mockToken))), mockToken.decimals());
    }

    function testGemJoin3() public {
        address mockToken3 = address(new MockToken(6));
        address gemJoin3 = joinFab.newGemJoin3(address(mockProxy), ilk, address(mockToken3), 6);
        _testJoin(gemJoin3, 6);
    }

    function testGemJoin4() public {
        _testJoin(address(joinFab.newGemJoin4(address(mockProxy), ilk, address(mockToken))), mockToken.decimals());
    }

    function testGemJoin5() public {
        address mockToken5 = address(new MockToken(6));
        _testJoin(address(joinFab.newGemJoin5(address(mockProxy), ilk, address(mockToken5))), 6);
    }

    function testGemJoin6() public {
        _testJoin(address(joinFab.newGemJoin6(address(mockProxy), ilk, address(mockToken))), mockToken.decimals());
    }

    function testGemJoin7() public {
        address mockToken7 = address(new MockToken(6));
        _testJoin(address(joinFab.newGemJoin7(address(mockProxy), ilk, address(mockToken7))), 6);
    }

    function testGemJoin8() public {
        address mockToken8 = address(new MockToken(2));
        _testJoin(address(joinFab.newGemJoin8(address(mockProxy), ilk, address(mockToken8))), 2);
    }

    function testAuthGemJoin() public {
        address authJoin = joinFab.newAuthGemJoin(address(mockProxy), ilk, address(mockToken));
        _testJoin(authJoin, mockToken.decimals());
    }

    function _testJoin(address _join, uint8 _dec) internal {
        assertEq(GemJoin(_join).wards(address(mockProxy)), 1);
        assertEq(GemJoin(_join).wards(address(this)), 0);
        assertEq(GemJoin(_join).dec(), _dec);
        assertEq(GemJoin(_join).live(), 1);
        assertEq(address(GemJoin(_join).vat()), address(vat));
        assertEq(GemJoin(_join).ilk(), ilk);
    }
}
