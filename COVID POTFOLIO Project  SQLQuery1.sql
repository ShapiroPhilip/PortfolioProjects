select*
From [Portfolio Project]..CovidDeath111
where continent is not null
order by 3,4

--Select*
--From Portfolio Project...CovidVacinations
--order by 3, 4 
--select Data that we are going to be using 

Select Location, date, total_cases, new_cases, total_deaths, population
from [Portfolio Project]..CovidDeath111
where Continent is not null
order by 1,2

--Looking at the total cases vs Total Deaths
--Show the likelihood of dying you contract covid in your country

Select Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [Portfolio Project]..CovidDeath111
Where location like '%Finland%'
order by 1,2


--Looking at the the total cases vs Population 

Select Location, date, population, total_cases, new_cases,  (total_deaths/population)*100 as PercentagePopulationInfected
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
order by 1,2

--Looking at countries with the Highest Infection rate compared to population

Select Location,  population, MAX(total_cases) as HighestInfectionCount, MAX((total_deaths/population))*100 as PercentPopulationInfected
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
Group by Location,  population
order by 1,2

Select Location,  population, MAX(total_cases) as HighestInfectionCount, MAX((total_deaths/population))*100 as PercentPopulationInfected
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
Group by Location,  population
order by PercentPopulationInfected desc


--Showing the countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
where Continent is not null
Group by Location
order by TotalDeathCount desc



--Let's break things down by continent

Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
where Continent is null
Group by location
order by TotalDeathCount desc

--Let'S Break it Down by Continent

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
where continent is not null
Group by continent
order by TotalDeathCount desc


--GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_death, Sum(cast (new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
where continent is not null
Group by date
order by 1,2



Select SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_death, Sum(cast (new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [Portfolio Project]..CovidDeath111
--Where location like '%Finland%'
where continent is not null
--Group by date
order by 1,2


--LOOKING AT THE TOATAL POPULATION VS VACCINATION

select*
From [Portfolio Project]..CovidDeath111


select*
From [Portfolio Project]..CovidVaccinations222

select 
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3

--LOOKING AT THE TOATAL POPULATION VS VACCINATION



select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
order by 1,2,3




select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location)
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3

--same as the top

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location)
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3



select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3



--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3


--order by 2,3


--USE CTE

With PopvsVac (Continent, Location, date, Population, new_vaccination, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100
From PopvsVac 






--TEMP TABLE





select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100
From PopvsVac 




--TEMP TABLE


Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated




DROP Table if Exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated




--cREATING VIEW TO STORE DATA FOR LATER VIEWING VISUALIZATION

Create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Portfolio Project]..CovidVaccinations111 vac
Join [Portfolio Project]..CovidDeath111 dea
     on dea.location = vac.location 
	 and dea.date = vac.date
where dea.continent is not null
--order by 2,3





select *
From PercentPopulationVaccinated