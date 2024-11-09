SELECT 
    pod.PurchaseOrderID,
    p.BusinessEntityID,
    p.FirstName + ' ' + p.LastName AS EmployeeName,
    e.JobTitle,
    v.BusinessEntityID AS VendorBusinessEntityID,
    v.Name AS VendorName,
    sm.Name AS ShipMethodName,
    poh.OrderDate,
    YEAR(poh.OrderDate) AS OrderYear,
    MONTH(poh.OrderDate) AS OrderMonth,
    DAY(poh.OrderDate) AS OrderDay,
    poh.ShipDate,
    YEAR(poh.ShipDate) AS ShipYear,
    MONTH(poh.ShipDate) AS ShipMonth,
    DAY(poh.ShipDate) AS ShipDay,
    pod.DueDate,
    YEAR(pod.DueDate) AS DueYear,
    MONTH(pod.DueDate) AS DueMonth,
    DAY(pod.DueDate) AS DueDay,
    DATEDIFF(DAY, poh.ShipDate, pod.DueDate) AS shipped_dates,
    poh.SubTotal,
    poh.TaxAmt,
    poh.Freight,
    poh.TotalDue
FROM 
    Purchasing.PurchaseOrderDetail AS pod
JOIN 
    Purchasing.PurchaseOrderHeader AS poh ON pod.PurchaseOrderID = poh.PurchaseOrderID
JOIN 
    Person.Person AS p ON poh.EmployeeID = p.BusinessEntityID
JOIN 
    Purchasing.Vendor AS v ON poh.VendorID = v.BusinessEntityID
JOIN 
    HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID
JOIN
    Purchasing.ShipMethod AS sm ON poh.ShipMethodID = sm.ShipMethodID
GROUP BY 
    pod.PurchaseOrderID,
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    e.JobTitle,
    v.BusinessEntityID,
    v.Name,
    sm.Name,
    poh.OrderDate,
    poh.ShipDate,
    pod.DueDate,
    poh.SubTotal,
    poh.TaxAmt,
    poh.Freight,
    poh.TotalDue