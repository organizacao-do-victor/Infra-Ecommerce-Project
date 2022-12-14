import React, { useState, useEffect, }from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { CardWrapper, CardHeader, CardHeading, CardBody, CardFieldset, Grid } from './Card.style';

export default function ProductsList() { 
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const URL = 'https://localhost:5000/products';
    axios.get(URL).then((res) => {
      console.debug(res)
      setProducts(res.data.results);
    })
    .catch((err) => console.log(err));
  }, [])
  

  return (
    <>
    <h1>Product List</h1>
    <Link to="/">Voltar para tela Inicial</Link>
    {products.length ? (
        products.map((person, i) => (
          <Grid>
            <CardWrapper key={person.i} >
              <CardHeader>
                  <CardHeading> product_name </CardHeading>
                </CardHeader>
                <CardBody>
                  <CardFieldset> 
                    <strong>Description: </strong>
                    <p>description</p>  
                  </CardFieldset>
                  <CardFieldset> 
                    <strong>Price: </strong>
                    <p>price</p> 
                  </CardFieldset>
                  <CardFieldset> 
                    <strong>Quantity: </strong>
                    <p>quantity</p> 
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