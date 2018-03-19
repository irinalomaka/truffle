pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/LCoin.sol";

contract TestLCoin {

function testMintLCoin () public {
  	LCoin meta = new LCoin();
  	uint amount = 10;
  	meta.mint(tx.origin, amount);
    Assert.equal(meta.balanceOf(tx.origin), amount, "mint error");
}

function testInitialBalanceUsingDeployedContract() public {
    LCoin meta = LCoin(DeployedAddresses.LCoin());

    uint expected = 1;

    Assert.equal(meta.balanceOf(tx.origin), expected, "Owner should have at least 1 LCoin");
  }

  function testInitialBalanceWithNewLCoin() public {
    LCoin meta = new LCoin();

    uint expected = 1;

    Assert.equal(meta.balanceOf(tx.origin), expected, "Owner should have at least 1 LCoin");
  }

}

