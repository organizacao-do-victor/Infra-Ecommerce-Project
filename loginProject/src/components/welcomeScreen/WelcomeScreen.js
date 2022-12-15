import React from 'react'


export default function WelcomeScreen() {
  return (
    <>
    <h1>Welcome Screen</h1>
    <div className='form'>
            <div className='content'>
                <span>Login</span>
                <span className='subtitle'>Please enter you Login and your Password</span>

                <div className='content-inputs'>
                    <input placeholder='E-mail' type={'text'} />
                    <input placeholder='Password' type={'text'} />
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