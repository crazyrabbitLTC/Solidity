pragma solidity ^0.4.21;

//A Permission list. It takes addresses of Contracts as objects that can have 
//permissions, and keeps a list of other contracts that have 
//permission to interact with them. 

contract PermissionList {

    //ContractPermissioned => ContractRequestingPermission => True/False
    mapping(address => mapping(address => bool)) mapList;
  
    //Add msg.sender and this.contract to Permission list.
    function PermissionList() public{
        mapList[address(this)][address(this)] = true;
        mapList[address(this)][msg.sender] = true;
        
    }
    function add(address _contractToPermission, address _contractRequestingPermissions) public returns(bool){
        require(requireAdd(_contractToPermission, _contractRequestingPermissions));
        require(check(msg.sender, address(this)));
        mapList[_contractToPermission][_contractRequestingPermissions] = true;
        return(true);
    }
  
    function remove(address _contractToPermission, address _contractRequestingPermissions) public returns(bool){
        require(requireAdd(_contractToPermission, _contractRequestingPermissions));
        require(check(msg.sender, address(this)));
        mapList[_contractToPermission][_contractRequestingPermissions] = false;
        return(true);
    }
    
    function check(address _contractPermissioned, address _contractRequestingPermissions) public view returns(bool){
        return(mapList[_contractPermissioned][_contractRequestingPermissions]);
    }
    
    function requireAdd(address _x, address _y) public pure returns(bool){
        if ((_x != address(0x0)) && (_y != address(0x0))) {
            return(true);
        } else
            return(false);
    }
}
