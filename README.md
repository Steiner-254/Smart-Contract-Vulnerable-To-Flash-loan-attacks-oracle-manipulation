# Smart-Contract-Vulnerable-To-Flash-loan-attacks-oracle-manipulation
Smart Contract Vulnerable To Flash loan attacks (oracle manipulation)

# Decription
~ A smart contract vulnerable to Flash loan attacks due to oracle manipulation typically involves a scenario where an attacker exploits the contract's reliance on external data provided by an oracle. Here's a simplified example to illustrate this vulnerability:

~ Let's say we have a decentralized lending platform where users can borrow funds based on the value of a cryptocurrency asset (e.g., Ether) they provide as collateral. The smart contract uses an oracle to fetch the current price of Ether in USD to determine the loan-to-value (LTV) ratio and collateral requirements.

# vulnerable.sol
~ In this example, the contract relies on the Chainlink oracle to fetch the current price of Ether in USD. It then calculates the collateral required for a loan, with a fixed loan-to-value (LTV) ratio of 50%. If the user provides enough collateral, the contract allows them to borrow funds.

~ Now, here's how an attacker could exploit this vulnerability using a Flash loan attack:

1. The attacker uses a flash loan to borrow a large amount of Ether without providing any collateral.

2. The attacker manipulates the price reported by the oracle to artificially increase the value of Ether in USD.

3. With the manipulated oracle price, the attacker requests a loan for a substantial amount of USD worth of Ether.

4. Since the oracle reports an inflated price, the contract calculates a lower collateral requirement than it should.

5. The attacker provides the lower collateral requirement (which is still higher than their actual collateral) and borrows a significant amount of funds.

6. The attacker repays the flash loan and walks away with the borrowed funds, leaving the contract undercollateralized and unable to recover the full value of the loan.

# fix.sol
~ In this improved version of the contract:

1. Users can deposit collateral into the contract, which is tracked using the collateral mapping.

2. The borrow function now checks that the user has sufficient collateral before proceeding with the loan.

3. The contract recalculates the collateral requirement based on the current oracle price to ensure accuracy.

4. Excess collateral, if any, is returned to the user after repaying the loan.
