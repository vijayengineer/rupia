import React from 'react';
import logo from './logo.svg';
import './App.css';
import transakSDK from '@transak/transak-sdk'

const settings = {
    apiKey: 'd7983d4f-039a-44f0-a1f1-c18f92dfeea8',  // Your API Key
    environment: 'STAGING', // STAGING/PRODUCTION
    defaultCryptoCurrency: 'DAI',
    walletAddress: '0xd9862A62ba4b5770BE4A54adFC1C4726b4E551E5', // Your customer's wallet address
    themeColor: '000000', // App theme color
    fiatCurrency: 'INR',
    hostURL: window.location.origin,
    widgetHeight: '550px',
    widgetWidth: '450px'
}

export function openTransak() {
    const transak = new transakSDK(settings);

    transak.init();
}


function App() {
    return (
        <div className="App">
            <header className="App-header">
                <img src={logo} className="App-logo" alt="logo" />
                <p>
                    Edit <code>src/App.js</code> and save to reload.
                </p>
                <button onClick={() => openTransak()}>
                    open trasak
                </button>
            </header>
        </div>
    );
}

export default App;
