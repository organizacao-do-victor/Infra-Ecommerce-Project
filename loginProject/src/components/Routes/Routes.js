import React from 'react';
import { Route, BrowserRouter } from "react-router-dom";
import LoginScreen from '../LoginScreen/LoginScreen';
import ProductList from '../ProductsList/ProductsList';


const Routes = () => {
    return(
        <BrowserRouter>
            <Route element = { <LoginScreen/> }  path="/" exact />
            <Route element = { <ProductList/> }  path="/products" />
        </BrowserRouter>
    )
}

export default Routes;