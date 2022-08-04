pragma solidity ^0.8.0;

/**
 * @notice erc20 包括
 * totalSupply 返回代币总数，
 * balanceOf 返回地址所持有的代币数
 * transfer 交易
 * allowance 获取授权额度
 * approve  授权
 * transferFrom 转移
 @return
 */
interface IERC20 {
    /**
    * @dev token 交易通知
    * @note value 可能是0
    */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
    * @dev 当 spender 转移了 token 之后通知
    */
    event Approval(address indexed owner, address indexed spender, uint256 value);
    /**
    * @dev 返回 token 的总数
    */
    function totalSupply() external view returns (uint256);

   /**
   * @dev 返回地址上面的 token 数
   */
    function balanceOf(address account) external view returns (uint256);

    /**
    * @dev 向 to 交易 token
   */
    function transfer(address to, uint256 amount) external returns (bool);
    /**
    * @dev 返回 owner 授予 spender 剩余的额度
    * 这个值将再 approve 或者 transferFrom 之后改变
    */
    function allowance(address owner, address spender) external view returns(uint256);

    /**
    * @dev 调用者将自己的 token 设置 amount 额度给 spender
    * 返回是否成功
    *
    */
    function approve(address spender, uint256 amount) external returns(bool);
    /**
    * 将 amount 从 from 转移给 to 通过 授权机制
    */
    function transferFrom(address from, address to, uint256 amount)external returns(bool);
}
