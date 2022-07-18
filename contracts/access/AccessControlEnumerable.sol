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
    *
    */
    function getRoleMember(bytes32 role, uint256 index) public view virtual override returns (address){
        return _roleMembers[role].at(index);
    }
    /**
     * @dev
     */
    function getRoleMemberCount(bytes32 role) public virtual override returns (uint256){
        return _roleMembers[role].length();
    }


}
