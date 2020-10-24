const Web3 = require('web3');
const { abi } = require('./abi')

require('dotenv').config();

const sol_address = process.env.SOL_ADDRESS;
const web3 = new Web3(process.env.INFURA_NODE);
const signer = web3.eth.accounts.privateKeyToAccount(process.env.ETHEREUM_PRIVATE_KEY);
web3.eth.accounts.wallet.add(signer);


const price_feed = new web3.eth.Contract(abi, sol_address);
const gas = 30700000000

/*
request prices from chainlink node operation cost eth/link
*/

const tx = price_feed.methods.requestAll()

var arr = []
console.log(["CHAIN LINK NODE REQUESTS", sol_address])
const operation = async () => {
    await tx
        .send({
            from: signer.address,
            gas: await tx.estimateGas(),
        })
        .once('transactionHash', txhash => {

            console.log(txhash)

            price_feed.methods.rupeePrice().call().then(res => {
                arr.push(res)
                console.log(res)
            })

        })

    return arr
}

operation()