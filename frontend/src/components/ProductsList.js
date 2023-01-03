import React from 'react';
// import axios from 'axios';
import { Link } from 'react-router-dom';
import { HeaderTitle, CardWrapper, CardHeader, CardHeading, CardBody, CardFieldset, Grid, CardLink } from './Card.style';
import { data } from './DataArray';


export default function ProductsList() { 
  
  // const [products, setProducts] = useState([]);

  return (
    <>
    <HeaderTitle> Product List</HeaderTitle>
    
    { data.map((item, key) => (
          <Grid>
            <CardWrapper key={key} >
              <CardHeader>
                  <CardHeading> {item.nome}</CardHeading>
                </CardHeader>
                <CardBody>
                  <CardFieldset> 
                    <strong>Price: {item.preco} </strong> 
                  </CardFieldset>
                  <CardFieldset> 
                    <strong>Quantity: {item.quantidade}</strong>
                  </CardFieldset>
                  <CardFieldset> 
                    <strong>Product Code: {item.sku}</strong>
                  </CardFieldset>
                </CardBody>
            </CardWrapper>
          </Grid>
          
      ))}
      <CardLink>
        <Link to="/">Voltar para tela Inicial</Link>
      </CardLink>
      
    </>
  )
}