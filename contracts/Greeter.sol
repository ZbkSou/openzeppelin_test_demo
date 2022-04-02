//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
interface Simpson {
    function is2D() external view returns (bytes4);
    function skinColor() external view returns (bytes4);
}
contract Greeter is Simpson{
    string private greeting;
    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }
    function greet() public view returns (string memory) {
        return greeting;
    }
    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
    function is2DandSkinColor() external view returns (bytes4){
        bytes4 is2D = 0x60c33c60;
        return type(Simpson).interfaceId;
    }
    function is2D() external override view  returns (bytes4){
        return this.is2D.selector;
    }
    function skinColor() external override view returns (bytes4){
        return this.skinColor.selector;
    }
}
