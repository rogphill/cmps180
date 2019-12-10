-- First query:

SELECT      e.exchangeName, s.stockName, COUNT(qs.highPrice) AS numHighClosings
FROM        Exchanges e, Stocks s, QuotesSummary qs
WHERE       s.exchangeID = qs.exchangeID
AND         s.exchangeID = e.exchangeID
AND         s.symbol = qs.symbol
AND         qs.highPrice = qs.closingPrice
GROUP BY    e.exchangeName, s.stockName
HAVING      COUNT(qs.highPrice) >= 2;    

-- Data output: Two 3-tuples containing:
-- (New York Stock Exchange, Cloudera,Inc., 3)
-- (New York Stock Exchange, HP Enterprise, 2)


-- Delete tuples:

DELETE FROM Quotes
    WHERE   exchangeID IN (SELECT exchangeID FROM Quotes WHERE exchangeID = 'NYSE')
    AND     symbol IN (SELECT symbol FROM Quotes WHERE symbol = 'CLDR')

DELETE FROM Quotes
    WHERE   exchangeID IN (SELECT exchangeID FROM Quotes WHERE exchangeID = 'NASDAQ')
    AND     symbol IN (SELECT symbol FROM Quotes WHERE symbol = 'ANF')

-- Second query:

SELECT      e.exchangeName, s.stockName, COUNT(qs.highPrice) AS numHighClosings
FROM        Exchanges e, Stocks s, QuotesSummary qs
WHERE       s.exchangeID = qs.exchangeID
AND         s.exchangeID = e.exchangeID
AND         s.symbol = qs.symbol
AND         qs.highPrice = qs.closingPrice
GROUP BY    e.exchangeName, s.stockName
HAVING      COUNT(qs.highPrice) >= 2;  

-- Data output: One 3-tuple containing:
-- (New York Stock Exchange, HP Enterprise, 2)