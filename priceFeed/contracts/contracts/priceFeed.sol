pragma solidity ^0.6.0;
import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract Pricefeed is ChainlinkClient {
    uint256 public rupeePrice;

    uint256 public times = 100;
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    /**
     * Network: Kovan
     * Oracle: Chainlink - 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e
     * Job ID: Chainlink - 29fa9aa13bf1468788b7cc4a500a45b8
     * Fee: 0.1 LINK
     */
    constructor() public {
       // setChainlinkToken(0x70d1F773A9f81C852087B77F6Ae6d3032B02D2AB);
       // oracle = 0x1cf7D49BE7e0c6AC30dEd720623490B64F572E17;
       // jobId = "d8fcf41ee8984d3b8b0eae7b74eca7dd";
        setPublicChainlinkToken();
        oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
        jobId = "29fa9aa13bf1468788b7cc4a500a45b8";
        fee = 0.1 * 10**18; // 0.1 LINK
    }

    /**
     * Create a Chainlink request to retrieve API response, find the target price
     * data, then multiply by 100 (to remove decimal places from price).
     */

    function requestRupeePrice() public returns (bytes32 requestId) {
        Chainlink.Request memory request = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillRupee.selector
        );
        request.add(
            "get",
            "https://min-api.cryptocompare.com/data/price?fsym=DAI&tsyms=INR"
        );
        request.add("path", "INR");
        request.addInt("times", int256(times));
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    function requestAll() public {
        this.requestRupeePrice();
    }

    function fulfillRupee(bytes32 _requestId, uint256 _price)
        public
        recordChainlinkFulfillment(_requestId)
    {
        rupeePrice = _price;
    }
}
