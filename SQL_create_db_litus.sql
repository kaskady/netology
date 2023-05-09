 --- создаем схему 

CREATE SCHEMA flew;

--- создаем справочник пассажиров Dim_Passengers

CREATE TABLE Dim_Passengers
(
	passenger_id varchar(20) NOT NULL, -- Идентификатор пассажира
 	passenger_name text NOT NULL, -- Имя пассажира
 	phone varchar(20), -- Телефон пассажира
 	email varchar(100) -- Email пассажира
);

SELECT * FROM Dim_Passengers;

DROP TABLE Dim_Passengers;

--- создаем справочник аэропортов Dim_Airports

CREATE TABLE Dim_Airports 
(
	 airport_code char(3) NOT NULL, -- Код аэропорта
	 airport_name text NOT NULL, -- Название аэропорта
	 city text NOT NULL, -- Город
	 longitude float NOT NULL, -- Координаты аэропорта: долгота
	 latitude float NOT NULL, -- Координаты аэропорта: широта
	 timezone text NOT NULL -- Временная зона аэропорта
);

SELECT * FROM Dim_Airports;



--- создаем справочник самолетов Dim_Airports

CREATE TABLE Dim_Aircrafts
(
	aircraft_code char(3) NOT NULL, -- Код самолета, IATA
	model text NOT NULL, -- Модель самолета
	range integer NOT NULL -- Максимальная дальность полета, км
);

SELECT * FROM Dim_Aircrafts;

--- создаем справочник тарифов (Эконом/бизнес и тд) Dim_Tariff

CREATE TABLE Dim_Tariff
(
	aircraft_code char(3) NOT NULL, -- Код самолета, IATA
	seat_no varchar(4) NOT NULL, -- Номер места
	fare_conditions varchar(10) NOT NULL -- Класс обслуживания
);

SELECT * FROM Dim_Tariff;

DROP TABLE Dim_Tariff;

--- создаем справочник дат Dim_Calendar

CREATE TABLE Dim_Calendar
AS WITH dates AS (
	SELECT dd::date AS dt
	FROM generate_series
			('2010-01-01'::timestamp,
			'2025-01-01'::timestamp,
			'1 day'::INTERVAL) dd 
	) 
	SELECT 
	to_char (dt, 'YYYYMMDD') AS id,
	dt AS date,
	date_part('month', dt)::int AS "month",
	date_part('year', dt)::int AS "year"
FROM dates
ORDER BY dt;

SELECT * FROM Dim_Calendar;

DROP TABLE Dim_Calendar;

DELETE FROM Dim_Calendar;

--- создаем таблицу фактов Fact_Flights

CREATE TABLE Fact_Flights
(
	passenger varchar(20) NOT NULL, -- Идентификатор пассажира
	actual_departure timestamp, -- Фактическое время вылета
 	actual_arrival timestamp, -- Фактическое время прилёта
 	delay_departure integer, -- Задержка вылета
 	delay_arrival integer, -- Задержка прилета
 	plane char(3) NOT NULL, -- Самолет
 	departure_airport char(3) NOT NULL, --- Аэропорт отправления
 	arrival_airport char(3) NOT NULL, --- Аэропорт прибытия
 	fare_conditions varchar(10) NOT NULL, -- Класс обслуживания
	amount numeric(10,2) NOT NULL -- Стоимость перелета 
);

SELECT * FROM Fact_Flights;

DROP TABLE Fact_Flights;

