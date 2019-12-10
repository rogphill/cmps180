SELECT DISTINCT s.exchangeID,
                s.stockName
FROM            Stocks s, Quotes q
WHERE           s.exchangeID = q.exchangeID
AND             s.symbol = q.symbol
AND             q.price < 314.15;