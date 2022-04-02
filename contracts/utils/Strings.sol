pragma solidity ^0.8.0;
/**
 * @dev
 * @notice String 操作
 * @author ${USER}
 */
library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";

    /**
    * uint 转10进制字符
    * value = 12345
    * return "12345"
    */
    function toString(uint256 value) internal pure returns (string memory){
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        //        记录位数
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    /**
    *  uint256转换为其 ASCII 字符串十六进制
    */
    function toHexString(uint256 value) internal pure returns (string memory){
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length ++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }
    /**
    * uint256转换为其 ASCII 字符串十六进制
    */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory){
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i =2*length +1; i>1;i--){
            buffer[i] = _HEX_SYMBOLS[value &  0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}
