pragma solidity ^0.8.0;

import "..\IERC20.sol";
/**
 * @dev  ERC20标准中可选元数据函数的接口。
 * @notice
 * @author zhao
 */
interface IEC20Metadata is IERC20 {
    /**
     * @dev 返回 token name
     *
     */
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

}
