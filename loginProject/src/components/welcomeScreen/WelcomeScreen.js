import React from 'react'
import './index.style.js';


export default function WelcomeScreen() {
  return (
    <>
    <h1>Welcome Screen</h1>
    <div className='form'>
            <div className='content'>
                <span>Login</span>
                <span className='subtitle'>Please enter you Login and your Password</span>
                <div className='inputs'>
                    <input className='input-text1' placeholder='E-mail' type={'text'} />
                    <input className='input-text2' placeholder='Password' type={'text'} />
                    <span className='fgt-psw'>Forgot password?</span>
                </div>
                <div className='button'>
                    <span className='btn-text'>Entrar</span>
                </div>
                <span className='fgt-psw'>Not a member yet? <span className='register'>Register!</span></span>
            </div>
        </div>
    </>
  )
}