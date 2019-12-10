SELECT  c.customerID,
        c.custName,
        c.address
FROM    Customers c
WHERE   c.isValidCustomer = true
AND     c.custName LIKE '%FAKE%';