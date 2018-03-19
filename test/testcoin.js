var LCoin = artifacts.require("./LCoin.sol");

contract('LCoin', function(accounts) {
	it("should mint LCoin", function() {
		return LCoin.deployed().then(function(instance){
			var amount = 10;
			return instance.mint(accounts[0], amount).then(function(balance) {
				return instance.balanceOf(accounts[0]);
			});
		});
	});
});

