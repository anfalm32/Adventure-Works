SELECT
    w.ProductID,
	p.Name,
    W.LocationID,
    L.Name AS LocationName,
    W.WorkOrderID ,
    w.ActualResourceHrs ,
	W.ScheduledStartDate,
	YEAR(W.ScheduledStartDate) AS ScheduledStartYear,
    MONTH(W.ScheduledStartDate) AS ScheduledStartMonth,
    DAY(W.ScheduledStartDate) AS ScheduledStartDay,
	W.ActualStartDate,
	YEAR(W.ActualStartDate) AS ActualStartYear,
    MONTH(W.ActualStartDate) AS ActualStartMonth,
    DAY(W.ActualStartDate) AS ActualStartDay,
	ScheduledEndDate,
	YEAR(W.ScheduledEndDate) AS ScheduledEndYear,
    MONTH(W.ScheduledEndDate) AS ScheduledEndMonth,
    DAY(W.ScheduledEndDate) AS ScheduledEndDay,
	W.ActualEndDate,
	YEAR(W.ActualEndDate) AS ActualEndYear,
    MONTH(W.ActualEndDate) AS ActualEndMonth,
    DAY(W.ActualEndDate) AS ActualEndDay,
    DATEDIFF(DAY, W.ScheduledStartDate, W.ActualStartDate) AS LatencyStartDays,
	DATEDIFF(Day, W.ScheduledEndDate, W.ActualEndDate) AS LatencyEndDays,
    DATEDIFF(Day, W.ScheduledEndDate, W.ActualEndDate)-DATEDIFF(DAY, W.ScheduledStartDate, W.ActualStartDate) as latencydates,
	(DATEDIFF(day, W.ScheduledEndDate, W.ActualEndDate)-DATEDIFF(day, W.ScheduledStartDate, W.ActualStartDate))*w.ActualResourceHrs as latencyHours

FROM
    Production.WorkOrderRouting as W
JOIN
    Production.Product as P ON W.ProductID = P.ProductID
JOIN
    production.Location as L ON W.LocationID = L.LocationID
WHERE
    W.ScheduledStartDate IS NOT NULL
    AND W.ActualEndDate IS NOT NULL
    AND W.ScheduledStartDate > '2011-01-01' 
    AND W.ActualEndDate < '2014-12-31'    