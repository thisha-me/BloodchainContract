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

    // mapping of requesters to their blood requests
    mapping(address => BloodRequest) public bloodRequests;

    function submitBloodReq(
        string memory _pname, 
        string memory _contactNum, 
        string memory _district, 
        string memory _province, 
        string memory _donationCenter, 
        string memory _bloodType
    ) public {
        
        BloodRequest memory newRequest = BloodRequest({
            requester: msg.sender,
            pname: _pname,
            contactNum: _contactNum,
            district: _district,
            province: _province,
            donationCenter: _donationCenter,
            bloodType: _bloodType,
            timestamp: block.timestamp,
            fulfilled: false
        });
        bloodRequests[msg.sender] = newRequest;
    }
}