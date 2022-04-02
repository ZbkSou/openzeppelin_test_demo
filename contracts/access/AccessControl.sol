pragma solidity ^0.8.0;

import "./IAccessControl.sol";
import "../utils/Context.sol";
import "../utils/Strings.sol";
import "../utils/introspection/ERC165.sol";

/**
 * @notice  子模块可以实现基于角色的访问控制机制，此类只是轻量版本，不支持枚举
 * 应用程序如果想使用枚举，可以使用 { AccessControlEnumerable }.
 * role 类型为 bytes32，暴露在外部 api 中应该保持独立性，建议使用 public constant
 * ```
 * bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
 * ```
 * 角色可用于表示一组权限，要限制对函数调用的访问，请使用{ hasRole } :
 * ```
 * function foo() public {
 *     require(hasRole(MY_ROLE, msg.sender));
 *     ...
 * }
 * ```
 * 可以通过{ grantRole }和 { revokeRole }函数动态地授予和撤销角色。
 * 每个角色都有一个管理角色，只有具有该角色管理角色的
 * 帐户可以调用{ grantRole }和{ revokeRole }
 * 默认情况下，所有角色的管理员角色是“DEFAULT_ADMIN_ROLE”，只有具有该角色的帐户才能授予或撤销其他角色。
 * 可以在初始化的时候使用{ _setRoleAdmin }创建更复杂的角色关系。
 * 警告: “ DEFAULT _ admin _ role”也是它自己的 admin: 它有权限
 * 授予和撤销此角色。应该采取额外的预防措施来保护已经授予它的账户。
 */
abstract contract AccessControl is Context, IAccessControl, ERC165 {
    // RoleData 保存了上级 role， 地址是否拥有权限的mapping,roledata 详情信息
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    mapping(bytes32 => RoleData) private _roles;

    bytes32 public constant DEFAULT_ADMIN_ROLE  = 0x00;

    modifier onlyRole(bytes32 role){
        _checkRole(role);
        _;
    }

    /**
     * @notice IERC165-supportsInterface
     * @param  interfaceId
     * @return bool
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool){
        return interfaceId == type(IAccessControl).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @notice 判断 account 是否拥有 role
     * @param  role
     * @param  account
     * @return bool
     */
    function hasRole(bytes32 role, address account) public view virtual override returns (bool){
        return _roles[role].members[account];
    }

    /**
     * @notice 检查 调用者是否拥有 role ，没有则抛出异常
     * @param
     * @return
     */
    function _checkRole(bytes32 role) internal view virtual {
        _checkRole(role, _msgSender());
    }

    /**
     * @notice 检查 account 是否拥有 role ，没有会抛出异常
     * @param
     * @return /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
     */
    function _checkRole(bytes32 role, address account) internal view virtual {
        if (!hasRole(role, account)) {
            revert(string(
                    abi.encodePacked(
                        "AccessControl: account ",
                        Strings.toHexString(uint160(account), 20),
                        " is missing role ",
                        Strings.toHexString(uint256(role), 32)
                    )
                ));
        }
    }

    /**
     * @notice 查询 role 的管理角色
     * @param  role
     * @return
     */
    function getRoleAdmin(bytes32 role) public view virtual override returns (bytes32){
        return _roles[role].adminRole;
    }

    /**
     * @notice account 没有 role 的话会触发 RoleGranted 事件
     * 调用者拥有 role 的 admin role
     * @param
     * @return 
     */
    function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _grantRole(role, account);
    }

    /**
     * @notice 撤销“account”的“role”
     * @param
     * @return
     */
    function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }

    /**
 * @notice 释放角色
 * @param  role 角色
 * @param  account 账号地址
 * @return
 */
    function renounceRole(bytes32 role, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for self");
        _revokeRole(role, account);
    }

    /**
     * @notice 给 `account` 赋予 `role` ，account 只有之前没有 role的时候才会发送
     * RoleGranted 事件，
     * 注意：此方法是内部方法在构造方法中初始化时被使用。
     * @param
     * @return
     */
    function _setupRole(bytes32 role, address account) internal virtual {
        _grantRole(role, account);
    }
    /**
     * @notice role 设置 adminRole , 会发送 RoleAdminChanged 事件
     * @param
     * @return
     */
    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual {
        bytes32 previousAdminRole = getRoleAdmin(role);
        _roles[role].adminRole = adminRole;
        emit RoleAdminChanged(role, previousAdminRole, adminRole);
    }

    /**
     * @notice 给与 account role ，如果之前没有拥有该 role 会发送 RoleGranted 事件
     * @param
     * @return
     */
    function _grantRole(bytes32 role, address account) internal virtual {
        if (!hasRole(role, account)) {
            _roles[role].members[account] = true;
            emit RoleGranted(role, account, _msgSender());
        }
    }

    /**
     * @notice 撤销 account 的 role
     * @param
     * @return
     */
    function _revokeRole(bytes32 role, address account) internal virtual {
        if (hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }
    }

}
