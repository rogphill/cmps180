SELECT  s.stockName,
        s.symbol
FROM    Stocks s, Exchanges e
WHERE   e.exchangeName <> 'NASDAQ Stock Exchange'
AND     e.exchangeID = s.exchangeID;