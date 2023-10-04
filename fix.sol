pragma solidity ^0.8.0;

// Importing Chainlink's oracle contract for simplicity
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract SecureLoanContract {
    AggregatorV3Interface public priceFeed; // Chainlink Oracle
    mapping(address => uint256) public collateral;

    constructor(address _oracleAddress) {
        priceFeed = AggregatorV3Interface(_oracleAddress);
    }

    function deposit() external payable {
        collateral[msg.sender] += msg.value;
    }

    function borrow(uint256 _amount) external {
        require(_amount > 0, "Borrow amount must be greater than zero");
        require(collateral[msg.sender] >= _amount, "Insufficient collateral");

        // Get the current price of Ether in USD from the oracle
        (, int256 price, , , ) = priceFeed.latestRoundData();
        uint256 etherPriceInUSD = uint256(price);

        // Calculate the collateral required based on the current price
        uint256 collateralRequired = (_amount * etherPriceInUSD) / 2; // LTV ratio of 50%

        // Ensure the user's collateral is sufficient
        require(collateral[msg.sender] >= collateralRequired, "Insufficient collateral");

        // Perform the loan transaction
        // Deduct the collateral
        collateral[msg.sender] -= collateralRequired;

        // Transfer borrowed funds
        // ...

        // Repay the loan with interest
        // ...

        // Ensure any excess collateral is returned to the user
        if (collateral[msg.sender] > 0) {
            payable(msg.sender).transfer(collateral[msg.sender]);
            collateral[msg.sender] = 0;
        }
    }
}
