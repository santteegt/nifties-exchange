import React, { Component } from 'react';
import { Card, Image, Box, Heading, Flex, Button } from 'rimble-ui';
import styles from './Stamps.module.scss';

export default class Stamps extends Component {
  state = {
      stamps: null,
      prizePot: 0

  }

  subscribedEvents = {};

  renderStamps = async () => {
      const { getStamps } = this.props;
      this.setState({stamps: await getStamps()})
  }

  renderPot = async () => {
      const { web3, contract } = this.props;
      const prizePot = await web3.eth.getBalance(contract._address);
      this.setState({prizePot})
  }

  componentDidMount = async () => {
      const { web3, contract } = this.props;
      await this.renderStamps();
      await this.renderPot();
      this.subscribeLogEvent(web3, contract, "NewStamp");
      this.subscribeLogEvent(web3, contract, "BurnedStamp");

  }

  subscribeLogEvent = async (web3, contract, eventName) => {
      const {getStamps} = this.props;
      const eventJsonInterface = web3.utils._.find(
        contract._jsonInterface,
        o => o.name === eventName && o.type === 'event',
      )
      const subscription = web3.eth.subscribe('logs', {
        address: contract.options.address,
        topics: [eventJsonInterface.signature]
    }, async (error, result) => {
          console.log("new event call!!!")
        if (!error) {
          const eventObj = web3.eth.abi.decodeLog(
            eventJsonInterface.inputs,
            result.data,
            result.topics.slice(1)
          )
          console.log(`New ${eventName}!`, eventObj)
          await this.renderStamps();
          await this.renderPot();
        }
      })
      this.subscribedEvents[eventName] = subscription
  }

  render() {
    const { web3, contract, networkId, accounts, balance, isMetaMask } = this.props;
    const { stamps, prizePot } = this.state
    console.log('RENDER ==>', stamps)
    return (
      <div className={styles.stamps}>
      <div className={styles.dataPoint}>
        <div className={styles.label}>Prize Pot 💰💰:</div>
        <div className={styles.value}>{prizePot / (1*10**18)} BTC</div>
      </div>
      {stamps && stamps.map((stamp, idx) => {
          return (
              <Card width={"420px"} mx={"auto"} my={5} p={0}>
              <Image
                width={1}
                src={stamp.tokenURI}
                alt="NIFTIES 4 TOURISM"
              />

              <Box px={4} py={3}>
                <Heading.h2>Nifty #{idx}</Heading.h2>
                <Heading.h3 color="#666">🤑🤑{parseInt(stamp.price) / (1*10**18)} (RBTC)</Heading.h3>
                <Heading.h4 color="#666">{parseInt(stamp.inWild) < parseInt(stamp.maxClones) ? "Available":"Not Available"}</Heading.h4>
                <Heading.h5 color="#666">{stamp.inWild} Minted</Heading.h5>
              </Box>

              <Flex px={4} height={3} borderTop={1} borderColor={"#E8E8E8"}>
                  <Button p={"1"} mr={4} disabled={stamp.owned > 0} onClick={() => this.props.buyStamp(stamp, idx+1)}>
                    Buy Stamp
                  </Button>
                  <Button p={"1"} disabled={stamp.owned == 0} onClick={() => this.props.sellStamp(stamp, idx+1)}>
                    Sell Stamp
                  </Button>
              </Flex>
              </Card>
          )
      })}

      </div>
    );
  }
}
