import logo from './logo.svg';
import './App.css';
import axios from 'axios';
import { useState } from 'react';
import { useEffect } from 'react';

  

function App() {
  const [hello, setHello] = useState('');

  useEffect(() => {
      axios.get('http://172.30.1.98:8080/test')
          .then(response => setHello(response.data))
          .catch(error => console.log(error));
  }, []);

  return (
      <div className="App">
          <header className="App-header">
              <img src={logo} className="App-logo" alt="logo" />  {/* 로고 이미지 표시 */}
              <p>
                  From backend: {hello}
              </p>
          </header>
      </div>
  );
}
  
export default App;