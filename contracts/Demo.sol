//SPDX-License-Identifier: Unlicense
// memory storage calldata 说明 https://zhuanlan.zhihu.com/p/147766946
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./access/Ownable.sol";
import "./utils/Strings.sol";
import "./utils/introspection/ERC165.sol";
// 接口使用
// public修饰的变量和函数，任何用户或者合约都能调用和访问。
//private修饰的变量和函数，只能在其所在的合约中调用和访问，即使是其子合约也没有权限访问。
//internal 和 private 类似，不过， 如果某个合约继承自其父合约，这个合约即可以访问父合约中定义的“内部”函数。
//external 与public 类似，只不过这些函数只能在合约之外调用 - 它们不能被合约内的其他函数调用。
interface ISimpson {
    function is2D() external returns (bool);
    function skinColor() external returns (string);
}

contract Demo is Ownable, ERC165, ISimpson{
    //
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

    // 使用 utils/Strings 示例
    // 只读取状态变量得时候用view 修饰，没有读用pure
    // 使用的时候 number.toHexString() 相当于 toHexString(number) 作为第一个参数
    function toHexString(uint256  number) public pure returns (string memory){
       return number.toHexString();
    }

    // 使用 ERC165 示例
    function supportsInterface(bytes4 interfaceID) external view returns (bool){
        // 根据 interfaceID 判断是否继承了ISimpson 或者 ERC165
        return interfaceId == type(ISimpson).interfaceId || super.supportsInterface(interfaceId);
    }

    function is2D() external returns (bool){
        return true;
    }
    function skinColor() external returns (string){
        return "red";
    }




}
