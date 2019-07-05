import React, { Component } from 'react';
import {
    // EthAddress,
    Blockie, MetaMaskButton } from 'rimble-ui';
import styles from './Header.module.scss';

export default class Header extends Component {
  renderNetworkName(networkId) {
    switch (networkId) {
      case 3:
        return 'Ropsten';
      case 4:
        return 'Rinkeby';
      case 1:
        return 'Main';
      case 42:
        return 'Kovan';
      default:
        return 'Private';
    }
  }

  render() {
    const { networkId, accounts, balance, isMetaMask } = this.props;
    return (
      <div className={styles.header}>
        <h3> Your Web3 Info </h3>
        <div className={styles.value}>
          <Blockie opts={{ seed: accounts[0], size: 15, scale: 3 }} />
        </div>
      </div>
    );
  }
}
