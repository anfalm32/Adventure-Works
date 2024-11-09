SELECT 
    BOM.ComponentID,
    P.Name AS ComponentName,
	P.MakeFlag,
    BOM.ProductAssemblyID,
    PL.Name AS ProductAssemblyName
FROM 
    Production.BillOfMaterials AS BOM
JOIN 
    Production.Product AS P ON P.ProductID = BOM.ComponentID
LEFT OUTER JOIN 
    Production.Product AS PL ON PL.ProductID = BOM.ProductAssemblyID;