
-- Question 1: What are the top 5 brands by receipts scanned among users 21 and over?
SELECT products.BRAND, COUNT(*) AS RECEIPTS_COUNT
FROM (SELECT user_ID, barcode FROM transactions) transactions
JOIN (SELECT ID, birth_date FROM users) users ON  transactions.USER_ID = users.ID
JOIN (SELECT barcode, brand FROM products) products ON transactions.BARCODE = products.BARCODE
WHERE TIMESTAMPDIFF(YEAR, STR_TO_DATE(users.BIRTH_DATE, '%Y-%m-%d %H:%i:%s.%f'), CURRENT_DATE) >= 21
GROUP BY products.BRAND
ORDER BY RECEIPTS_COUNT DESC
LIMIT 5;


-- Question 2: What are the top 5 brands by sales among users that have had their account for at least six months? 
SELECT p.BRAND, SUM(CAST(t.FINAL_SALE AS DECIMAL(10, 2))) AS TOTAL_SALES
FROM transactions t
JOIN users u ON t.USER_ID = u.ID
JOIN products p ON t.BARCODE = p.BARCODE
WHERE DATEDIFF(CURRENT_DATE, STR_TO_DATE(u.CREATED_DATE, '%Y-%m-%d %H:%i:%s')) >= 183
GROUP BY p.BRAND
ORDER BY TOTAL_SALES DESC
LIMIT 5;
