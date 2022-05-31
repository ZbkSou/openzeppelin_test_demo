pragma solidity ^0.8.0;
/**
 * @dev 
 * @notice
 * 元素 以常量形式 add， remove， check 时间复杂度是O(1).
 * 元素枚举 O(n)
 * 使用样例：
 *  * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableSet for EnumerableSet.AddressSet;
 *
 *     // Declare a set state variable
 *     EnumerableSet.AddressSet private mySet;
 * }
 * ```
 *
 * @author zhao
 */
library EnumerableSet {
    struct Set {
        // 保存 set 的 values
        bytes32[] _values;
        //标记值在数组中的位置+1，0 表示不在 set 中
        mapping(bytes32 => uint256) _indexes;
    }

    function _add(Set storage set, bytes32 value) private returns (bool){
        if(!_contains(set, value)){
            set._values.push(value);
            set._indexes[value] = set._values.length;
            return true;
        }else{
            return false;
        }
    }

    function _remove(Set storage set, bytes32 value) private returns (bool){
        uint256 valueIndex = set._indexes[value];
        if(valueIndex != 0){
            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            if(lastIndex != toDeleteIndex){
                // 把最后一个覆盖到被删除的位置
                bytes32 lastValue = set._values[lastValue];
                set._values[toDeleteIndex] = lastValue;
                set._indexes[lastValue] = valueIndex;
            }
            //删除最后一个
            set._values.pop();

            delete set._indexes[value];
            return true;


        }
    }

    function _contains(Set storage set, bytes32 value) private view returns(bool){
        return set._indexes[value] !=0;
    }
}
