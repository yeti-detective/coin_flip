pragma solidity ^0.4.16;

contract CoinFlipCustom {
  struct game {
    uint gameId;
    address player;
    string guess;
    string result;
  }
  mapping (uint => game) games;
  uint currentGameId = 0;

  function placeBet(string _guess) external payable {
    game storage newGame = game(
      currentGameId,
      msg.sender,
      _guess,
      flipCoin()
      );
  }

  function flipCoin() returns(string) {
    return "heads";
  }

  function payWinner() {

  }

}
