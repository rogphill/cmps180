CREATE VIEW OpeningPricePerDay(theDate, openingPrice) AS
    SELECT      DATE(q1.quoteTS),
                q1.price
    FROM        Quotes q1, Quotes q2
    WHERE       DATE(q1.quoteTS) = DATE(q2.quoteTS)
    AND         q1.quoteTS = (SELECT MIN(q3.quoteTS) FROM Quotes q3 WHERE DATE(q3.quoteTS) = DATE(q1.quoteTS))
	GROUP BY	DATE(q1.quoteTS), q1.price;

CREATE VIEW ClosingPricePerDay(theDate, closingPrice) AS
    SELECT      DATE(q1.quoteTS),
                q1.price
    FROM        Quotes q1, Quotes q2
    WHERE       DATE(q1.quoteTS) = DATE(q2.quoteTS)
    AND         q1.quoteTS = (SELECT MAX(q3.quoteTS) FROM Quotes q3 WHERE DATE(q3.quoteTS) = DATE(q1.quoteTS))
	GROUP BY	DATE(q1.quoteTS), q1.price;

CREATE VIEW QuotesSummary(exchangeID, symbol, theDate, openingPrice, closingPrice, lowPrice, highPrice) AS
    SELECT      q.exchangeID,
                q.symbol,
                DATE(q.quoteTS),
                oppd.openingPrice,
                cppd.closingPrice,
                MIN(q.price),
                MAX(q.price)
    FROM        Quotes q, OpeningPricePerDay oppd, ClosingPricePerDay cppd
    WHERE       oppd.theDate = DATE(q.quoteTS)
    AND         cppd.theDate = DATE(q.quoteTS)
    GROUP BY    q.exchangeID, q.symbol, DATE(q.quoteTS), oppd.openingPrice, cppd.closingPrice
    ORDER BY    DATE(q.quoteTS);
