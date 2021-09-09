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
pragma solidity >=0.5.12;

import {GemJoin}        from "dss/join.sol";
import {GemJoin2}       from "dss-gem-joins/join-2.sol";
import {GemJoin3}       from "dss-gem-joins/join-3.sol";
import {GemJoin4}       from "dss-gem-joins/join-4.sol";
import {GemJoin5}       from "dss-gem-joins/join-5.sol";
import {GemJoin6}       from "dss-gem-joins/join-6.sol";
import {GemJoin7}       from "dss-gem-joins/join-7.sol";
import {GemJoin8}       from "dss-gem-joins/join-8.sol";
import {AuthGemJoin}    from "dss-gem-joins/join-auth.sol";

contract JoinFab {

    address public vat;

    constructor(address _vat) public {
        vat = _vat;
    }

    function newGemJoin(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new GemJoin(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function newGemJoin2(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new GemJoin2(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function newGemJoin3(address _owner, bytes32 _ilk, address _gem, uint256 _dec) external returns (address gemJoin) {
        gemJoin = address(new GemJoin3(vat, _ilk, _gem, _dec));
        authOwner(_owner, gemJoin);
    }

    function newGemJoin4(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new GemJoin4(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function newGemJoin5(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new GemJoin5(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function newGemJoin6(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new GemJoin6(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function newGemJoin7(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new GemJoin7(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function newGemJoin8(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new GemJoin8(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function newAuthGemJoin(address _owner, bytes32 _ilk, address _gem) external returns (address gemJoin) {
        gemJoin = address(new AuthGemJoin(vat, _ilk, _gem));
        authOwner(_owner, gemJoin);
    }

    function authOwner(address _owner, address _gemJoin) internal {
        GemJoin(_gemJoin).rely(_owner);
        GemJoin(_gemJoin).deny(address(this));
    }

}
