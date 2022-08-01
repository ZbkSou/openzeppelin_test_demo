pragma solidity ^0.8.0;
/**
 * @dev Set 由两部分组成 存 values 的数组，
 * 标记 values 在 数组中对应位置的 mapping(bytes32 => uint256) map
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
// 检查是否存在
        if(valueIndex != 0){
            uint256 toDeleteIndex = valueIndex -1;
            uint256 lastIndex = set._values.length -1;
            // 把最后一个覆盖到被删除的位置
            if(lastIndex != toDeleteIndex){
                bytes32 lastValue = set._values[lastValue];
                set._values[toDeleteIndex] = lastValue;
                set._indexes[lastValue] = valueIndex;
            }
//            删除最后一个
            set._values.pop();
            delete set._indexes[value];
            return true;
        }else {
            return false;
        }
    }


    function _contains(Set storage set, bytes32 value) private view returns(bool){
        return set._indexes[value] !=0;
    }

    function _length(Set storage set) private view returns(uint256){
        return set._values.length;
    }

    //获取 set 指定位置的值
    function _at(Set storage set, uint256 index) private view returns(bytes32){
        return set._values[index];
    }

    //以 list 的形式返回 set 的内容
    // 注意这个方法会复制 set 到 memory，本身没有开销，
    // 如果在修改状态变量的方法中使用此方法需要注意，可能会导致方法不可调用
    function _values(Set storage set) private view returns (bytes32[] memory){
        return set._values;
    }

    // Bytes32Set
    struct Bytes32Set{
        Set _inner;
    }


    function add(Bytes32Set storage set, bytes32 value) internal returns(bool){
        return _add(Set._inner, value);
    }

    function remove(Bytes32Set storage set, bytes32 value) internal returns(bool){
        return _remove(set._inner, value);
    }

    function contains(Bytes32Set storage set, bytes32 value) internal view returns(bool){
        return _contains(set._inner, value);
    }

    function length(Bytes32Set storage set) internal view returns (uint256){
        return _length(set._inner);
    }

    function at(Bytes32Set storage set, uint256 index) internal view returns(bytes32){
        return _at(set._inner, index);
    }
    function values(Bytes32Set storage set) internal view returns (bytes32[] memory) {
        return _values(set._inner);
    }

    struct AddressSet{
        Set _inner;
    }

    function add(AddressSet storage set, address value) internal returns(bool){
        return _add(set._inner, bytes32(uint256(uint160(value))));
    }

    function remove(AddressSet storage set, address value) internal returns(bool){
        return _remove(set._inner,bytes32(uint256(uint160(value))));
    }

    function contains(AddressSet storage set, address value) internal view returns(bool){
        return _contains(set._inner, bytes32(uint256(uint160(value))));
    }

    function length(AddressSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }
    function at(AddressSet storage set, uint256 index) internal view returns (address) {
        return address(uint160(uint256(_at(set._inner, index))));
    }

    function values(AddressSet storage set) internal view returns (address[] memory){
        bytes32[] memory store = _values(set._inner);
        address[] memory result;
        assembly {
            result := store
        }
        return result;
    }

    struct UintSet {
        Set _inner;
    }

    function add(UintSet storage set, uint256 value) internal returns (bool) {
        return _add(set._inner, bytes32(value));
    }

    function remove(UintSet storage set, uint256 value) internal returns (bool) {
        return _remove(set._inner, bytes32(value));
    }

    function contains(UintSet storage set, uint256 value) internal view returns (bool) {
        return _contains(set._inner, bytes32(value));
    }

    function length(UintSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    function at(UintSet storage set, uint256 index) internal view returns (uint256) {
        return uint256(_at(set._inner, index));
    }

    function values(UintSet storage set) internal view returns (uint256[] memory){
        bytes32[] memory store = _values(set._inner);
        uint256[] memory result;
        assembly {
            result := store
        }

        return result;
    }
}
