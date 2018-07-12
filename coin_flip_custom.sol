pragma solidity ^0.4.16;

contract CoinFlipCustom {
  struct public game {
    uint gameId;
    uint bet;
    address player;
    string guess;
    string result;
    bool processed;
  }
  mapping (uint => game) games;
  uint currentGameId = 0;
  uint lastGameProcessed;

  function placeBet(string _guess) external payable {
    game memory newGame = game(
      currentGameId,
      msg.value,
      msg.sender,
      _guess,
      flipCoin(),
      false
      );
    games[currentGameId] = newGame;
  }

  function flipCoin() returns(string) {
    return "heads";
  }

  function payWinners() {
    address[] memory winners;
    uint payout = this.balance * 0.99;
    for (uint i = lastGameProcessed; i <= currentGameId; i++) {
      if (games[i].guess == games[i].result) {
        winners.push(games[i].player);
      }
    }

  }

}
