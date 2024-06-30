import logo from './logo.svg';
import './App.css';
import axios from 'axios';
import { useState } from 'react';
import { useEffect } from 'react';

  

function App() {
  const [hello, setHello] = useState('');

  useEffect(() => {
    axios.get('https://api.dorong9.com/')
      .then(response => {
        setHello(response.data);
      })
      .catch(error => {
        console.error('There was an error fetching the data!', error);
      });
  }, []);

  return (
      <div className="App">
          <header className="App-header">
              <img src={logo} className="App-logo" alt="logo" />  {/* 로고 이미지 표시 */}
              <p>
                  From backend 카나리: {hello}
              </p>
          </header>
      </div>
  );
}

  
export default App;