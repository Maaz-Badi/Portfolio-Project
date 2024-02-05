--Temp Table

DROP Table if exists #PercentageofPeoleVaccinated
Create Table #PercentageofPeoleVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVacination numeric,
)

Insert into #PercentageofPeoleVaccinated
Select de.continent, de.location, de.date, de.population, va.new_vaccinations
,SUM(CONVERT(int, va.new_vaccinations)) OVER (Partition by de.location Order by de.location,
de.date) as RollingPeopleVaccination
From [Portfolia Project ]..CovidDeaths$ de
Join [Portfolia Project ]..CovidVaccinations$ va
	on de.date = va.date 
	and de.location = va.location
--where de.continent is not null
--order by 2,3

Select *, (RollingPeopleVacination/Population)*100
from #PercentageofPeoleVaccinated

--Creating View to store data for later visualization

Create View PercentPopulationVacinated as
Select de.continent, de.location, de.date, de.population, va.new_vaccinations
,SUM(CONVERT(int, va.new_vaccinations)) OVER (Partition by de.location Order by de.location,
de.date) as RollingPeopleVaccination
From [Portfolia Project ]..CovidDeaths$ de
Join [Portfolia Project ]..CovidVaccinations$ va
	on de.date = va.date 
	and de.location = va.location
where de.continent is not null
--order by 2,3