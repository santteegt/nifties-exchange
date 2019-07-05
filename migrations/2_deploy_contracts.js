const StampCollectible = artifacts.require("./StampCollectible.sol");

module.exports = (deployer, network, accounts) => {

    deployer.deploy(StampCollectible, 10).then((instance) => {
        instance.send(web3.utils.toWei("2", "ether")).then((rs) => console.log('Prize pot fulfilled', rs))
        instance.mint(100, "https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-02.png");
        instance.mint(200, "https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-03.png");
        instance.mint(300, "https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-04.png");
        instance.mint(400, "https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-05.png");
        instance.mint(500, "https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-06.png");
    })

}
