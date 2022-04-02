pragma solidity ^0.8.0;
/**
 * @dev ERC165 标准接口 https://eips.ethereum.org/EIPS/eip-165[EIP].
 * @notice 试来使外界查询合约是否支持某方法
 * @author zhao
 */
contract IERC165 {

    /**
     * @notice 如果此协定实现了由  interfaceId 定义的接口，则返回 true
     * @param  interfaceId
     * @return bool
     */
    function supportsInterface(bytes4 interfaceId) external view returns(bool);
}
