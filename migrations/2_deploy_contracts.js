var VotingApp = artifacts.require('./VotingApp.sol')

module.exports = function (deployer) {
  deployer.deploy(VotingApp)
}
