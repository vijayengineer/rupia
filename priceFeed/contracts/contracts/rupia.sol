pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";

contract TokenFarm is ChainlinkClient, Ownable {
    string public name = "RUPIA";
    ERC20PresetMinterPauser public RUPIA;

    address[] public stakers;
    // token > address
    mapping(address => mapping(address => uint256)) public stakingBalance;
    mapping(address => uint256) public uniqueTokensStaked;

    constructor(address _RupiaAddress) public {
        Rupia = ERC20PresetMinterPauser(_RupiaAddress);
    }

    function stakeTokens(uint256 _amount, address token) public {
        require(_amount > 0, "amount cannot be 0");
        updateUniqueTokensStaked(msg.sender, token);
        IERC20(token).transferFrom(msg.sender, address(this), _amount);
        stakingBalance[token][msg.sender] = stakingBalance[token][msg.sender] + _amount;
        if (uniqueTokensStaked[msg.sender] == 1) {
            stakers.push(msg.sender);
        }

        issueTokens(msg.sender, _amount);
    }

    function unstakeTokens(address token) public {
        uint256 balance = stakingBalance[token][msg.sender];
        require(balance > 0, "staking balance cannot be 0");
        IERC20(token).transfer(msg.sender, balance);
        stakingBalance[token][msg.sender] = 0;
        uniqueTokensStaked[msg.sender] = uniqueTokensStaked[msg.sender] - 1;

        uint256 balanceRupia = Rupia.balanceOf(address(msg.sender));
        Rupia.transferFrom(msg.sender, address(this), balanceRupia);
    }

    function updateUniqueTokensStaked(address user, address token) internal {
        if (stakingBalance[token][user] <= 0) {
            uniqueTokensStaked[user] = uniqueTokensStaked[user] + 1;
        }
    }

    function issueTokens(address recipient, uint256 amount) internal {
       
        Rupia.transfer(recipient, requestRupeePrice()*;
    }

 
}
