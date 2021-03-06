pragma solidity ^0.4.18;

contract Ownable {

	address owner;

	function Ownable () public {
		owner = msg.sender;
	}	

	modifier onlyOwner() { 
		require( msg.sender == owner); 
		_; 
	}

	function transferOwnership(address newOwner) public onlyOwner {
		require(newOwner != address(0));   
		owner = newOwner;
	}	
}

contract LCoin is Ownable{

	string public name = "LCoin";
	string public symbol = "LC";
	uint32 public constant decimal = 18;

	uint public totalSupply = 0;

    address public owner;
    mapping (address => uint) balances;
	mapping (address => mapping (address => uint)) allowed;
    
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);

    function mint(address _to, uint _value) public onlyOwner {
		assert(totalSupply + _value >= totalSupply && balances[_to] + _value >= balances[_to]);
		balances[_to] += _value;
      	totalSupply += _value;
	}
	
	function balanceOf(address _owner) public constant returns (uint balance) {
        return balances[_owner];
    }
 
    function transfer(address _to, uint _value) public returns (bool success) {
    	if(balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
	        balances[msg.sender] -= _value; 
	        balances[_to] += _value;
	        Transfer(msg.sender, _to, _value);
	        return true;
        }

        return false;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
    	if(allowed[_from][msg.sender] >= _value && balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
    		allowed[_from][msg.sender] -= _value;
	    	balances[_from] -= _value; 
	        balances[_to] += _value;
	        Transfer(_from, _to, _value);
	        return true; 
	    }

    	return false;
    }
    
    function approve(address _spender, uint _value) public returns (bool success) {
    	allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }

    function kill () public onlyOwner returns (bool){
    	selfdestruct(msg.sender);
    } 
}

