SELECT DISTINCT     t.exchangeID,
                    s.stockName,
                    c1.custName AS buyerName,
                    c2.custName AS sellerName
FROM                Trades t, Stocks s, Customers c1, Customers c2
WHERE               t.exchangeID = s.exchangeID
AND                 t.symbol = s.symbol
AND                 t.tradeTS < TIMESTAMP '2018-01-01 12:00:00'
AND                 c1.customerID = t.buyerID
AND                 c2.customerID = t.sellerID;