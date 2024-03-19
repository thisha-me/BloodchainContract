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

    // array of requesters
    address[] public requesters;

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

        for(uint i=0; i<requesters.length; i++) {
            if(requesters[i] == msg.sender) {
                return;
            }
        }
        requesters.push(msg.sender);
    }

    // Function to retrieve a blood donation request by the requester's address
    function getBloodReqById(address _requester) public view returns (
        address, 
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        uint256, 
        bool
    ){
        // Retrieve the BloodRequest struct associated with the provided requester address
        BloodRequest memory request = bloodRequests[_requester];
        // Return the components of the BloodRequest struct as a tuple
        return (
            request.requester,
            request.pname,
            request.contactNum,
            request.district,
            request.province,
            request.donationCenter,
            request.bloodType,
            request.timestamp,
            request.fulfilled
        );
    }


    function fulfillBloodReqById(address _requester) public {
        bloodRequests[_requester].fulfilled = true;
    }

    function fulfillBloodReq() public {
        bloodRequests[msg.sender].fulfilled = true;
    }

    function getRequests() public view returns (address[] memory) {
        return requesters;
    }
}