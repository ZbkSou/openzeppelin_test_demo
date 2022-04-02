pragma solidity ^0.8.0;
import "./IAccessControl.sol"
/**
 * @dev  AccessControlEnumerable 的对外接口 用来申报 ERC165
 * @notice
 * @author zhao
 */
interface IAccessControlEnumerable is IAccessControl {
/* *
*@dev 返回具有“角色”的帐户之一。‘ index’必须是介于0和{ getrollemembercount }之间的
* 值，非包含。
* * 角色承担者没有以任何特定方式排序，其顺序可能
* 在任何点发生变化。
* * WARNING: 当使用{ getrollemember }和{ getrollemembercount }时，请确保
* 在同一块上执行所有查询。更多信息请参见以下 https://forum.openzeppelin.com/t/iterating-over-elements-on-enumerableset-in-openzeppelin-contracts/2296。
*/
function getRoleMember(bytes32 role, uint256 index) external view returns (address);

/* *
* @notice 返回具有“角色”的帐户数。可以与{ getrollemember }一起使用
* 枚举某个角色的所有传递者。
*/
function getRoleMemberCount(bytes32 role) external view returns (uint256);

}
