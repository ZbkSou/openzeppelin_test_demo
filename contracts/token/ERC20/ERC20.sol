pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./extensions\IEC20Metadata.sol";
import "..\..\utils\Context.sol";

contract ERC20 is Context, IERC20, IEC20Metadata {
    //保存地址对应之持有的代币数量
    mapping(address => uint265) private _balances;
    //    保存被授权的代币
    mapping(address => mapping(address => uint256)) private _allowances;

    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_){
        _name = name_;
        _symbol = symbol_;
    }

}

}
