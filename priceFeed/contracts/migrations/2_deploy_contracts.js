var priceFeed = artifacts.require("../contracts/priceFeed.sol");

module.exports = function (deployer) {
    deployer.deploy(priceFeed);
};