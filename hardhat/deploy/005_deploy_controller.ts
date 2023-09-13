import { HardhatRuntimeEnvironment } from 'hardhat/types'
import { DeployFunction } from 'hardhat-deploy/types'

const deployController: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { deploy, execute } = deployments
  const {
    admin,
  } = await getNamedAccounts()
  const sharedStructs = await deployments.get('SharedStructs')
  await deploy("LilypadController", {
    from: admin,
    args: [],
    log: true,
    libraries: {
      SharedStructs: sharedStructs.address,
    },
  })
  
  const controllerContract = await deployments.get('LilypadController')
  const storageContract = await deployments.get('LilypadStorage')
  const mediationContract = await deployments.get('LilypadMediationRandom')
  const paymentsContract = await deployments.get('LilypadPayments')
  
  await execute(
    'LilypadController',
    {
      from: admin,
      log: true,
    },
    'initialize',
    storageContract.address,
    paymentsContract.address,
    mediationContract.address,
  )

  await execute(
    'LilypadStorage',
    {
      from: admin,
      log: true,
    },
    'setControllerAddress',
    controllerContract.address, 
  )

  await execute(
    'LilypadPayments',
    {
      from: admin,
      log: true,
    },
    'setControllerAddress',
    controllerContract.address, 
  )

  await execute(
    'LilypadMediationRandom',
    {
      from: admin,
      log: true,
    },
    'setControllerAddress',
    controllerContract.address, 
  )

  return true
}

deployController.id = 'deployController'

export default deployController