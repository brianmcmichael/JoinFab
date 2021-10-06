// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2021 Dai Foundation
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
pragma solidity 0.5.12;

import {GemJoin}        from "dss/join.sol";
import {GemJoin2}       from "dss-gem-joins/join-2.sol";
import {GemJoin3}       from "dss-gem-joins/join-3.sol";
import {GemJoin4}       from "dss-gem-joins/join-4.sol";
import {GemJoin5}       from "dss-gem-joins/join-5.sol";
import {GemJoin6}       from "dss-gem-joins/join-6.sol";
import {GemJoin7}       from "dss-gem-joins/join-7.sol";
import {GemJoin8}       from "dss-gem-joins/join-8.sol";
import {AuthGemJoin}    from "dss-gem-joins/join-auth.sol";

contract GemJoinFab {
    // GemJoin
    // Standard ERC-20 Join Adapter
    function newGemJoin(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract GemJoin2Fab {
    // GemJoin2
    // For a token that does not return a bool on transfer or transferFrom (like OMG)
    // This is one way of doing it. Check the balances before and after calling a transfer
    function newGemJoin2(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin2(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract GemJoin3Fab {
    // GemJoin3
    // For a token that has a lower precision than 18 and doesn't have decimals field in place (like DGD)
    function newGemJoin3(address _vat, address _owner, bytes32 _ilk, address _gem, uint256 _dec) external returns (address join) {
        join = address(new GemJoin3(_vat, _ilk, _gem, _dec));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract GemJoin4Fab {
    // GemJoin4
    // For tokens that do not implement transferFrom (like GNT), meaning the usual adapter
    // approach won't work: the adapter cannot call transferFrom and therefore
    // has no way of knowing when users deposit gems into it.
    //
    // To work around this, we introduce the concept of a bag, which is a trusted
    // (it's created by the adapter), personalized component (one for each user).
    //
    // Users first have to create their bag with `GemJoin4.make`, then transfer
    // gem to it, and then call `GemJoin4.join`, which transfer the gems from the
    // bag to the adapter.
    function newGemJoin4(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin4(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract GemJoin5Fab {
    // GemJoin5
    // For a token that has a lower precision than 18 and it has decimals (like USDC)
    function newGemJoin5(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin5(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract GemJoin6Fab {
    // GemJoin6
    // For a token with a proxy and implementation contract (like tUSD)
    //  If the implementation behind the proxy is changed, this prevents joins
    //   and exits until the implementation is reviewed and approved by governance.
    function newGemJoin6(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin6(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract GemJoin7Fab {
    // GemJoin7
    // For an upgradable token (like USDT) which doesn't return bool on transfers and may charge fees
    //  If the token is deprecated changing the implementation behind, this prevents joins
    //   and exits until the implementation is reviewed and approved by governance.
    function newGemJoin7(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin7(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract GemJoin8Fab {
    // GemJoin8
    // For a token that has a lower precision than 18, has decimals and it is upgradable (like GUSD)
    function newGemJoin8(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin8(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract AuthGemJoinFab {
    // AuthGemJoin
    // For a token that needs restriction on the sources which are able to execute the join function (like SAI through Migration contract)
    function newAuthGemJoin(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new AuthGemJoin(_vat, _ilk, _gem));
        GemJoin(join).rely(_owner);
        GemJoin(join).deny(address(this));
    }
}

contract JoinFab {

    address public vat;

    GemJoinFab     gemJoinFab;
    GemJoin2Fab    gemJoin2Fab;
    GemJoin3Fab    gemJoin3Fab;
    GemJoin4Fab    gemJoin4Fab;
    GemJoin5Fab    gemJoin5Fab;
    GemJoin6Fab    gemJoin6Fab;
    GemJoin7Fab    gemJoin7Fab;
    GemJoin8Fab    gemJoin8Fab;
    AuthGemJoinFab authGemJoinFab;

    // Emit the join address and the calldata used to create it
    event NewJoin(address indexed join, bytes data);

    constructor(address _vat) public {
        vat            = _vat;
        gemJoinFab     = new GemJoinFab();
        gemJoin2Fab    = new GemJoin2Fab();
        gemJoin3Fab    = new GemJoin3Fab();
        gemJoin4Fab    = new GemJoin4Fab();
        gemJoin5Fab    = new GemJoin5Fab();
        gemJoin6Fab    = new GemJoin6Fab();
        gemJoin7Fab    = new GemJoin7Fab();
        gemJoin8Fab    = new GemJoin8Fab();
        authGemJoinFab = new AuthGemJoinFab();
    }

    function newGemJoin(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoinFab.newGemJoin(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newGemJoin2(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoin2Fab.newGemJoin2(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newGemJoin3(address _owner, bytes32 _ilk, address _gem, uint256 _dec) external returns (address join) {
        join = gemJoin3Fab.newGemJoin3(vat, _owner, _ilk, _gem, _dec);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem, _dec));
    }

    function newGemJoin4(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoin4Fab.newGemJoin4(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newGemJoin5(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoin5Fab.newGemJoin5(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newGemJoin6(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoin6Fab.newGemJoin6(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newGemJoin7(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoin7Fab.newGemJoin7(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newGemJoin8(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoin8Fab.newGemJoin8(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newAuthGemJoin(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = authGemJoinFab.newAuthGemJoin(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }
}
