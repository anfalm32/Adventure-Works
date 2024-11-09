SELECT 
    pod.PurchaseOrderID,
    pod.ProductID,
    pod.UnitPrice,
    pod.OrderQty,
    pod.LineTotal,
    pod.ReceivedQty,
    CASE 
        WHEN pod.ReceivedQty > 0 THEN pod.ReceivedQty * pod.UnitPrice 
        ELSE 0 
    END AS ReceivedTotal,
    CASE 
        WHEN pod.ReceivedQty > 0 THEN (pod.OrderQty - pod.ReceivedQty) * pod.UnitPrice 
        ELSE 0 
    END AS DifflineRec,
    pod.RejectedQty,
    CASE 
        WHEN pod.RejectedQty > 0 THEN pod.RejectedQty * pod.UnitPrice 
        ELSE 0 
    END AS RejectedTotal,
    pod.StockedQty,
    CASE 
        WHEN pod.StockedQty > 0 THEN pod.StockedQty * pod.UnitPrice 
        ELSE 0 
    END AS StockedTotal,
    CASE 
        WHEN pod.StockedQty > 0 and pod.StockedQty != (pod.ReceivedQty-pod.RejectedQty) THEN (pod.ReceivedQty - pod.StockedQty) * pod.UnitPrice 
        ELSE 0 
    END AS DifflineStock,
    p.BusinessEntityID As EmployeeID,
    p.FirstName + ' ' + p.LastName AS EmployeeName,
    v.BusinessEntityID As VendorID,
    v.Name,
    e.JobTitle
FROM 
    Purchasing.PurchaseOrderDetail AS pod
JOIN 
    Purchasing.PurchaseOrderHeader AS poh ON pod.PurchaseOrderID = poh.PurchaseOrderID
JOIN 
    Person.Person AS p ON poh.EmployeeID = p.BusinessEntityID
JOIN 
    Purchasing.Vendor AS v ON poh.VendorID = v.BusinessEntityID
JOIN 
    HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID;