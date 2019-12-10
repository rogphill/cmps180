BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO Customers(customerID, custName, address, category, isValidCustomer)
    SELECT nc.customerID, nc.custName, nc.address, NULL, TRUE
    FROM NewCustomers nc
    WHERE nc.customerID NOT IN (SELECT customerID FROM Customers);

UPDATE Customers c
    SET custName = nc.custName, address = nc.address, isValidCustomer = TRUE
    FROM NewCustomers nc
    WHERE nc.customerID = c.customerID;          

COMMIT;