-- View top 100 rows
SELECT TOP(100) *
FROM PortfolioProject..NashvilleHousingData


-- Cleaning data in SQL Queries
SELECT *
FROM PortfolioProject..NashvilleHousingData


-- Standardize date format
SELECT SaleDate, CAST(SaleDate AS DATE)
FROM PortfolioProject..NashvilleHousingData

SELECT SaleDateConverted, CAST(SaleDate AS DATE)
FROM PortfolioProject..NashvilleHousingData

UPDATE PortfolioProject..NashvilleHousingData
SET SaleDate = CAST(SaleDate AS DATE)

ALTER TABLE NashvilleHousingData
ADD SaleDateConverted DATE

UPDATE PortfolioProject..NashvilleHousingData
SET SaleDateConverted = CAST(SaleDate AS DATE)


-- Populate property address data for null rows
SELECT *
FROM PortfolioProject..NashvilleHousingData
WHERE PropertyAddress IS NULL

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashvilleHousingData AS a
JOIN PortfolioProject..NashvilleHousingData AS b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..NashvilleHousingData AS a
JOIN PortfolioProject..NashvilleHousingData AS b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

-- Breaking out address into individual columns (Address, City, State)
SELECT PropertyAddress
FROM PortfolioProject..NashvilleHousingData
ORDER BY ParcelID

SELECT
-- Selecting lane
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address, 
-- Selecting city
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS City
FROM PortfolioProject..NashvilleHousingData

SELECT *
FROM PortfolioProject..NashvilleHousingData

ALTER TABLE PortfolioProject..NashvilleHousingData
ADD PropertySplitAddress NVARCHAR(255)

UPDATE NashvilleHousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE PortfolioProject..NashvilleHousingData
ADD PropertySplitCity NVARCHAR(255)

UPDATE NashvilleHousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))


SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM PortfolioProject..NashvilleHousingData


ALTER TABLE PortfolioProject..NashvilleHousingData
ADD OwnerSplitAddress NVARCHAR(255)

UPDATE NashvilleHousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE PortfolioProject..NashvilleHousingData
ADD OwnerSplitCity NVARCHAR(255)

UPDATE NashvilleHousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE PortfolioProject..NashvilleHousingData
ADD OwnerSplitState NVARCHAR(255)

UPDATE NashvilleHousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

ALTER TABLE PortfolioProject..NashvilleHousingData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate