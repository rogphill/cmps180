import java.sql.*;
import java.util.*;

/**
 * The class implements methods of the StockMarket database interface.
 *
 * All methods of the class receive a Connection object through which all
 * communication to the database should be performed. Note: the
 * Connection object should not be closed by any method.
 *
 * Also, no method should throw any exceptions. In particular, in case
 * an error occurs in the database, then the method should print an
 * error message and call System.exit(-1);
 */

public class StockMarketApplication {

    private Connection connection;

    /*
     * Constructor
     */
    public StockMarketApplication(Connection connection) {
        this.connection = connection;
    }

    public Connection getConnection()
    {
        return connection;
    }

    /**
     * Takes as argument an integer called numDifferentStocksSold.
     * Returns the customerID for each customer in Customers that has been the seller of at least
     * numDifferentStocksSold different stocks in Trades.
     * If numDifferentStocksSold is not positive, that's an error.
     */

    public List<Integer> getCustomersWhoSoldManyStocks(int numDifferentStocksSold) throws SQLException
    {
        List<Integer> result = new ArrayList<Integer>();

        // your code here

        // Check for error:
        if (numDifferentStocksSold < 1)
        {
            System.out.println("ERROR: numDifferentStocksSold is not greater than zero.");
            System.exit(-1);
        }

        String query = "SELECT c.customerID FROM Customers c, Trades t WHERE c.customerID = t.sellerID GROUP BY c.customerID HAVING COUNT(c.customerID) >= " + 
                        numDifferentStocksSold + ";";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(query);
        while (rs.next())
        {
            result.add(rs.getInt(1));
        }
        rs.close();
        st.close();

        // end of your code
        return result;
    }


    /**
     * The updateQuotesForBrexit method has one string argument, theExchangeID, which is the exchangeID
     * for an exchange. updateQuotesForBrexit should update price in Quotes for every quote that has
     * that exchangedID, multiplying price by 0.87.
     * updateQuotesForBrexit should return the number of quotes whose prices were updated.
     */

    public int updateQuotesForBrexit(String theExchangeID) throws SQLException
    {
        // your code here; return 0 appears for now to allow this skeleton to compile.

        String query = "UPDATE Quotes SET price = price * 0.87 WHERE exchangeID = ?;";

        PreparedStatement st = connection.prepareStatement(query);
        st.setString(1, theExchangeID);
        int count = st.executeUpdate();
        st.close();

        return count;

        // end of your code
    }


    /**
     * rewardBestBuyers has two integer parameters, theSellerID and theCount.  It invokes a stored
     * function rewardBuyersFunction that you will need to implement and store in the database
     * according to the description in Section 5.  rewardBuyersFunction should have the same two
     * parameters, theSellerID and theCount.
     *
     * Trades has a volume attribute.  rewardBuyersFunction will increase the volume for some trades
     * whose sellerID is theSellerID; Section 5 explains which trade volumes should be increased,
     * and how much they should be increased.  The rewardBestBuyers method should return the same
     * integer result as the rewardBuyersFunction stored function.
     *
     * The rewardBestBuyers method must only invoke the stored function rewardBuyersFunction, which
     * does all of the assignment work; do not implement the rewardBestBuyers method using a bunch of
     * SQL statements through JDBC.  However, rewardBestBuyers should check to see whether theCount
     * is greater than 0, and report an error if it’s not.
     */

    public int rewardBestBuyers (int theSellerID, int theCount) throws SQLException
    {
        // There's nothing special about the name storedFunctionResult
        int storedFunctionResult = 0;

        // your code here

        // Check for error:
        if (theCount < 1)
        {
            System.out.println("ERROR: theCount is not greater than zero.");
            System.exit(-1);
        }

        String query = "SELECT * FROM rewardBuyersFunction(?, ?);";

        PreparedStatement st = connection.prepareStatement(query);
        st.setInt(1, theSellerID);
        st.setInt(2, theCount);
        
        ResultSet rs = st.executeQuery();

        while (rs.next())
        {
            storedFunctionResult = rs.getInt(1);
        }

        rs.close();
        st.close();

        // end of your code
        return storedFunctionResult;

    }

};
