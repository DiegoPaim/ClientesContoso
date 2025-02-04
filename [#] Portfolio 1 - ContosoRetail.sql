

use ContosoRetailDW

select
	G.ContinentName as Continente,
	G.CityName as Cidade,
	Sum(V.SalesAmount) as QntdVendas
from FactSales as V
Inner Join DimStore as L on L.StoreKey = V.StoreKey
Inner Join DimGeography as G on G.GeographyKey = L.GeographyKey
Group By G.ContinentName, G.CityName


select
	CustomerKey,
	GeographyKey,
	concat(FirstName, ' ', LastName) as Nome,
	BirthDate,
	MaritalStatus,
	Gender,
	YearlyIncome,
	TotalChildren,
	NumberChildrenAtHome,
	Education,
	Occupation,
	HouseOwnerFlag,
	NumberCarsOwned,
	DateFirstPurchase,
	LoadDate,
	UpdateDate
from dimcustomer



--total de clientes cadastrados--
select
	sum(CustomerKey)
from DimCustomer



--faixa de renda--
select
	Case 
		When YearlyIncome <= 30000.00 THEN 'Baixo'
		When YearlyIncome between 30000.00 and 60000.00 THEN 'Médio-Baixo'
		When YearlyIncome between 6000.00 and 90000.00 THEN 'Médio-Alto'
		When YearlyIncome between 9000.00 and 120000.00 THEN 'Alto'
		WHEN YearlyIncome >= 120000.00 THEN 'Muito Alto'
	End as 'Faixa de renda'
from DimCustomer --cria uma nova coluna com valores segmentados de uma outra coluna-- 

--faixa etária--
select
	Case
		When year(birthdate) <= 1945 THEN '60+'
		When year(birthdate) between 1946 and 1955 THEN '50+'
		WHEN year(birthdate) between 1956 and 1965 THEN '40+'
		WHEN year(birthdate) between 1966 and 1975 THEN '30+'
		WHEN year(birthdate) >= 1976 THEN '-30'
	End as 'Faixa etária'
from dimcustomer
where birthdate IS NOT NULL


