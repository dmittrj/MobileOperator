/* This query fills all tables in DB with some values */

USE MobileOperator_by_DmitryBalabanov;
DELETE FROM Subscriber;
DELETE FROM Passport;
DELETE FROM HomeAddress;
DELETE FROM Tariff;

INSERT INTO Tariff (tar_name, tar_description, tar_restrictions, tar_creating_date, tar_minutes, tar_sms, tar_internet, tar_internet_speed, tar_cost, tar_archived)
VALUES
	('Старт', 'Тариф для тех, кто только начинает пользоваться услугами нашей компании. Включает в себя 300 минут, 100 SMS и 1 Гб трафика в месяц.', NULL, '2022-01-01', 300, 100, 1.0, NULL, 500, 0),
	('Пик', 'Тариф для тех, кто много общается. Включает в себя 1000 минут, 500 SMS и 5 Гб трафика в месяц.', NULL, '2022-01-01', 1000, 500, 5.0, NULL, 1500, 0),
	('Максимальный', 'Самый полный тариф, включающий в себя все наши услуги. Неограниченное количество минут, SMS и 10 Гб трафика в месяц.', '2022-01-01', NULL, NULL, 10.0, 50, 3000, 0),
	('Эконом', 'Тариф для экономных пользователей, включающий в себя 100 минут, 50 SMS и 500 Мб трафика в месяц.', 'Недоступен для подключения жителяем Москвы и области', '2022-01-01', 100, 50, 0.5, NULL, 300, 0),
	('VIP', 'Тариф для тех, кто ценит скорость и качество связи. Включает в себя 500 минут, 200 SMS и 10 Гб трафика в месяц, а также высокоскоростной интернет.', NULL, '2022-01-01', 500, 200, 10.0, 100, 5000, 0),
	('Чат', 'Тариф для тех, кто много пишет сообщения. Неограниченное количество SMS и 1 Гб трафика в месяц.', NULL, '2022-01-01', NULL, NULL, 1.0, NULL, 500, 1),
	('Премиум', 'Тариф для тех, кто хочет быть особенным. Включает в себя 2000 минут, 1000 SMS и 20 Гб трафика в месяц.', NULL, '2022-01-01', 2000, 1000, 20.0, NULL, 5000, 0);


INSERT INTO HomeAddress (adr_id, adr_region, adr_city, adr_locality, adr_street, adr_home, adr_apartment)
VALUES
	(1, 'Московская область', 'Москва', 'Басманный р-н', 'Бакунинская', '3', '9'),
	(2, 'Санкт-Петербург', 'Пушкин', 'Пушкин', 'Новая', '8', '47'),
	(3, 'Московская область', 'Зеленоград', 'Зеленоград', 'Спортивная', '44', '9'),
	(4, 'Ростовская область', 'Шахты', 'Центральный', 'Дзержинского', '26/1', '13'),
	(5, 'Санкт-Петербург', 'Санкт-Петербург', 'Адмиралтейский', 'Ленина', '11', '36'),
	(6, 'Ростовская область', 'Ростов-на-Дону', 'Ленинский', 'Октябрьской революции', '105', '68'),
	(7, 'Санкт-Петербург', 'Кронштадт', 'Центральный', 'Новая', '13а', '12'),
	(8, 'Московская область', 'Москва', 'Алтуфьевский р-н', 'Стандартная', '7', '30'),
	(9, 'Московская область', 'Москва', 'Красная Пресня', 'Заморенова', '39к4', '80'),
	(10, 'Санкт-Петербург', 'Кронштадт', 'Центральный', 'Васильевская', '2', NULL),
	(11, 'Московская область', 'Москва', 'Косино-Ухтомский', 'Колхозная', '40', '6'),
	(12, 'Московская область', 'Зеленоград', 'Зеленоград', 'Зеленая', '90/3', '5'),
	(13, 'Московская область', 'Москва', 'Лефортово', 'Солдатская', '22', '41'),	
	(14, 'Московская область', 'Зеленоград', 'Зеленоград', 'Гагарина', '5', '30'),
	(15, 'Санкт-Петербург', 'Кронштадт', 'Центральный', 'Васильевская', '78', '2'),
	(16, 'Московская область', 'Красногорск', 'Райцентр', 'Городская', '122', '11'),
	(17, 'Санкт-Петербург', 'Санкт-Петербург', 'Василеостровский', 'Елизаровская', '38б', '20'),
	(18, 'Санкт-Петербург', 'Пушкин', 'Шушары', 'Южнопортовая', '17к2', NULL),
	(19, 'Санкт-Петербург', 'Санкт-Петербург', 'Кировский', 'Попова', '1', '33'),
	(20, 'Ростовская область', 'Таганрог', 'Соловки', 'Нижняя Казачья', '8в', NULL);


INSERT INTO Passport(ppt_series_number, ppt_issued_by, ppt_issued_date, ppt_division_code, ppt_date_of_birth, ppt_address, ppt_gender)
VALUES
	('1111 111111', 'МВД России', '2000-01-01', '123-456', '1990-01-01', 1, 'M'),
	('2222 222222', 'ФМС России', '2001-02-02', '654-321', '1991-02-02', 2, 'F'),
	('3333 333333', 'МВД России', '2002-03-03', '987-654', '1992-03-03', 3, 'M'),
	('4444 444444', 'ФМС России', '2003-04-04', '321-987', '1993-04-04', 4, 'F'),
	('5555 555555', 'МВД России', '2004-05-05', '654-321', '1994-05-05', 5, 'M'),
	('6666 666666', 'ФМС России', '2005-06-06', '123-456', '1995-06-06', 5, 'F'),
	('7777 777777', 'МВД России', '2006-07-07', '987-654', '1996-07-07', 6, 'M'),
	('8888 888888', 'ФМС России', '2007-08-08', '321-987', '1997-08-08', 7, 'F'),
	('9999 999999', 'МВД России', '2008-09-09', '654-321', '1998-09-09', 8, 'M'),
	('1010 101010', 'ФМС России', '2009-10-10', '123-456', '1999-10-10', 9, 'F'),
	('2020 202020', 'МВД России', '2010-11-11', '987-654', '2000-11-11', 10, 'M'),
	('3030 303030', 'ФМС России', '2011-12-12', '321-987', '2001-12-12', 11, 'F'),
	('4040 404040', 'МВД России', '2012-01-01', '654-321', '2002-01-01', 11, 'M'),
	('5050 505050', 'ФМС России', '2013-02-02', '123-456', '2003-02-02', 11, 'F'),
	('6060 606060', 'МВД России', '2014-03-03', '987-654', '2004-03-03', 12, 'M'),
	('7070 707070', 'ФМС России', '2015-04-04', '321-987', '2005-04-04', 13, 'F'),
	('8080 808080', 'МВД России', '2016-05-05', '654-321', '2006-05-05', 14, 'M'),
	('9090 909090', 'ФМС России', '2017-06-06', '123-456', '2007-06-06', 15, 'F'),
	('1212 121212', 'МВД России', '2018-07-07', '987-654', '2008-07-07', 16, 'M'),
	('2323 232323', 'ФМС России', '2019-08-08', '321-987', '2009-08-08', 17, 'F'),
	('3434 343434', 'МВД России', '2020-09-09', '654-321', '2010-09-09', 17, 'M'),
	('4545 454545', 'ФМС России', '2021-10-10', '123-456', '2011-10-10', 18, 'F'),
	('5656 565656', 'МВД России', '2022-11-11', '987-654', '2012-11-11', 19, 'M'),
	('6767 676767', 'ФМС России', '2023-12-12', '321-987', '2013-12-12', 20, 'F');


INSERT INTO Package (pck_subscriber, pck_minutes, pck_sms, pck_internet, pck_billing_date)
VALUES
	('+79123456789', 23, 100, 64, 2),
	('+79123456788', 17, 100, 12, 7),
	('+79123456787', 89, 100, 98, 16),
	('+79123456786', 67, 100, 88, 8),
	('+79123456785', 48, 100, 46, 10),
	('+79123456784', 10, 100, 26, 6),
	('+79123456783', 58, 100, 68, 5),
	('+79123456782', 38, 100, 46, 2),
	('+79123456781', 86, 100, 49, 21),
	('+79123456780', 3, 100, 13, 27);


INSERT INTO Subscriber (sub_phone_number, sub_name, sub_passport, sub_joining_date, sub_tariff, sub_balance, sub_email)
VALUES
	('+79123456789', 'Голый Андрей Иванович', '1111 111111', '2021-10-01', 1, 100, 'golyi@example.com'),
	('+79123456788', 'Гаражный Денис Витальевич', '2222 222222', '2020-05-02', 4, 200, 'garazhny@example.com'),
	('+79123456787', 'Ровный Анатолий Петрович', '3333 333333', '2021-09-03', 1, 300, 'rovnyi@example.com'),
	('+79123456786', 'Котов Иван Степанович', '4444 444444', '2019-12-04', 1, 400, 'kotov@example.com'),
	('+79123456785', 'Пыхтеловский Геннадий Андреевич', '5555 555555', '2022-04-05', 2, 500, 'pykhtelovsky@example.com'),
	('+79123456784', 'Пыхтеловская Елена Эдуардовна', '6666 666666', '2021-02-06', 3, 600, 'pykhtelovskaya@example.com'),
	('+79123456783', 'Поляк Петр Евгеньевич', '7777 777777', '2020-10-07', 1, 700, 'polyak@example.com'),
	('+79123456782', 'Гренкина Виктория Дмитриевна', '8888 888888', '2020-07-08', 1, 800, 'grenkina@example.com'),
	('+79123456781', 'Безударный Владимир Николаевич', '9999 999999', '2020-09-09', 4, 900, 'bezudarny@example.com'),
	('+79123456780', 'Громовой Матвей Витальевич', '1010 101010', '2022-11-10', 2, 1000, 'gromovoy@example.com'),
	('+79123456779', 'Бурова Александра Александровна', '2020 202020', '2019-12-11', 2, 100, 'burova@example.com'),
	('+79123456778', 'Федоров Борис Федорович', '3030 303030', '2021-06-12', 2, 200, 'fedorov@example.com'),
	('+79123456777', 'Федорова Анастасия Владимировна', '4040 404040', '2021-06-13', 2, 200, 'fedorova@example.com'),
	('+79123456776', 'Федоров Дмитрий Борисович', '5050 505050', '2021-06-14', 2, 200, 'fedoroff@example.com'),
	('+79123456775', 'Хлебцев Вячеслав Ильич', '6060 606060', '2020-03-15', 2, 200, 'khlebtsev@example.com'),
	('+79123456774', 'Блинов Николай Павлович', '7070 707070', '2022-12-16', 2, 200, 'blinov@example.com'),
	('+79123456773', 'Дурасова София Викторовна', '8080 808080', '2020-07-17', 2, 200, 'durasova@example.com'),
	('+79123456772', 'Ульянов Петр Алексеевич', '9090 909090', '2020-03-18', 2, 200, 'ulyanov@example.com'),
	('+79123456771', 'Астапов Кирилл Николаевич', '1212 121212', '2021-04-19', 2, 200, 'astapov@example.com'),
	('+79123456770', 'Капустин Олег Васильевич', '2323 232323', '2021-09-20', 2, 200, 'kapustin@example.com'),
	('+79123456769', 'Капустина Ольга Валерьевна', '3434 343434', '2022-11-21', 2, 200, 'kapustina@example.com'),
	('+79123456768', 'Сулейманова Аида Айсаровна', '4545 454545', '2022-12-22', 2, 200, 'suleimanova@example.com'),
	('+79123456767', 'Прутов Егор Семенович', '5656 565656', '2020-02-23', 2, 200, 'prutov@example.com'),
	('+79123456766', 'Рыбак Ярослав Олегович', '6767 676767', '2019-12-24', 2, 200, 'rybak@example.com');

