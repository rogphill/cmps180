
/*
* Title: Lab 2 Script
* Author: Robert George Phillips (rogphill@ucsc.edu)
* CMPS 180: Databases I - Winter 2019
*/

/* Initialization, as requested by the lab specification: */
DROP SCHEMA Lab2 CASCADE;
CREATE SCHEMA Lab2;

/* Exchanges(exchangeID, exchangeName, address) */
CREATE TABLE Exchanges (
    exchangeID          char(6),
    exchangeName        varchar(30),
    address             varchar(30),
    PRIMARY KEY(exchangeID),
    UNIQUE(exchangeName)
);

/* Stocks(exchangeID, symbol, stockName, address) */
CREATE TABLE Stocks (
    exchangeID          char(6),
    symbol              char(4),
    stockName           varchar(30) NOT NULL,
    address             varchar(30),
    PRIMARY KEY(exchangeID,symbol),
    UNIQUE(stockName)
);

/* Customers(customerID, custName, address, category, isValidCustomer) */
CREATE TABLE Customers (
    customerID          integer,
    custName            varchar(30),
    address             varchar(30),
    category            char(1),
    isValidCustomer     boolean,
    PRIMARY KEY(customerID),
    UNIQUE(custName, address)
);

/* Trades(exchangeID, symbol, tradeTS, buyerID, sellerID, price, volume) */
CREATE TABLE Trades (
    exchangeID          char(6),
    symbol              char(4),
    tradeTS             timestamp,
    buyerID             integer,
    sellerID            integer,
    price               decimal(7,2) NOT NULL,
    volume              integer NOT NULL,
    PRIMARY KEY(exchangeID,symbol,tradeTS)
);

/* Quotes(exchangeID, symbol, quoteTS, price) */
CREATE TABLE Quotes (
    exchangeID          char(6),
    symbol              char(4),
    quoteTS             timestamp,
    price               decimal(7,2),
    PRIMARY KEY(exchangeID,symbol,quoteTS)
);