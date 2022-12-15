import './App.css';
import WelcomeScreen from './components/welcomeScreen/WelcomeScreen';
import ProductList from './components/ProductsList/ProductsList';

function App() {
  return (
    <div className="App">
      <WelcomeScreen/>
      <ProductList/>
    </div>
  );
}

export default App;
