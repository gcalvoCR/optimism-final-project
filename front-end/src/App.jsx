import { useState } from 'react'
import './App.css'

import getContract from './helpers/contract';

function App() {
  const [accounts, setAccounts] = useState([]);
  const [contract, setContract] = useState(null);
  const [credentials, setCredentials] = useState([]);

  useEffect(() => {
    const init = async () => {
      const { instance, web3 } = await getContract();
      const accounts = await web3.eth.getAccounts();
      setContract(instance);
      setAccounts(accounts);
    };
    init();
  }, []);

  const fetchCredentials = async () => {
    if (contract && accounts.length > 0) {
      const creds = await contract.methods.getUserCredentials(accounts[0]).call();
      setCredentials(creds);
    }
  };

  return (
    <div className="App">
      <h1>Credenciales</h1>
      <button onClick={fetchCredentials}>Obtener Credenciales</button>
      <ul>
        {credentials.map((cred, index) => (
          <li key={index}>
            <p>Emisor: {cred.emisor}</p>
            <p>Nombre: {cred.nombreDeCredencial}</p>
            <p>URL: {cred.urlDeCredencial}</p>
            <p>Fecha de Emisión: {new Date(cred.fechaDeEmision * 1000).toLocaleString()}</p>
            <p>Fecha de Expiración: {new Date(cred.fechaDeExpiracion * 1000).toLocaleString()}</p>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
