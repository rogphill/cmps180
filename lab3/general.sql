ALTER TABLE Quotes ADD CONSTRAINT positive_price CHECK (price > 0);
ALTER TABLE Trades ADD CONSTRAINT positive_cost CHECK (price * volume > 0);
ALTER TABLE Trades ADD CONSTRAINT uniqueIDs CHECK (buyerID <> sellerID);
ALTER TABLE Customers ADD CHECK (category <> 'H' OR isValidCustomer);


    