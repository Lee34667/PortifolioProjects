SELECT * FROM PortifolioProject..CovidDeath
ORDER BY 3,4

--Select * from PortifolioProject..CovidVaccinations
--order by 3,4

--Select Data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths FROM PortifolioProject..CovidDeath
ORDER BY 1,2

-- Looking at the total cases vs total deaths 

--Looking at the possibility of dying if one contracted Covid in Germany
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM PortifolioProject..CovidDeath
WHERE location like '%erman%'
ORDER BY 1,2


--Now looking at the Total Cases vs Population
--Shows what the percentage of population contracted Covid in Germany
SELECT location, date, total_cases, population, (total_cases/population)*100 as CovidPercentage 
FROM PortifolioProject..CovidDeath
WHERE location like '%erman%'
ORDER BY 1,2


--Looking at countries with highest Infection Rate compared to Population in the world
SELECT location, population, MAX(total_cases) as GreatestInfectionCount, MAX((total_cases/population))*100 as CovidPercentage 
FROM PortifolioProject..CovidDeath
GROUP BY location,population
ORDER BY CovidPercentage DESC
--Germany #38 


--Looking at countries with highest Infection Rate compared to Population in Europe
SELECT location, population, MAX(total_cases) as GreatestInfectionCount, MAX((total_cases/population))*100 as CovidPercentage 
FROM PortifolioProject..CovidDeath
WHERE continent like '%urop%'
GROUP BY location,population
ORDER BY CovidPercentage DESC
--Germany #21


--Showing Countries with Highest Death Count per population
SELECT location, MAX(total_deaths) as DeathToll FROM PortifolioProject..CovidDeath
--Where continent like '%urop%'
GROUP BY location
ORDER BY DeathToll DESC


--Showing Countries with Highest Death Count per population in Europe
SELECT location, MAX(cast(total_deaths as int)) as DeathToll FROM PortifolioProject..CovidDeath
WHERE continent like '%urop%'
GROUP BY location
ORDER BY DeathToll DESC

--Comparing Continents death toll
SELECT continent, MAX(cast(total_deaths as int)) as DeathToll FROM PortifolioProject..CovidDeath
WHERE Continent != 'NULL'
GROUP BY continent
ORDER BY DeathToll DESC



--GLOBAL NUMBERS 

--Looking at the global numbers of daily new cases
SELECT date, SUM(new_cases) FROM PortifolioProject..CovidDeath
WHERE continent != 'NULL'
GROUP BY date
ORDER BY 1,2

--Looking at the global numbers of daily new deaths
SELECT date, SUM(cast(new_deaths as int)) FROM PortifolioProject..CovidDeath
WHERE continent != 'NULL'
GROUP BY date
ORDER BY 1,2

--looking at the global daily death percentage 
SELECT date, SUM(new_cases) as SumOfCases, SUM(cast(new_deaths as int)) as SumOfDeaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage  
FROM PortifolioProject..CovidDeath
WHERE continent != 'NULL'
GROUP BY date
ORDER BY 1,2

--looking at the global number of cases,deaths and DeathPercentage
SELECT  SUM(new_cases) as SumOfCases, SUM(cast(new_deaths as int)) as SumOfDeaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage  
FROM PortifolioProject..CovidDeath
WHERE continent != 'NULL'
--GROUP BY date
ORDER BY 1,2



--Checking Total Population vs People who got the Vaccine per day
SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vaccinations.new_vaccinations
FROM PortifolioProject..CovidDeath deaths 
Join PortifolioProject..CovidVaccinations vaccinations
	ON deaths.location = vaccinations.location 
	and deaths.date = vaccinations.date
WHERE deaths.continent != 'NULL'
ORDER BY 1,2,3



