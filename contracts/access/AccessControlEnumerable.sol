pragma solidity ^0.8.0;
import "./IAccessControlEnumerable.sol";
import "./AccessControl.sol";
import "";

/**
 * @dev 
 * @notice
 * @author zhao
 */
abstract contract AccessControlEnumerable is IAccessControlEnumerable, AccessControl{
    function AccessControlEnumerable(){

    }
}