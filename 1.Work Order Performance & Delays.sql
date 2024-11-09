SELECT
    w.ProductID,
    p.Name,
    W.LocationID,
    L.Name AS LocationName,
    W.WorkOrderID,
	wo.OrderQty,
	pc.Name As ProductCategory,
	psc.Name As ProductSubCategory,
    w.ActualResourceHrs,
    W.ScheduledStartDate,
    YEAR(W.ScheduledStartDate) AS ScheduledStartYear,
    MONTH(W.ScheduledStartDate) AS ScheduledStartMonth,
    DAY(W.ScheduledStartDate) AS ScheduledStartDay,
    W.ActualStartDate,
    YEAR(W.ActualStartDate) AS ActualStartYear,
    MONTH(W.ActualStartDate) AS ActualStartMonth,
    DAY(W.ActualStartDate) AS ActualStartDay,
    W.ScheduledEndDate,
    YEAR(W.ScheduledEndDate) AS ScheduledEndYear,
    MONTH(W.ScheduledEndDate) AS ScheduledEndMonth,
    DAY(W.ScheduledEndDate) AS ScheduledEndDay,
    W.ActualEndDate,
    YEAR(W.ActualEndDate) AS ActualEndYear,
    MONTH(W.ActualEndDate) AS ActualEndMonth,
    DAY(W.ActualEndDate) AS ActualEndDay,
    DATEDIFF(DAY, W.ScheduledStartDate, W.ActualStartDate) AS LatencyStartDays,
    DATEDIFF(DAY, W.ScheduledEndDate, W.ActualEndDate) AS LatencyEndDays,
    DATEDIFF(DAY, W.ScheduledEndDate, W.ActualEndDate) - DATEDIFF(DAY, W.ScheduledStartDate, W.ActualStartDate) AS latencydates,
    (DATEDIFF(DAY, W.ScheduledEndDate, W.ActualEndDate) - DATEDIFF(DAY, W.ScheduledStartDate, W.ActualStartDate)) * w.ActualResourceHrs AS latencyHours,
    SR.Name AS scrappedName,
    wo.ScrappedQty
FROM
    Production.WorkOrderRouting AS W
JOIN
    Production.Product AS P ON W.ProductID = P.ProductID
JOIN
    Production.Location AS L ON W.LocationID = L.LocationID
JOIN
    Production.WorkOrder AS WO ON WO.WorkOrderID = w.WorkOrderID
JOIN
    Production.ScrapReason AS SR ON SR.ScrapReasonID = WO.ScrapReasonID
JOIN 
    Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN 
    Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID

WHERE
    W.ScheduledStartDate IS NOT NULL
    AND W.ActualEndDate IS NOT NULL
    AND W.ScheduledStartDate > '2011-01-01' 
    AND W.ActualEndDate < '2014-12-31'   