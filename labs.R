# install.packages("fpp3")

# https://workshop.nectric.com.au/f4sg-um6p/

library(fpp3)

tourism
View(tourism)

tourism |> # %>%
  distinct(State)

tourism |> 
  filter(State == "Victoria")

tourism |> 
  distinct(Purpose)


tourism |> 
  filter(Purpose == "Holiday")

tourism |> 
  filter(Quarter < yearquarter("1999 Q1")) |> 
  filter(Purpose == "Holiday")

# https://workshop.nectric.com.au/f4sg-um6p/
# https://github.com/mitchelloharawild/workshop-f4sg-um6p
library(fpp3)
# install.packages("readr")
pbs <- readr::read_csv(
  "https://workshop.nectric.com.au/f4sg-um6p/data/pbs.csv"
)
pbs
View(pbs)

pbs_ts <- pbs |> 
  mutate(Month = yearmonth(Month)) |> 
  as_tsibble(index = Month, key = c(Concession, Type, ATC1, ATC2))

pbs_ts |> 
  distinct(Concession)
pbs_ts |> 
  distinct(Type)
pbs_ts |> 
  distinct(ATC1)
pbs_ts |> 
  distinct(ATC1_desc)
pbs_ts |> 
  distinct(ATC2)
pbs_ts |> 
  distinct(ATC2_desc)

pbs_a10 <- pbs_ts |> 
  filter(ATC2 == "A10")

pbs_a10 |> 
  as_tibble() |> 
  group_by(Concession) |> 
  summarise(Cost = sum(Cost))

pbs_a10 |> 
  group_by(Concession) |> 
  summarise(Cost = sum(Cost))

pbs_a10 |> 
  index_by(year = year(Month)) |> 
  group_by(Concession) |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot()

tourism |> 
  group_by(Purpose) |> 
  summarise(Trips = sum(Trips))

pbs_a10 |> 
  group_by(Concession) |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot()

tourism |> 
  group_by(Purpose) |> 
  summarise(Trips = sum(Trips)) |> 
  autoplot()

ansett |> 
  filter(Airports == "MEL-SYD") |> 
  autoplot()

aus_production |> 
  autoplot(Beer)
aus_production |> 
  autoplot(Tobacco)
aus_production |> 
  autoplot(Electricity)

aus_production |> 
  gg_season(Electricity)
aus_production |> 
  gg_season(Beer)

aus_production |> 
  gg_subseries(Electricity)
aus_production |> 
  autoplot(Beer)

aus_production |> 
  filter(year(Quarter) > 1991) |>
  autoplot(Beer)
  
aus_production |> 
  filter(year(Quarter) > 1991) |>
  gg_subseries(Beer)

aus_production |> 
  autoplot(Beer)
aus_production |> 
  autoplot(Electricity)
aus_production |> 
  autoplot(vars(Gas, Electricity)) + 
  scale_y_log10()


aus_production |> 
  autoplot(Beer) + 
  autolayer(aus_production, lag(Beer, 4),
            colour = "red", alpha = 0.5) + 
  theme_minimal()

aus_production |> 
  ggplot(aes(x = lag(Beer, 4), y = Beer)) + 
  geom_point()

# lag 1: 0.4 - 0.5
# lag 2: 0.3 - 0.4
# lag 3: 0.4  -0.5
# lag 4: 0.8

aus_production |> 
  ACF(Beer) |> 
  autoplot()

as_tsibble(sunspots) |> 
  autoplot(value)

as_tsibble(sunspots) |> 
  index_by(year=year(index)) |> 
  summarise(value = sum(value)) |> 
  ACF(value) |> 
  autoplot()


tourism |> 
  filter(Purpose == "Holiday") |> 
  summarise(Trips = sum(Trips)) |> 
  ACF(Trips) |> 
  autoplot()

aus_production |> 
  autoplot(Electricity)

aus_production |> 
  gg_season(Electricity)
aus_production |> 
  gg_subseries(Electricity)


aus_production |> 
  index_by(year = year(Quarter)) |> 
  summarise(Electricity = sum(Electricity)) |> 
  autoplot(Electricity)

global_economy |> 
  filter(Country == "Morocco") |> 
  autoplot(Population)

global_economy |> 
  filter(Country == "Morocco") |> 
  autoplot(GDP)

global_economy |> 
  filter(Country == "Morocco") |> 
  autoplot(GDP/Population)

global_economy |> 
  filter(Country %in% c("Morocco", "Australia", "China")) |> 
  autoplot(GDP)

global_economy |> 
  filter(Country %in% c("Morocco", "Australia", "China")) |> 
  autoplot(GDP/Population)

global_economy |> 
  filter(Country %in% c("Morocco", "Australia")) |> 
  autoplot(CPI)

aus_retail |> 
  summarise(Turnover = sum(Turnover)) |> 
  autoplot(Turnover)


aus_economy <- global_economy |> 
  filter(Code == "AUS")
aus_economy |> 
  autoplot(CPI)
aus_economy |> 
  autoplot()

aus_retail |> 
  summarise(Turnover = sum(Turnover)) |> 
  mutate(Year = year(Month)) |> 
  left_join(aus_economy, by = "Year") |> 
  autoplot(Turnover/CPI)




aus_retail |> 
  index_by(Year = year(Month)) |>
  summarise(Turnover = sum(Turnover)) |> 
  autoplot()


as_tsibble(USAccDeaths) |> 
  autoplot(value)
as_tsibble(USAccDeaths) |> 
  gg_season(value)
as_tsibble(USAccDeaths) |> 
  gg_season(value/days_in_month(index))

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot(log(Cost))

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot(box_cox(Cost, 0.5))


pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot(box_cox(Cost, guerrero(Cost)))

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  features(Cost, guerrero)

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot(Cost)

aus_production |> 
  autoplot(Beer)

aus_production |> 
  model(STL(Beer ~ trend(window = 30) + season(window = 9))) |> 
  components() |> 
  autoplot()



pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot(Cost)


pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  autoplot(box_cox(Cost, guerrero(Cost)))
# sqrt: lambda = 0.5
# lambda: 0.34

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  model(STL(box_cox(Cost, guerrero(Cost)))) |> 
  components() |> 
  autoplot()

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  model(STL(Cost)) |> 
  components() |> 
  autoplot()

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  model(STL(box_cox(Cost, guerrero(Cost)))) |> 
  components() |> 
  gg_season(season_year)
pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  model(STL(box_cox(Cost, guerrero(Cost)))) |> 
  components() |> 
  gg_subseries(season_year)

pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  gg_season(Cost)
pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  gg_subseries(Cost)
pbs_ts |> 
  summarise(Cost = sum(Cost)) |> 
  model(STL(Cost)) |> 
  components()

pbs_ts |> 
  index_by(Year = year(Month)) |>
  summarise(Cost = sum(Cost)) |> 
  head(-1) |> 
  autoplot(Cost)
  

pbs_ts |> 
  index_by(Year = year(Month)) |>
  summarise(Cost = sum(Cost)) |> 
  head(-1) |> 
  model(STL(Cost)) |> 
  components() |> 
  autoplot()

vic_elec |> 
  filter(yearmonth(Time) == yearmonth("2013 Jan")) |> 
  autoplot(Demand)

vic_elec |> 
  index_by(Date) |> 
  summarise(Demand = sum(Demand)) |> 
  model(STL(Demand)) |> 
  components() |> 
  filter(yearquarter(Date) == yearquarter("2013 Q2")) |>
  autoplot(season_week)

pbs_concession <- pbs_ts |> 
  group_by(Concession) |> 
  summarise(Scripts = sum(Scripts))

pbs_concession |> 
  autoplot(Scripts)

fit <- pbs_concession |> 
  model(
    SNAIVE(Scripts ~ drift())
  )

fit

fit |> 
  forecast(h = "10 years") |> 
  autoplot(pbs_concession)


library(fpp3)
pbs_a10 <- PBS |> 
  filter(ATC2 == "A10") |> 
  summarise(Scripts = sum(Scripts), Cost = sum(Cost))

pbs_a10 |> 
  autoplot(log(Scripts))
pbs_a10 |> 
  autoplot(box_cox(Scripts, 0.3))


pbs_a10 |> 
  model(
    TSLM(box_cox(Scripts, 0.3) ~ trend() + season())
  ) |> 
  forecast(h = "2 years") |> 
  autoplot(pbs_a10)



pbs_a10 |> 
  model(
    TSLM(box_cox(Scripts, 0.3) ~ trend() + season() + Cost)
  ) |> 
  report()

pbs_a10 |> tail()

pbs_a10 |> 
  model(
    TSLM(box_cox(Scripts, 0.3) ~ trend() + season() + Cost)
  ) |> 
  forecast(
    new_data(pbs_a10, 12) |> 
      mutate(Cost = 20e6)
  ) |> 
  autoplot(pbs_a10)

pbs_a10 |> 
  model(
    ETS(Scripts)
  ) |> 
  forecast(h = "2 years") |> 
  autoplot(pbs_a10)

pbs_a10 |> 
  model(
    ETS(Scripts)
  ) |> 
  components() |> 
  autoplot()

pbs_a10 |> 
  autoplot(box_cox(Scripts, 0.3))
pbs_a10 |> 
  features(Scripts, guerrero)

pbs_a10 |> 
  model(
    ETS(Scripts),
    ARIMA(box_cox(Scripts, guerrero(Scripts)))
  ) |> 
  forecast(h = "2 years") |> 
  autoplot(tail(pbs_a10, 48), alpha = 0.5, level = 90)

library(fpp3)
pbs_scripts <- PBS |> 
  summarise(Scripts = sum(Scripts))
fit <- pbs_scripts |> 
  model(
    ETS(Scripts), 
    ARIMA(log(Scripts))
  )
augment(fit)


pbs_scripts |> 
  autoplot(Scripts) + 
  autolayer(augment(fit), .fitted)

augment(fit) |> 
  autoplot(.resid)

accuracy(fit)

pbs_scripts |> 
  autoplot(Scripts)
fc <- pbs_scripts |> 
  # Keep some data for evaluating forecasts
  filter(Month < yearmonth("2006 Jan")) |> 
  model(
    ETS(Scripts), 
    ARIMA(log(Scripts))
  ) |> 
  forecast(h = "2 years")

fc
accuracy(fit)
accuracy(fc, pbs_scripts)

pbs_a10 |> 
  autoplot(Scripts)
pbs_a10 |> 
  autoplot(box_cox(Scripts, guerrero(Scripts)))

pbs_a10 |> tail()

fit <- pbs_a10 |> 
  # Reserving data for forecast tests, training data here:
  filter(Month <= yearmonth("2006 Jun")) |> 
  model(
    ETS(Scripts),
    ARIMA(box_cox(Scripts, guerrero(Scripts)))
  )
accuracy(fit)
fc <- fit |> 
  forecast(h = "2 years") 
fc |> 
  autoplot(pbs_a10)
fc |> 
  accuracy(pbs_a10)


fc_cv <- pbs_scripts |> 
  # Keep some data for evaluating forecasts
  filter(Month <= yearmonth("2006 Jun")) |> 
  # Cross-validate the remaining data
  stretch_tsibble(.step = 24, .init = 48) |> 
  model(
    ETS(Scripts), 
    ARIMA(log(Scripts))
  ) |> 
  forecast(h = "2 years")

accuracy(fc_cv, pbs_scripts)


pbs_scripts |> 
  autoplot(Scripts)
fit <- pbs_scripts |> 
  model(ARIMA(Scripts ~ trend() + season()))
augment(fit) |> 
  autoplot(.innov)
augment(fit) |> 
  gg_season(.innov)

fit <- pbs_a10 |> 
  model(
    ETS(Scripts),
    ARIMA(log(Scripts))
  )
fit
augment(fit) |> 
  autoplot(.innov)

augment(fit) |> 
  gg_season(.innov)

augment(fit) |> 
  ACF(.innov) |> 
  autoplot()

fit |> 
  select(`ETS(Scripts)`) |> 
  gg_tsresiduals()

fit |> 
  select(`ARIMA(log(Scripts))`) |> 
  gg_tsresiduals()

augment(fit) |> 
  features(.innov, ljung_box, lag = 24)
