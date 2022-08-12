pragma solidity ^0.8.0;

import "..\..\..\interfaces\IERC3156FlashLender.sol";
import "..\ERC20.sol";
/**
 * @dev 使 token 支持闪电带功能
 * @notice
 * @author zhao
 */
abstract contract ERC20FlashMint is ERC20, IERC3156FlashLender {
    bytes32 private constant _RETURN_VALUE = keccak256("ERC3156FlashBorrower.onFlashLoan");


    /**
     * @dev返回可用于贷款的token的最大数量。
     * @param token被请求的token的地址。
     * @return可以借出的代币数量。
     */
    function maxFlashLoan(address token) public view virtual override returns (uint256) {
        return token == address(this) ? type(uint256).max - ERC20.totalSupply() : 0;
    }
    /**
  * @dev 默认免手续费
  */
    function flashFee(address token, uint256 amount) public view virtual override returns (uint256) {
        require(token == address(this), "ERC20FlashMint: wrong token");
        // silence warning about unused variable without the addition of bytecode.
        amount;
        return 0;
    }
    /**
    * @dev返回flash费用的接收者地址。在默认情况下返回地址(0)，这意味着费用将被烧毁。
    * 此功能可重载更换收费器。
    * @return 闪存费将被发送到的地址。
    */
    function _flashFeeReceiver() internal view virtual returns (address) {
        return address(0);
    }

    /**
     * @notice 开始闪电贷，增发 token  执行贷款人逻辑，之后销毁 增发token
     * @return
     */
    function flashLoan(
        IERC3156FlashBorrower receiver,
        address token,
        uint256 amount,
        bytes calldata data
    ) public virtual override returns (bool) {
        require(amount <= maxFlashLoan(token), "ERC20FlashMint: amount exceeds maxFlashLoan");
        uint256 fee = flashFee(token, amount);
        _mint(address(receiver), amount);
        // 执行借款人拿到 token 得回调
        require(
            receiver.onFlashLoan(msg.sender, token, amount, fee, data) == _RETURN_VALUE,
            "ERC20FlashMint: invalid return value"
        );
        address flashFeeReceiver = _flashFeeReceiver();
        _spendAllowance(address(receiver), address(this), amount + fee);
        if (fee == 0 || flashFeeReceiver == address(0)) {
            _burn(address(receiver), amount + fee);
        } else {
            _burn(address(receiver), amount);
            _transfer(address(receiver), flashFeeReceiver, fee);
        }
        return true;
    }
}
