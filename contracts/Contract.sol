// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MyContract {
    mapping(address => string) public walletIds;

    function connectWallet(string calldata _walletId) public {
        walletIds[msg.sender] = _walletId;
    }

    function getWalletId() public view returns (string memory) {
        return walletIds[msg.sender];
    }
}