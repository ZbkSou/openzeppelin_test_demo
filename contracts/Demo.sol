//SPDX-License-Identifier: Unlicense
// memory storage calldata 说明 https://zhuanlan.zhihu.com/p/147766946
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./access/Ownable.sol";

contract Demo is Ownable{
    string private greeting;
    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }

    function getGreeting() public view returns (string memory){
        return greeting;
    }
    // 使用 onlyOwner() 检查调用者只能是合约所有者
    function setGreeting(string memory greet) public onlyOwner() {
        greeting = greet;
    }


}
