CREATE OR REPLACE FUNCTION rewardBuyersFunction(IN theSellerID INTEGER, IN theCount INTEGER) RETURNS INTEGER AS $$
DECLARE
    fd RECORD;
    updatefd RECORD;
    numUpdates INTEGER;
BEGIN
    numUpdates := 0;
    FOR fd IN
        SELECT bstc.*, c.category FROM BuyerSellerTotalCost bstc, Customers c WHERE bstc.sellerID = theSellerID AND bstc.buyerID = c.customerID GROUP BY bstc.buyerID, bstc.sellerID, bstc.totalCost, c.category ORDER BY totalCost DESC LIMIT theCount
    LOOP
        IF fd.category = 'H' THEN
            FOR updatefd IN
                UPDATE Trades SET volume = volume + 50 WHERE buyerID = fd.buyerID AND sellerID = theSellerID
                RETURNING *
            LOOP
                IF updatefd.sellerID = theSellerID THEN
                    numUpdates := numUpdates + 1;
                END IF;
            END LOOP;
        ELSIF fd.category = 'M' THEN
            FOR updatefd IN
                UPDATE Trades SET volume = volume + 20 WHERE buyerID = fd.buyerID AND sellerID = theSellerID
                RETURNING *
            LOOP
                IF updatefd.sellerID = theSellerID THEN
                    numUpdates := numUpdates + 1;
                END IF;
            END LOOP;
        ELSIF fd.category = 'L' THEN
            FOR updatefd IN
                UPDATE Trades SET volume = volume + 5 WHERE buyerID = fd.buyerID AND sellerID = theSellerID
                RETURNING *
            LOOP
                IF updatefd.sellerID = theSellerID THEN
                    numUpdates := numUpdates + 1;    
                END IF;
            END LOOP;
        ELSE
            FOR updatefd IN
                UPDATE Trades SET volume = volume + 1 WHERE buyerID = fd.buyerID AND sellerID = theSellerID
                RETURNING *
            LOOP
                IF updatefd.sellerID = theSellerID THEN
                    numUpdates := numUpdates + 1;
                END IF;
            END LOOP;
        END IF;
    END LOOP;
RETURN(numUpdates);
END;
$$
LANGUAGE plpgsql;