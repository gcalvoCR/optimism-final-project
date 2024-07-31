import getWeb3 from './web3';
import GradeTracker from './../abis/grade.json'; 

const getContract = async () => {
  const web3 = await getWeb3();
  const networkId = await web3.eth.net.getId();
  const deployedNetwork = GradeTracker.networks[networkId];
  const instance = new web3.eth.Contract(
    GradeTracker.abi,
    deployedNetwork && deployedNetwork.address,
  );
  return { instance, web3 };
};

export default getContract;