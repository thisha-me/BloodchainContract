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

    struct UserDetails{
        string name;
        string contactNum;
        string email;
        uint256 age;
        string bloodType;
        uint256 donationCount;
        BloodRequest[] bloodRequestsHistory;
    }

    mapping(address => UserDetails) public userDetails;

    // mapping of requesters to their blood requests
    mapping(address => BloodRequest) public bloodRequests;

    // array of requesters
    address[] public requesters;

    address[] public users;

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
    function getBloodReq() public view returns (
        address, 
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        uint256, 
        bool
    ) {
        BloodRequest memory request = bloodRequests[msg.sender];
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
    ) {
        BloodRequest memory request = bloodRequests[_requester];
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


    function getRequests() public view returns (address[] memory) {
        return requesters;
    }

    // get all blood requests
    function getAllRequests() public view returns (BloodRequest[] memory) {
        BloodRequest[] memory requests = new BloodRequest[](requesters.length);
        for(uint i=0; i<requesters.length; i++) {
            requests[i] = bloodRequests[requesters[i]];
        }
        return requests;
    }

    function registerUser(string memory _name) public {
        userDetails[msg.sender].name = _name;
        userDetails[msg.sender].donationCount=0;

        for(uint i=0; i<users.length; i++) {
            if(users[i] == msg.sender) {
                return;
            }
        }
        users.push(msg.sender);
    }

    function fulfillBloodReq(address _donator) public {
        userDetails[_donator].donationCount++;
        bloodRequests[msg.sender].fulfilled=true;
    }

    function getUserDetails() public view returns (
        string memory, 
        uint256) {
        return (
            userDetails[msg.sender].name, 
            userDetails[msg.sender].donationCount
            );
    }

    function getUserDetailsById(address _user) public view returns (
        string memory, 
        uint256) {
        return (
            userDetails[_user].name, 
            userDetails[_user].donationCount
            );
    }

    function getUsers() public view returns (address[] memory) {
        return users;
    }
    
}