pragma solidity ^0.8.0;

// Importing Chainlink's oracle contract for simplicity
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FlashLoanVulnerableContract {
    AggregatorV3Interface public priceFeed; // Chainlink Oracle

    constructor(address _oracleAddress) {
        priceFeed = AggregatorV3Interface(_oracleAddress);
    }

    function borrow(uint256 _amount) external {
        // Get the current price of Ether in USD from the oracle
        (, int256 price, , , ) = priceFeed.latestRoundData();
        uint256 etherPriceInUSD = uint256(price);

        // Calculate the collateral required based on the current price
        uint256 collateralRequired = (_amount * etherPriceInUSD) / 2; // LTV ratio of 50%

        // Ensure the user's collateral is sufficient
        require(msg.value >= collateralRequired, "Insufficient collateral");

        // Perform the loan transaction
        // ...
        
        // Repay the loan with interest
        // ...
    }
}
