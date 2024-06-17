// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract CharityDonation {
    address public owner;
    mapping(address => uint256) public donations;
    event DonationReceived(address indexed donor, uint256 amount);
    constructor() {
        owner = msg.sender;
    }
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than 0");
        donations[msg.sender] += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }
    function getDonation(address _donor) public view returns (uint256) {
        return donations[_donor];
    }
    function withdraw(uint256 _amount) public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(owner).transfer(_amount);
    }
    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
