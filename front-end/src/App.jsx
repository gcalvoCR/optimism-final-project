import { useState, useEffect } from 'react'
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
      <h1>Grade Tracker</h1>
      <p>Get in touch with any of the devs:</p>
      <ul>
        <li>Gabriel Calvo</li>
        <li>Kun Zhen</li>
        <li>Andrey Melendez</li>
      </ul>
      <button onClick={fetchCredentials}>Page under construction!</button>
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
