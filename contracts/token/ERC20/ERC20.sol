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
    /**
    * @dev 授权额度
    */
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
        unchecked {
    _approve(owner, spender, currentAllowance - subtractedValue);
    }
        return true;
    }


    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        _beforeTokenTransfer(from, to, amount);
        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
    _balances[from] = fromBalance - amount;
    }
        _balances[to] += amount;
        emit Transfer(from, to, amount);
        _afterTokenTransfer(from, to, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20 : mint to the zero address");
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, amount);
    }
    /**
    * @dev 销毁代币， 其实就是向地址0转账
    */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
    _balances[account] = accountBalance - amount;
    }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }
    /**
    * @dev 授权代币
    */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    /**
    * @dev  减少 amount 授权额度,实际支付需要调用支付
    */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
        unchecked {
        _approve(owner, spender, currentAllowance - amount);
        }
        }
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}
