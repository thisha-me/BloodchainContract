// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.9;

contract BloodReq {

    struct BloodRequest {
        address requester;
        string pname;
        string contactNum;
        string district;
        string province;
        string donationCenter;
        string bloodType;
        uint256 timestamp;
        bool fulfilled;
    }

}