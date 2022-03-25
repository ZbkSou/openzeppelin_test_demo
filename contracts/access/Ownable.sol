pragma solidity ^0.8.0;
import "../utils/Context.sol";
abstract contract Ownable is Context{
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor(){
        _transferOwnership(_msgSender());
    }
    /**
    * 返回所有者
    */
    function owner() public view virtual returns (address){
        return _owner;
    }

    modifier onlyOwner(){
        require(owner() == _msgSender(),"Ownable: caller is not the owner");
        _;
    }

    /**
    * 放弃合约所有权只能由所有者调用
    */
    function renounceOwnership() public virtual onlyOwner{
        _transferOwnership(address(0));
    }

    /**
    *
    */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0),"Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }


    /**
    * 传递所有权
    */
    function _transferOwnership(address newOwner) internal virtual {
        address  oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
