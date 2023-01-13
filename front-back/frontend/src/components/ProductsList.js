import React, { useState, useEffect, }from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import { CardWrapper, CardHeader, CardHeading, CardBody, CardFieldset, Grid } from './Card.style';

export default function ProductsList() {
  const [products, setProducts] = useState([]);

  const url = 'http://44.193.94.210:5000/products'

  const getAllProducts = () => {
    axios.get(url)
    .then((response) => {
      setProducts(response.data);
    })
    .catch(function(error){
      console.log(error);
    });
  }

  useEffect(() => {
    getAllProducts();
  })

  return (
    <>
    <h1>Product List</h1>
    <Link to="/">Voltar para tela Inicial</Link>
    {products.length ? (
        products.map((item, key) => (
          <Grid>
            <CardWrapper key={key} >
              <CardHeader>
                  <CardHeading> {item.name}</CardHeading>
                </CardHeader>
                <CardBody>
                  <CardFieldset> 
                    <strong>Price: {item.price} </strong> 
                  </CardFieldset>
                  <CardFieldset> 
                    <strong>Quantity: {item.quantity}</strong>
                  </CardFieldset>
                  <CardFieldset> 
                    <strong>Product Code: {item.sku}</strong>
                  </CardFieldset>
                </CardBody>
            </CardWrapper>
          </Grid>
          
        ))
      ) : (
        <section>
          <li>Products not found.</li>
        </section>
      )}

    </>
  )
}