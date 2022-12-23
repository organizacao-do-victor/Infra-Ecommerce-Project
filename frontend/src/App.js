import React from 'react';
import './App.css';
import LoginScreen from './components/LoginScreen';
import ProductsList from './components/ProductsList';
import { BrowserRouter as Router, Routes , Route} from 'react-router-dom';

function App() {
  return (
    <>
    <Router>
      <Routes>
        <Route exact path='/' element={<LoginScreen/>} />
        <Route path='/products' element={<ProductsList/>} />
      </Routes>
    </Router>
    </>
  );
}

export default App;
