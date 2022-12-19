import React from 'react'
import './index.style.css';
import { Link } from 'react-router-dom';

export default function LoginScreen() {
    return (
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
              SUBMIT
            </button>
            <Link to="/products" className="btn" >SUBMIT</Link>
            <p className="text">
              Don't have an account?
              <a href="/"> Create account</a>
              <Link to="/products">Sob</Link>
            </p>
          </form>
        </div>
      )
}