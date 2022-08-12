pragma solidity ^0.8.0;
/**
 * @dev
 * @notice
 * @author zhao
 */
interface IERC3156FlashBorrower {
    /**
     * @notice 借款人收到贷款得回调
     * @param initiator The initiator of the loan.
     * @param token
     * @param amount
     * @param 还款额外费用
     * @param 额外信息
     * @return The keccak256 hash of "IERC3156FlashBorrower.onFlashLoan"
     */
    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external returns (bytes32);
}
