pragma solidity ^0.4.16;

contract CoinFlipCustom {
  struct game {
    uint gameId;
    uint bet;
    address player;
    string guess;
    bool processed;
  }
  mapping (uint => game) public games;
  uint currentGameId = 0;
  uint lastGameProcessed;
  string lastGameResult;

  function placeBet(string _guess) external payable {
    game memory newGame = game(
      currentGameId,
      msg.value,
      msg.sender,
      _guess,
      false
      );
    games[currentGameId] = newGame;
  }

  function flipCoin() returns(string) {
    return "heads";
  }

  function payWinners() {
    address[] memory winners;
    uint winningBets;
    uint payout = this.balance;
    for (uint i = lastGameProcessed; i <= currentGameId; i++) {
      if (keccak256(games[i].guess) == keccak256(lastGameResult)) {
        winners[winners.length] = games[i].player;
        winningBets += games[i].bet;
      }
    }
    if (winningBets < this.balance) {
      payout = (this.balance * 99) / 100;
    }

    for (uint j = 0; j < winners.length; j++) {

    }
  }

}
