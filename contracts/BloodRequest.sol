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
        uint256 donationCount;
        uint256 age; 
        string contactNum; 
        string email;
        string bloodType; 
        BloodRequest[] bloodRequestsHistory;
        BloodRequest[] bloodDonationsHistory;
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
        userDetails[msg.sender].bloodRequestsHistory.push(newRequest);

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

    function registerUser(string memory _name, uint256 _age, string memory _contactNum, string memory _email, string memory _bloodType) public {
        userDetails[msg.sender].name = _name;
        userDetails[msg.sender].age = _age;
        userDetails[msg.sender].contactNum = _contactNum;
        userDetails[msg.sender].email = _email;
        userDetails[msg.sender].bloodType = _bloodType;
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
        userDetails[_donator].bloodDonationsHistory.push(bloodRequests[msg.sender]);
    }

    function fulfillBloodReq() public{
        bloodRequests[msg.sender].fulfilled=true;
    }


    function getUserDetails() public view returns (
        string memory,
        string memory,
        string memory, 
        uint256,
        string memory, 
        uint256,
        BloodRequest[] memory,
        BloodRequest[] memory
        ) {
        return (
            userDetails[msg.sender].name, 
            userDetails[msg.sender].contactNum,
            userDetails[msg.sender].email,
            userDetails[msg.sender].age,
            userDetails[msg.sender].bloodType,
            userDetails[msg.sender].donationCount,
            userDetails[msg.sender].bloodRequestsHistory,
            userDetails[msg.sender].bloodDonationsHistory
            );
    }

    //function to get user details from the User ID
    function getUserDetailsById(address _user) public view returns (
        string memory, 
        string memory, 
        string memory, 
        uint256, 
        string memory, 
        uint256,
        BloodRequest[] memory,
        BloodRequest[] memory) {
        return (
            userDetails[_user].name, 
            userDetails[_user].contactNum, 
            userDetails[_user].email, 
            userDetails[_user].age, 
            userDetails[_user].bloodType, 
            userDetails[_user].donationCount,
            userDetails[_user].bloodRequestsHistory,
            userDetails[_user].bloodDonationsHistory
            );
    }

    function getUsers() public view returns (address[] memory) {
        return users;
    }
    
}