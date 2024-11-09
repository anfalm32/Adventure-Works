SELECT 
    p.ProductID,
    p.Name AS ProductName,
    psc.Name AS SubCategoryName,
    pc.Name AS ProductCategory,
    p.ProductLine,
    p.ProductNumber,
    p.Class,
    p.StandardCost,
    p.ListPrice,
    p.MakeFlag,
    p.FinishedGoodsFlag
FROM 
    Production.Product AS p
LEFT JOIN 
    Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN 
    Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID;