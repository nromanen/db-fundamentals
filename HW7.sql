--1. Show the list of customers’ names who used to order the ‘Tofu’ product (use a subquery).
SELECT
  c.ContactName
FROM
  Customers c
WHERE
  c.CustomerID IN (
    SELECT
      o.CustomerID
    FROM
      Orders o
      INNER JOIN (
        SELECT
          odIN.OrderID
        FROM
          "Order Details" odIN
        WHERE
          odIN.ProductID IN (
            SELECT
              p.ProductID
            FROM
              Products p
            WHERE
              p.ProductName LIKE 'Tofu'
          )
      ) od ON o.OrderID = od.OrderID
  );

--2. Show the list of customers’ names who used to order the ‘Tofu’ product, 
--   along with the total amount of the product they have ordered and with the total sum for ordered product calculated.
SELECT
  c.ContactName,
  SUM(od.Quantity) as Amounth,
  round(
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),
    2
  ) as Sum
FROM
  Customers c
  INNER JOIN Orders o ON c.CustomerID = o.CustomerID
  INNER JOIN "Order Details" od ON o.OrderID = od.OrderID
  INNER JOIN (
    SELECT
      pIN.ProductID
    FROM
      Products pIN
    WHERE
      pIN.ProductName LIKE 'Tofu'
  ) p ON od.ProductID = p.ProductID
GROUP BY
  c.CustomerID,
  c.ContactName
ORDER BY
  c.ContactName;

SELECT
  c.ContactName
FROM
  Customers c
WHERE
  c.CustomerID IN (
    SELECT
      o.CustomerID
    FROM
      Orders o
    WHERE
      o.OrderID IN (
        SELECT
          od.OrderID
        FROM
          "Order Details" od
        WHERE
          od.ProductID IN (
            SELECT
              p.ProductID
            FROM
              Products p
            WHERE
              p.SupplierID IN (
                SELECT
                  s.SupplierID
                FROM
                  Suppliers s
                WHERE
                  s.Country NOT LIKE 'Fr%'
              )
          )
      )
  )
  AND c.Country LIKE 'Fr%';

--4.  Show the total ordering sums calculated for each customer’s country for domestic and non-domestic products separately 
--    (e.g.: “France – French products ordered – Non-french products ordered” and so on for each country).
SELECT
  VT.ShipCountry,
  SUM(Domestic) AS Domestic,
  SUM(NonDomestic) AS 'Non-domestic'
FROM
  (
    SELECT
      o.ShipCountry,
      CASE
        WHEN o.ShipCountry = s.Country THEN round(
          SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),
          2
        )
        ELSE NULL
      END AS Domestic,
      CASE
        WHEN o.ShipCountry <> s.Country THEN round(
          SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),
          2
        )
        ELSE NULL
      END AS NonDomestic
    FROM
      "Order Details" od
      LEFT JOIN Orders o ON od.OrderID = o.OrderID
      LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
      LEFT JOIN Products p ON od.ProductID = p.ProductID
      LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID
    GROUP BY
      o.ShipCountry,
      c.CompanyName,
      s.Country
  ) VT
GROUP BY
  VT.ShipCountry
