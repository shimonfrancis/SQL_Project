select * from dbo.Housing_Data

select saledate,convert(date,saledate) from Housing_Data


alter table Housing_Data
add saledateconverted date;

Update Housing_Data
set saledateconverted = convert(date,saledate)
select saledateconverted from Housing_Data

select *
from Project.dbo.Housing_Data
where propertyaddress is null


select  a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,
isnull(a.PropertyAddress,b.PropertyAddress)
from Project.dbo.Housing_Data a
join Project.dbo.Housing_Data b
on a.ParcelID=b.ParcelID and
a.UniqueID<>b.UniqueID
where a.PropertyAddress is null

update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from Project.dbo.Housing_Data a
join Project.dbo.Housing_Data b
on a.ParcelID=b.ParcelID and
a.UniqueID<>b.UniqueID
where a.PropertyAddress is null


select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as Address
from Housing_Data
alter table Housing_data
add address nvarchar(255);
update  Housing_Data
set address =SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

alter table Housing_data
add city nvarchar(255);
update  Housing_Data
set city =SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))
select * from Housing_Data

select
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
from Housing_Data
alter table Housing_data
add owneraddres nvarchar(255);
update  Housing_Data
set owneraddres =PARSENAME(Replace(OwnerAddress,',','.'),3)
alter table Housing_data
add ownercity nvarchar(255);
update  Housing_Data
set ownercity =PARSENAME(Replace(OwnerAddress,',','.'),2)
alter table Housing_data
add ownerstate nvarchar(255);
update  Housing_Data
set ownerstate =PARSENAME(Replace(OwnerAddress,',','.'),1)
select * from Housing_Data

select distinct(SoldAsVacant),
count(SoldAsVacant) from Housing_Data
group by SoldAsVacant
select SoldAsvacant ,
Case when SoldAsVacant='N' then 'No'
when SoldAsVacant='Y' then 'Yes'
else SoldAsVacant
End
from Housing_data
Update Housing_Data
set SoldAsVacant=Case when SoldAsVacant='N' then 'No'
when SoldAsVacant='Y' then 'Yes'
else SoldAsVacant
End


with rowCTE as (
select*,
ROW_NUMBER() over(Partition by ParcelID,
                               PropertyAddress,
							   SalePrice,
							   SaleDate,
							   LegalReference
							   Order by
							   UniqueID
							   )as row_numb
from Housing_Data
)
select * from rowCTE

Alter table Housing_Data
drop column OwnerAddress,PropertyAddress
select * from Housing_Data