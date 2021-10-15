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
import {GemJoin5}       from "dss-gem-joins/join-5.sol";
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

contract GemJoin5Fab {
    // GemJoin5
    // For a token that has a lower precision than 18 and it has decimals (like USDC)
    function newGemJoin5(address _vat, address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = address(new GemJoin5(_vat, _ilk, _gem));
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
    GemJoin5Fab    gemJoin5Fab;
    AuthGemJoinFab authGemJoinFab;

    // Emit the join address and the calldata used to create it
    event NewJoin(address indexed join, bytes data);

    constructor(address _vat) public {
        vat            = _vat;
        gemJoinFab     = new GemJoinFab();
        gemJoin5Fab    = new GemJoin5Fab();
        authGemJoinFab = new AuthGemJoinFab();
    }

    function newGemJoin(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoinFab.newGemJoin(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newGemJoin5(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = gemJoin5Fab.newGemJoin5(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }

    function newAuthGemJoin(address _owner, bytes32 _ilk, address _gem) external returns (address join) {
        join = authGemJoinFab.newAuthGemJoin(vat, _owner, _ilk, _gem);
        emit NewJoin(join, abi.encode(vat, _ilk, _gem));
    }
}
