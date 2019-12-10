import java.sql.*;
import java.io.*;
import java.util.*;

/**
 * A class that connects to PostgreSQL and disconnects.
 * You will need to change your credentials below, to match the usename and password of your account
 * in the PostgreSQL server.
 * The name of your database in the server is the same as your username.
 * You are asked to include code that tests the methods of the StockMarketApplication class
 * in a similar manner to the sample RunStoresApplication.java program.
*/


public class RunStockMarketApplication
{
    public static void main(String[] args) {
    	
    	Connection connection = null;
    	try {
    	    //Register the driver
    		Class.forName("org.postgresql.Driver"); 
    	    // Make the connection.
            // You will need to fill in your real username abd password for your
            // Postgres account in the arguments of the getConnection method below.
            connection = DriverManager.getConnection(
                                                     "jdbc:postgresql://cmps180-db.lt.ucsc.edu/rogphill",
                                                     "rogphill",
                                                     "removed");
            
            if (connection != null)
                System.out.println("Connected to the database!");

            /* Include your code below to test the methods of the StockMarketApplication class
             * The sample code in RunStoresApplication.java should be useful.
             * That code tests other methods for a different database schema.
             * Your code below: */
			
			/* Create new instance of StockMarketApplication: */
			StockMarketApplication stockapp = new StockMarketApplication(connection);

			/*
			* getCustomersWhoSoldManyStocks
			*/
			int theCount = 3;
			List<Integer> customersWhoSoldManyStocks = stockapp.getCustomersWhoSoldManyStocks(theCount);
			System.out.println("/*");
			System.out.println("* Output of getCustomersWhoSoldManyStocks");
			System.out.println("* when the parameter numDifferentStocksSold is " + theCount + ".");
			for (Integer customer : customersWhoSoldManyStocks)
				System.out.println("*    " + customer);
			System.out.println("*/");	

			
			/* 
			* updateQuotesForBrexit: 
			*/
			String exchangeID = "LSE   ";
			System.out.println("/*");
			System.out.println("* Output of updateQuotesForBrexit when theExchangeID is '" + exchangeID + "'");
			System.out.println("*    " + stockapp.updateQuotesForBrexit(exchangeID));
			System.out.println("*/");	

			/*  
			* rewardBestBuyers #1
			*/
			theCount = 2;
			int theSellerID = 1456;
			System.out.println("/*");
			System.out.println("* Output of rewardBestBuyers when theCount is " + theCount); 
			System.out.println(" and theSellerID is " + theSellerID + ".");
			System.out.println("*    " + stockapp.rewardBestBuyers(theSellerID, theCount));
			System.out.println("*/");	

			/*  
			* rewardBestBuyers #2
			*/
			theCount = 4;
			theSellerID = 1456;
			System.out.println("/*");
			System.out.println("* Output of rewardBestBuyers when theCount is " + theCount); 
			System.out.println(" and theSellerID is " + theSellerID + ".");
			System.out.println("*    " + stockapp.rewardBestBuyers(theSellerID, theCount));
			System.out.println("*/");	

			connection.close();

            /*******************
            * Your code ends here */
            
    	}
    	catch (SQLException | ClassNotFoundException e) {
    		System.out.println("Error while connecting to database: " + e);
    		e.printStackTrace();
    	}
    	finally {
    		if (connection != null) {
    			// Closing Connection
    			try {
					connection.close();
				} catch (SQLException e) {
					System.out.println("Failed to close connection: " + e);
					e.printStackTrace();
				}
    		}
    	}
    }
}
