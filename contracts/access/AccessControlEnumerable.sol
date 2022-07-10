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

    function supportsInterface( bytes4 interfaceId) public view virtual override returns (bool){

    }
    //    function AccessControlEnumerable(){
//
//    }
}
