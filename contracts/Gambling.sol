// SPDX-License-Identifier: MIT

import "./GMB.sol";

pragma solidity ^0.8.3;

contract Gambling {

    GMBToken gmbTokenContract;

    constructor(address GMBContractAddr) {
        gmbTokenContract = GMBToken(GMBContractAddr);
    }

    struct participationData {
        uint gmbToken;
        uint betValue;
    }

    mapping (address => participationData) participations;
    
    function participate(uint gmbToken, uint betValue) public {
        address accountAddr = msg.sender;
        require(gmbToken > 0, "GMB token must be more than zero");
        require(participations[accountAddr].gmbToken == 0, 
                "You cannot participate in gambling more than once");
        
        //TODO: Check if sender has LPTokens
        //TODO: Lock LPTokens

        participations[accountAddr].gmbToken = gmbToken;
        participations[accountAddr].betValue = betValue;
        
        //Send GMB tokens from the user to the gamblingContract
        gmbTokenContract.transferToAdmin(accountAddr, gmbToken);
    }
}