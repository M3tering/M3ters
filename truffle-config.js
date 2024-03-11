require('dotenv').config();
const { IOTEX_PRIVATE_KEY } = process.env;
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 8545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
    },
    gnosis: {
      provider: () => new HDWalletProvider(PRIVATE_KEY, "https://gnosis-rpc.publicnode.com", 0, 2),
      network_id: 100,
      gas: 8500000,
      gasPrice: 1000000000000,
      skipDryRun: true
    }
  },

  compilers: {
    solc: {
      version: "0.8.16",      // Fetch exact version from solc-bin (default: truffle's version)
    }
  },
};