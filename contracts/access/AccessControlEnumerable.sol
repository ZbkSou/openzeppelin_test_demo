pragma solidity ^0.8.0;
import "./IAccessControlEnumerable.sol";
import "./AccessControl.sol";

/**
 * @dev 
 * @notice
 * @author zhao
 */
abstract contract AccessControlEnumerable is IAccessControlEnumerable, AccessControl{
    using EnumerableSet for EnumerablesSet.AddressSet;

    mapping(bytes32 => EnumerableSet.AddressSet) private _roleMembers;

    // 重写 supportInterface  判断是否支持 AccessControl  + IAcccessControlEnumerable （这个接口没有实现165）
    function supportsInterface( bytes4 interfaceId) public view virtual override returns (bool){
        return interfaceId == type(IAcccessControlEnumerable).interfaceId || super.supportsInterface(interfaceId);
    }
    /**
    * @notice 返回一个拥有  role 的地址, index 必须是0- getRoleMemberCount
    * 但是地址的顺序会在随时发生改变，
    * getRoleMember  和  getRoleMemberCount 需要在一个区块上执行
    */
    function getRoleMember(bytes32 role, uint256 index) public view virtual override returns (address){
        return _roleMembers[role].at(index);
    }
    /**
     * @dev 返回 role 的拥有这数量， 可用先获取数量，再通过 getRoleMember 来遍历所有地址
     */
    function getRoleMemberCount(bytes32 role) public virtual override returns (uint256){
        return _roleMembers[role].length();
    }
    /**
    * @dev
    */
    function _grantRole(bytes32 role, address account) internal virtual override {
        super._grantRole(role, account);
        _roleMembers[role].add(account);
    }

    /**
     * @dev
     */
    function _revokeRole(bytes32 role, address account) internal virtual override {
        super._revokeRole(role, account);
        _roleMembers[role].remove(account);
    }


}
