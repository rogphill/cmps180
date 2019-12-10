-------------------------------------------------------------------------------
-- Foreign Key Unit Tests:
-------------------------------------------------------------------------------

-- buyerID field test:

INSERT INTO Trades(exchangeID, symbol, tradeTS, buyerID, sellerID, price, volume)
    VALUES ('NASDAQ', 'AAPL', TIMESTAMP '1999-01-08 04:05:06', 9999, 1456, 3.25, 50);

-- Result:
-- ERROR: insert or update on table "trades" violates foreign key constraint "trades_buyerid_fkey"

-------------------------------------------------------------------------------

-- sellerID field test:

INSERT INTO Trades(exchangeID, symbol, tradeTS, buyerID, sellerID, price, volume)
    VALUES ('NASDAQ', 'AAPL', TIMESTAMP '1999-01-08 04:05:06', 1456, 9988, 3.25, 50);

-- Result:
-- ERROR:  insert or update on table "trades" violates foreign key constraint "trades_buyerid_fkey"

-------------------------------------------------------------------------------

-- Trades (exchangeID, symbol) field test:

INSERT INTO Trades(exchangeID, symbol, tradeTS, buyerID, sellerID, price, volume)
    VALUES ('NYSE', 'ZZYZ', TIMESTAMP '1999-01-08 04:05:06', 1456, 1489, 3.25, 50);

-- Result:
-- ERROR:  insert or update on table "trades" violates foreign key constraint "trades_exchangeid_fkey"

-------------------------------------------------------------------------------

-- Quotes (exchangeID, symbol) field test:

INSERT INTO Quotes(exchangeID, symbol, quoteTS, price)
    VALUES ('NYSE', 'ZZYZ', TIMESTAMP '1999-01-08 04:05:06', 3.25);

-- Result:
-- ERROR:  insert or update on table "quotes" violates foreign key constraint "quotes_exchangeid_fkey"

-------------------------------------------------------------------------------
-- General Constraint Unit Tests:
-------------------------------------------------------------------------------

-- Price must be positive unit test (Update that meets constraint)

UPDATE Quotes
    SET price = 0.05
    WHERE (price > 500);

-- Result:
-- Query returned successfully

-- Price must be positive unit test (Update that DOES NOT meets constraint)

UPDATE Quotes
    SET price = -0.05
    WHERE (price > 500); 

-- Result:
-- ERROR:  new row for relation "quotes" violates check constraint "positive_price"

-------------------------------------------------------------------------------

-- Cost must be positive unit test (Update that meets constraint)

UPDATE Trades
    SET price = 1050
    WHERE (price > 500);

-- Result:    
-- Query returned successfully

-- Cost must be positive unit test (Update that DOES NOT meets constraint)

UPDATE Trades
    SET price = -0.05
    WHERE (price > 1000); 

-- Result:    
-- ERROR:  new row for relation "trades" violates check constraint "positive_cost"

-------------------------------------------------------------------------------

-- buyerID != sellerID unit test (Update that meets constraint)

UPDATE Trades
    SET buyerID = 1456
    WHERE (sellerID = 1854);

-- Result:    
-- Query returned successfully

-- buyerID != sellerID unit test (Update that DOES NOT meets constraint)

UPDATE Trades
    SET buyerID = 1456
    WHERE (sellerID = 1456); 

-- Result:    
-- ERROR:  new row for relation "trades" violates check constraint "uniqueids"

-------------------------------------------------------------------------------

-- if category is 'H', then is valid customer unit test (Update that meets constraint)

UPDATE Customers
    SET category = 'H'
    WHERE (category = 'L');

-- Result:    
-- Query returned successfully

-- if category is 'H', then is valid customer unit test (Update that DOES NOT meets constraint)

UPDATE Customers
    SET isValidCustomer = FALSE
    WHERE (category = 'H');

-- Result:    
-- ERROR:  new row for relation "trades" violates check constraint "uniqueids"


