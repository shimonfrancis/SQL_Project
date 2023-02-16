--select * from covid_death order by 3,4
--select * from covid_death order by 3,4


--select location,date,population,total_cases,new_cases,total_deaths
--from covid_death
--order by 1,2

--select location,date,total_cases,new_cases,total_deaths,(total_deaths/total_cases)*100 as deathrate
--from covid_death
--where location ='India'
--order by 1,2

--select location,max(total_cases) as maxcases,population,max((total_cases/population))*100 as deathcases
--from covid_death
--group by population,location
--order by deathcases

--select location,max(cast(total_deaths as int)) as totaldeath
--from covid_death
--where continent is not null
--group by location
--order by totaldeath desc

--select continent,max(cast(total_deaths as int)) as totaldeath
--from covid_death
--where continent is not null
--group by continent
--order by totaldeath desc


--select covid_death.continent,covid_death.location,covid_death.date,covid_death.population,
--covid_vaccinations.new_vaccinations ,sum(cast(new_cases as int)) over (partition by covid_death.location order by covid_death.location,covid_death.Date)
--from covid_death
--join covid_vaccinations on 
--covid_death.location = covid_vaccinations.location and
--covid_death.date = covid_vaccinations.date
--where covid_death.continent is not null 
--order by 2,3

--create table #viewtable (continent nvarchar(50),location nvarchar(50),
--date datetime,population int,newvacc int,total int)


--Insert into #viewtable select covid_death.continent,covid_death.location,covid_death.date,covid_death.population,
--covid_vaccinations.new_vaccinations ,sum(cast(new_cases as int)) over (partition by covid_death.location order by covid_death.location,covid_death.Date)
--from covid_death
--join covid_vaccinations on 
--covid_death.location = covid_vaccinations.location and
--covid_death.date = covid_vaccinations.date
--where covid_death.continent is not null 
--order by 2,3

--select * from #viewtable

--create view 
--viewtable as
--select covid_death.continent,covid_death.location,covid_death.date,covid_death.population,
--covid_vaccinations.new_vaccinations ,
--sum(convert(int,covid_death.new_cases)) over (partition by covid_death.location order by covid_death.location,covid_death.Date)as peopleasvaccinated
--from covid_death
--join covid_vaccinations on 
--covid_death.location = covid_vaccinations.location and
--covid_death.date = covid_vaccinations.date
--where covid_death.continent is not null 
----order by 2,3