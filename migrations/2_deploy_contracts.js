const StampCollectible = artifacts.require("./StampCollectible.sol");

module.exports = function(deployer) {
    deployer.deploy(StampCollectible, 10);
}
