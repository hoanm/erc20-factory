const { use } = require("chai");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, execute } = deployments;
  const { deployer } = await getNamedAccounts();

  let erc20Factory = await deploy("ERC20Factory", {
    admin: deployer,
    from: deployer,
    gasLimit: 4000000,
    args: [],
    log: true,
  });
};

module.exports.tags = ["erc20Factory"];
