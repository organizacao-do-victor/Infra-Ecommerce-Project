import React from 'react'
import './Styles/Login.style.css';
import { Link } from 'react-router-dom';


export default function LoginScreen() {
    return (
    <>
      <div className="login">
          <h1>Sign In</h1>
          <form>
            <div className="form-control">
              <input type="text" required></input>
              <label>Username</label>
            </div>
            <div className="form-control">
              <input type="password" required></input>
              <label>Password</label>
            </div>
            <button className="btn" href="/">
              <Link to="/products"className='btn'> SUBMIT</Link>
            </button>
            <p className="text">
              Don't have an account?
              <a href="/">  <Link to="/products"> Create Account</Link></a>
            </p>
          </form>
        </div>
 
    </>    
  )
}