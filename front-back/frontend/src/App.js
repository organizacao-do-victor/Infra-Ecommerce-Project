import React from 'react';
import './App.css';
import ProductsList from './components/ProductsList';
import { BrowserRouter as Router, Routes , Route} from 'react-router-dom';

function App() {
  return (
    <>
    <Router>
      <Routes>
        <Route exact path='/' element={<ProductsList/>} />
      </Routes>
    </Router>
    </>
  );
}

export default App;
