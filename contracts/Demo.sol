//SPDX-License-Identifier: Unlicense
// memory storage calldata 说明 https://zhuanlan.zhihu.com/p/147766946
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./access/Ownable.sol";
import "./utils/Strings.sol";
contract Demo is Ownable{
    using Strings for uint256;
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

    // 使用 utils/Strings 实例
    // 度状态变量得时候用view 修饰，没有读用pure
    function intToString(uint256  number) public pure returns (string memory){
       return number.toString();
    }




}
