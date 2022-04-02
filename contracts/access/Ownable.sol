pragma solidity ^0.8.0;
import "../utils/Context.sol";
abstract contract Ownable is Context{
    address private _owner;

    /**
     * @notice 所有权交换
     * @param  previousOwner 之前的所有者
     * @param  newOwner 新所有者
     */
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(){
        _transferOwnership(_msgSender());
    }
    /**
     * @notice 返回所有者
     * @return address
     */
    function owner() public view virtual returns (address){
        return _owner;
    }

    /**
     * @notice 检查调用者是否为所有者
     * @param
     * @return
     */
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
    * 对外交换所有权，只能当前所有者执行
    */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0),"Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }


    /**
    * 传递所有权实际方法
    */
    function _transferOwnership(address newOwner) internal virtual {
        address  oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
