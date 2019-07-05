import React, { Component } from 'react';
import getWeb3, { getGanacheWeb3 } from './utils/getWeb3';
import Web3Info from './components/Web3Info/index.js';
import Header from './components/Header/index.js';
import Stamps from './components/Stamps/index.js';
import { Loader } from 'rimble-ui';

import styles from './App.module.scss';

class App extends Component {
  state = {
    storageValue: 0,
    web3: null,
    accounts: null,
    contract: null,
    route: window.location.pathname.replace('/', ''),
  };

  getGanacheAddresses = async () => {
    if (!this.ganacheProvider) {
      this.ganacheProvider = getGanacheWeb3();
    }
    if (this.ganacheProvider) {
      return await this.ganacheProvider.eth.getAccounts();
    }
    return [];
  };

  componentDidMount = async () => {
      let StampCollectible = {}
      try {
        StampCollectible = require('../../build/contracts/StampCollectible.json');
      } catch (e) {
        console.log(e);
      }
    try {
      const isProd = process.env.NODE_ENV === 'production';
      if (!isProd) {
        // Get network provider and web3 instance.
        const web3 = await getWeb3();
        // web3.eth.subscribe('newBlockHeaders').on('data', (blockHeader) => console.log("NEW BLOCK!!"));
        const ganacheAccounts = await this.getGanacheAddresses();
        // Use web3 to get the user's accounts.
        const accounts = await web3.eth.getAccounts();
        // Get the contract instance.
        const networkId = await web3.eth.net.getId();
        const isMetaMask = web3.currentProvider.isMetaMask;
        let balance = accounts.length > 0 ? await web3.eth.getBalance(accounts[0]) : web3.utils.toWei('0');
        balance = web3.utils.fromWei(balance, 'ether');
        let instance = null;
        if (StampCollectible.networks) {
          let deployedNetwork = StampCollectible.networks[networkId.toString()];
          if (deployedNetwork) {
            instance = new web3.eth.Contract(StampCollectible.abi, deployedNetwork && deployedNetwork.address);
            // this.subscribeLogEvent(web3, instance, "NewStamp");
          }
        }
        if(instance) {
            this.setState({
                web3, ganacheAccounts, accounts,
                balance, networkId, isMetaMask,
                contract: instance
            });
        } else {
            this.setState({ web3, ganacheAccounts, accounts, balance, networkId, isMetaMask });
        }

      }
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(`Failed to load web3, accounts, or contract. Check console for details.`);
      console.error(error);
    }
  };

  componentWillUnmount() {
    if (this.interval) {
      clearInterval(this.interval);
    }
  }

  getStamps = async() => {
      const { accounts, contract } = this.state;
      const totalMinted = await contract.methods.totalMinted().call();
      console.log('TOTAL MINTED', totalMinted);
      let stamps = [];
      for(var i=1; i<=totalMinted; i++) {
          const stamp = await contract.methods.stamps(i).call();
          stamp.tokenURI = await contract.methods.tokenURI(i).call();
          stamp.owned = await contract.methods.balances(accounts[0], i).call();
          stamps.push(stamp);
      }
      console.log('STAMPS', stamps)
      return stamps;
  }

  buyStamp = async(stamp, index) => {
      const { accounts, contract } = this.state;
      await contract.methods.buyStamp(index).send({from: accounts[0], value: stamp.price})
      alert('Thanks for your purchase 🚀🚀')
  }

  sellStamp = async(stamp, index) => {
      const { accounts, contract } = this.state;
      await contract.methods.sellStamp(index).send({from: accounts[0]})
      alert('Hope you enjoyed it! 🍻🍻')
  }

  renderLoader() {
    return (
      <div className={styles.loader}>
        <Loader size="80px" color="red" />
        <h3> Loading Web3, accounts, and contract...</h3>
        <p> Unlock your metamask </p>
      </div>
    );
  }

  render() {
    if (!this.state.web3) {
      return this.renderLoader();
    }
    return (
      <div className={styles.App}>
        <h1>BSLHACK2019!</h1>
        <p>Nifties Exchange Game 4 Tourism</p>
        <Web3Info {...this.state} />
        <h1>Available Stamps</h1>
        <Stamps getStamps={this.getStamps} buyStamp={this.buyStamp} sellStamp={this.sellStamp} {...this.state} />
      </div>
    );
  }
}

export default App;
