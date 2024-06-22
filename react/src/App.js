import logo from './logo.svg';
import './App.css';
import axios from 'axios';
import { useState } from 'react';
import { useEffect } from 'react';

  
function App() {
    const [hello, setHello] = useState('')
      useEffect(() => {
        axios.get('http://donggu-1-was-service:8080/test')
        .then(response => setHello(response.data))
        .catch(error => console.log(error))
      }, []);

      return (
          <div>
              from backend : {hello}
          </div>
      );
}

  
export default App;