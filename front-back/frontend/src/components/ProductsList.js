import React, { useState, useEffect, }from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import { CardWrapper, CardHeader, CardHeading, CardBody, CardFieldset, Grid } from './Card.style';
import { API } from '../back'

export default function ProductsList() {
  const [products, setProducts] = useState([]);

  const url = `http://${API}:5000/products`

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
    <div style={{'margin-left': '20px'}}>
        <h1>Product List</h1>
        <Link to="/">Voltar para tela Inicial</Link>
    </div>
    {products.length ? (
        products.map((item, key) => (
          <Grid>
            <CardWrapper key={key} >
              <img key={'image'} src={'https://' + item.image_link} alt='image' width='100%' height='300px' style={{'object-fit': "contain"}}/>
              <CardHeader>
                  <CardHeading> {item.product_name}</CardHeading>
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
