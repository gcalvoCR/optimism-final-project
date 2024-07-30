import getWeb3 from './web3';
import CredentialRegistry from './contracts/CredentialRegistry.json'; 

const getContract = async () => {
  const web3 = await getWeb3();
  const networkId = await web3.eth.net.getId();
  const deployedNetwork = CredentialRegistry.networks[networkId];
  const instance = new web3.eth.Contract(
    CredentialRegistry.abi,
    deployedNetwork && deployedNetwork.address,
  );
  return { instance, web3 };
};

export default getContract;