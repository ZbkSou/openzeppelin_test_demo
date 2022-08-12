pragma solidity ^0.8.0;

import "./IERC3156FlashBorrower.sol";
/**
 * @dev
 * @notice
 * @author zhao
 */
interface IERC3156FlashLender {
    /**
     * @notice 可借出的token数量。
     * @param 贷款 token 地址
     * @return
     */
    function maxFlashLoan(address token) external view returns (uint256);
    /**
   * @dev 对贷款收取费用
   * @param token 地址
   * @param amount 贷款 token 数量
   * @return 额外收取的 token 数量
   */
    function flashFee(address token, uint256 amount) external view returns (uint256);
    /**
 * @dev 创建闪电贷
 * @param 贷方代币接收者
 * @param 借款token 地址
 * @param amount
 * @param 自定义数据
 */
    function flashLoan(IERC3156FlashBorrower receiver, address token, uint256 amount, bytes calldata data) external returns (bool);

}
