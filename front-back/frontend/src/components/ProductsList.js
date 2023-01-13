import React, { useState, useEffect, }from 'react';
import { Link } from 'react-router-dom';
import { CardWrapper, CardHeader, CardHeading, CardBody, CardFieldset, Grid } from './Card.style';

export default function ProductsList() {
  const [isLoaded, setIsLoaded] = useState(false)
  const [products, setProducts] = useState([]);

  useEffect(() => {
    console.log('hello world')
    fetch(
      'http://44.193.94.210:5000/products',
      { 
        method: "GET",
        mode: 'cors',
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        }
      }
    )
      .then((res) => res.json())
      .then((data) => {
        setIsLoaded(true)
        setProducts(data)
        // console.log(data)
      })
  })

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