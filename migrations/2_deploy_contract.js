let PandaFace = artifacts.require('PandaFace');

module.exports = function(deployer) {
  deployer.deploy(PandaFace, { gas: 6000000, gasPrice: 2000000000 });
};