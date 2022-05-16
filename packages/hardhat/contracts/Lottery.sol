pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

struct Player {
  address player;
  string name;
}

struct Winner {
  string name;
  uint amout;
}

contract Lottery {

  uint private prizePool = 0 ether;
  uint private lotteryProfit = 0 ether;
  
  uint private payout = 9000;
  uint private basePercentage = 10000;

  uint private maxPlayers = 5;
  Player[] private players = new Player[](5);

  Winner[] private winners;

  constructor() {
  }

  function getPrizePool() public view returns (uint) {
    return prizePool;
  }

  function getLotteryProfit() public view returns (uint) {
    return lotteryProfit;
  }

  function gamble(string memory name) payable public {
    // check if not full

    uint prizePool_ = (msg.value * payout) / basePercentage;
    uint profit_ = msg.value - prizePool_;

    prizePool += prizePool_;
    lotteryProfit += profit_;

    players.push(Player(msg.sender, name));

    if (players.length == maxPlayers) {
      drawWinner();
    }
  }

  function drawWinner() private {
    Player memory winner = players[1];

    winners.push(Winner(winner.name, prizePool));
    players = new Player[](5);

    payable(winner.player).transfer(prizePool);
  } 
}
