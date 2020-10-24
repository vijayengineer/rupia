
Price Feed for the INR DAI
This is built using the cryptocompare open API

Price is about 0.01 Link

Installation:
1. Configure a .env file with INFURA endpoint, exported private key from Metamask
2. Deploy the contracts using truffle
(Install HD-truffle, Node v8+)
3. Copy the contract address
4. Goto Chainlink and use the Kovan faucet to get some link. For Matic mumbai testnet contact them on discord
5. Change to the root directory and call index.js 

This will call the API and provide the latest DAI INR exchange rate in Rupees with 2 decimal places for paisa
