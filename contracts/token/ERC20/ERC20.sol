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

    uint256 private  _totalSupply;

    constructor(string memory name_, string memory symbol_){
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns (string memory){
        return _name;
    }

    function symbol() public view virtual override returns (string memory){
        return _symbol;
    }

    /**
     * @notice decimals 用来标记小数点位置，18就是在10 的18次方上
     * @return
     */
    function decimals() public view virtual override returns (uint8){
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256){
        return _totalSupply;
    }
    /**
     * @notice 返回地址的token数量
     * @return
     */
    function balanceOf(address account) public view virtual override returns (uint256){
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool){
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @notice 获取授权额度
     * @return
     */
    function allowance(address owner, address spender) public view virtual overide returns (uint256){
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool){
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool){
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool){
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }
    /**
    * @dev 减少授权金额
    * （unchecked或wrapping）截断模式 既不处理溢出如果溢出直接输出结果
    * 如果不设置默认为 checked 模式 如果溢出会异常退回
    */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool){
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
    unchecked{
        _approve(owner, spender, currentAllowance - subtractedValue);
    }
        return true;
    }


    function _transfer(address from, address to, uint256 amount) internal virtual {

    }

}
