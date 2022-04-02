pragma solidity ^0.8.0;
import "./IERC165.sol";
/**
 * @dev IERC165 的实现
 * @notice 希望实现 IERC165 的合约直接继承此合约，或者使用 { ERC165Storage } 它提供了一个更容易使用但更昂贵的实现。
 * @author zhao
 */
abstract contract ERC165 is IERC165 {

    function supportsInterface(bytes4 interfaceId) public view virtual override returns(bool){
        return interfaceId == type(IERC165).interfaceId;
    }

}
