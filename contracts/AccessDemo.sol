pragma solidity ^0.8.0;

import ".\access\AccessControl.sol";

// AccessControl 使用
contract AccessDemo is AccessControl {

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    function AccessDemo(){
        _setRoleAdmin(MINTER_ROLE, DEFAULT_ADMIN_ROLE);
    }

    function getMinterRoleBytes() view returns(bytes32){
        return MINTER_ROLE;
    }


}
