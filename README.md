# openzeppelin 中文使用说明

## access

### Ownable

#### modifiers 
onlyOwner() 不是所有者调用被修饰得方法会抛出异常

#### functions
constructor() 构造方法会初始化合约所有者
 
owner() 返回当前所有者

renounceOwnership() 所有者改成 address(0) 放弃所有权，只有所有者可调用

transferOwnership(newOwner) 转移所有者，只有所有者可调用


####  events
OwnershipTransferred(previousOwner, newOwner) 所有者转移时触发



## utils

### Context.sol

获得 context 信息， 具体就是 msg.sender ,msg.data 的封装

_msgSender() 获得msg.sender
 
_msgData() 获得msg.data

### Strings.sol

toString(uint256 value) uint 转10进制字符

toHexString(uint256 value) uint256转换为其 ASCII 字符串十六进制

toHexString(uint256 value, uint256 length) uint256转换为可选长度 ASCII 字符串十六进制

