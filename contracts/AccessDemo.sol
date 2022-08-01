pragma solidity ^0.8.0;

import ".\access\AccessControl.sol";

// AccessControl 使用
contract AccessDemo is AccessControl {


    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    string private content;
    function AccessDemo(){
        _setRoleAdmin(MINTER_ROLE, DEFAULT_ADMIN_ROLE);
        _setupRole(DEFAULT_ADMIN_ROLE,_msgSender());
    }

    function getMinterRoleBytes() view returns(bytes32){
        return MINTER_ROLE;
    }

    function setContent(string memory text) external onlyRole(MINTER_ROLE) {
        content = text;
    }

    function getContent() external view returns(string){
        return content;
    }

}
