pragma solidity ^0.8.0;

interface IAccessControl {

    /**
     * @notice  当“ newAdminRole”设置为“ role”的管理员角色时发出，替换“ previousAdminRole”
     * @param  previousAdminRole 之前的管理角色
     * @param  newAdminRole 新管理角色
     * @param  role
     * @return
    */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @notice  account 被赋予 role 的时候
     * @param  sender 指合约调用者
     * @param  account 账号地址
     * @param  role  被释放的权限
     * @return
    */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @notice  account 释放 role 的时候
     * @param  sender 指合约调用者
     * @param  account 账号地址
     * @param  role  被释放的权限
     * @return
    */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @notice account 拥有 role 的时候 返回 true
     * @param  role 角色
     * @param  account 账号地址
     * @return
    */
    function hasRole(bytes32 role, address account) external view returns (bool);


    /**
     * @notice 返回 role 的控制 role
     * @param  role 角色
     * @return
    */
    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    /**
     * @notice 对地址设置角色，发送 RoleGrated 事件
     * @param  role 角色
     * @param  account 账号地址
     * @return
    */
    function grantRole(bytes32 role, address account) external;

    /**
     * @notice 回收权限, 发送 RoleRevoked 事件
     * @param  role 角色
     * @param  account 账号地址
     * @return
    */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @notice 释放角色
     * @param  role 角色
     * @param  account 账号地址
     * @return 
     */
    function renounceRole(bytes32 role, address account) external;


}
