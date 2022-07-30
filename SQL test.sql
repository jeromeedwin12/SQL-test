/*		19BCS4048
		Jerome Edwin J
        CSE
*/



use orders;
#1.Write a SQL query which will sort out the customer and their grade who made an order. Every customer must have a grade and be served by at least one seller, who belongs to a region.

select cust_name,grade 
from customer ca
inner join
orders od
on ca.custemor_id=od.customer_id ORDER BY ca.grade DESC;

#2.Write a query for extracting the data from the order table for the salesman who earned the maximum commission.

SELECT * FROM orders WHERE salesman_id IN
(SELECT salesman_id FROM salesman WHERE commision = (SELECT MAX(commision) FROM salesman));

#3.From orders retrieve only ord_no, purch_amt, ord_date, ord_date, salesman_id where salesman’s city is Nagpur(Note salesman_id of orderstable must be other than the list within the IN operator.)

SELECT ord_no, purch_amt, ord_date, salesman_id FROM orders
WHERE salesman_id IN (SELECT salesman_id FROM salesman WHERE city='nagpur');

#4.Write a query to create a report with the order date in such a way that the latest order date will come last along with the total purchase amount and the total commission for that date is (15 % for all sellers).

SELECT ord_date, SUM(purch_amt) AS "Total Purchase amount", SUM(purch_amt)*.15 AS "Total Commission"
FROM orders GROUP BY ord_date ORDER BY date_format(ord_date , '%d-%m-%y');

#5.Retrieve ord_no, purch_amt, ord_date, ord_date, salesman_id from Orders table and display only those sellers whose purch_amt is greater than average purch_amt.

SELECT ord_no, purch_amt, ord_date, salesman_id FROM orders
WHERE purch_amt >(SELECT  AVG(purch_amt) FROM orders);

#6.Write a query to determine the Nth (Say N=5) highest purch_amt from Orders table.
#while importing the order table, I have changed the datatype as "bigint" from "text".
select * from orders order by purch_amt desc
limit 1
offset 4;

#7.What are Entities and Relationships?
/*
Entity:
 An entity can be a real-world object, either tangible or intangible,
that can be easily identifiable. For example, in a college database,
students, professors, workers, departments, and projects can be
referred to as entities. Each entity has some associated properties
that provide it an identity.

Relationships:
Relations or links between entities that have something to do with each other.
For example - The employees table in a company's database can be associated with
the salary table in the same database.
*/

use bank;
#8.Print customer_id, account_number and balance_amount, condition that if balance_amount is nil then assign transaction_amount for account_type = "Credit Card"

select customer_id , ba.account_number,
Case when ifnull(balance_amount,0) = 0 then   Transaction_amount else balance_amount end  as balance_amount
from Bank_Account_Details ba  
inner join
bank_account_transaction bat
on ba.account_number = bat.account_number
and account_type = "Credit Card";

#9.Print customer_id, account_number, balance_amount, conPrint account_number, balance_amount, transaction_amount from Bank_Account_Details and bank_account_transaction for all the transactions occurred during march, 2020 and april, 2020.

Select
ba.Account_Number, Balance_amount, Transaction_amount, Transaction_Date
from Bank_Account_Details ba  
inner join
bank_account_transaction bat
on ba.account_number = bat.account_number
And ( Transaction_Date between "2020-03-01" and "2020-04-30");

#10.Print all of the customer id, account number, balance_amount, transaction_amount from bank_cutomer, bank_account_details and bank_account_transactions tables where excluding all of their transactions in march, 2020 month .

Select ba.Customer_id, ba.Account_Number, Balance_amount, Transaction_amount, Transaction_Date
from Bank_Account_Details ba  
Left join bank_account_transaction bat
on ba.account_number = bat.account_number
And NOT ( date_format(Transaction_Date , '%Y-%m') = "2020-03" );