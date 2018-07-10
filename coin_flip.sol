pragma solidity ^0.4.19;

contract CoinFlip {
//THIS CONTRACT IS CONSUMING A LOT OF GAS
//THIS CONTRACT IS ONLY FOR DEMONSTRATING HOW RANDOM NUMBER CAN BE GENERATED
//DO NOT USE THIS FOR PRODUCTION
// reference from https://gist.githubusercontent.com/promentol/d94959bfaf10f6b64d3cbf9c293de468/raw/fcc5849057d97b05d14f6935fcd8758b28bd5199/advancedlottery.sol
// https://medium.com/@promentol/lottery-smart-contract-can-we-generate-random-numbers-in-solidity-4f586a152b27

    mapping (uint8 => address[]) playersByNumber ;
    mapping (address => bytes32) playersHash;

    uint8[] public numbers;

    address owner;

    function Lottery() public {
        owner = msg.sender;
        state = LotteryState.FirstRound;
    }

    /* enum LotteryState { FirstRound, SecondRound, Finished }

    LotteryState state; */

    function enterHash(bytes32 x) public payable {
        require(state == LotteryState.FirstRound);
        require(msg.value > .001 ether);
        playersHash[msg.sender] = x;
    }


    function enterNumber(uint8 number) public {
        require(number<=1);
        require(keccak256(number, msg.sender) == playersHash[msg.sender]);
        playersByNumber[number].push(msg.sender);
        numbers.push(number);
    }

    function determineWinner() public {
        require(msg.sender == owner);

        state = LotteryState.Finished;

        uint8 winningNumber = random();

        distributeFunds(winningNumber);

        selfdestruct(owner);
    }

    function distributeFunds(uint8 winningNumber) private returns(uint256) {
        uint256 winnerCount = playersByNumber[winningNumber].length;
                require(winnerCount == 1);
        if (winnerCount > 0) {
            uint256 balanceToDistribute = this.balance/(2*winnerCount);
            for (uint i = 0; i<winnerCount; i++) {
                require(i==0);
                playersByNumber[winningNumber][i].transfer(balanceToDistribute);
            }
        }

        return this.balance;
    }

    function random() private view returns (uint8) {
        uint8 randomNumber = numbers[0];
        for (uint8 i = 1; i < numbers.length; ++i) {
            randomNumber ^= numbers[i];
        }
        return randomNumber;
    }
}
  function flipACoin() returns(bool) {
    return random() % 2 == 0;
  }

}
