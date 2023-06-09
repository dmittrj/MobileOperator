/* This query fills all tables in DB with some values */

USE MobileOperator_by_DmitryBalabanov;
DELETE FROM Billings;
DELETE FROM Sellings;
DELETE FROM Subscriber;
DELETE FROM Package;
DELETE FROM Passport;
DELETE FROM HomeAddress;
DELETE FROM UnlimitedServices;
DELETE FROM Tariff;
DELETE FROM Traffic;

INSERT INTO Tariff (tar_name, tar_description, tar_restrictions, tar_creating_date, tar_minutes, tar_minute_cost, tar_sms, tar_sms_cost, tar_internet, tar_mb_cost, tar_internet_speed, tar_cost, tar_archived)
VALUES
	('Старт', 'Тариф для тех, кто начинает пользоваться нашими услугами. Включает в себя 300 минут, 100 SMS и 1 Гб', NULL, '01/01/2022', 300, 4, 100, 10, 1.0, 0.1, NULL, 500, 0),
	('Пик', 'Тариф для тех, кто много общается. Включает в себя 1000 минут, 500 SMS и 5 Гб трафика в месяц.', NULL, '01/01/2022', 1000, 12, 500, 16, 5.0, 0.1, NULL, 1500, 0),
	('Максимальный', 'Самый полный тариф, включающий в себя все наши услуги. Неограниченное количество минут, SMS и 10 Гб', NULL, '01/01/2022', NULL, NULL, NULL, NULL, 10.0, 0.1, NULL, 3000, 0),
	('Эконом', 'Тариф для экономных пользователей, включающий в себя 100 минут, 50 SMS и 500 Мб трафика в месяц.', 'Недоступен для подключения жителям Москвы и области', '01/01/2022', 100, 3, 50, 7, 0.5, 0.05, NULL, 300, 0),
	('VIP', 'Тариф для тех, кто ценит скорость и качество связи. Включает в себя 500 минут, 200 SMS и 10 Гб', NULL, '01/01/2022', 500, 6, 200, 8, 10.0, 0.005, 100, 5000, 0),
	('Чат', 'Тариф для тех, кто много пишет сообщения. Неограниченное количество SMS и 1 Гб трафика в месяц.', NULL, '01/01/2022', NULL, NULL, NULL, NULL, 1.0, 0.05, NULL, 500, 1),
	('Премиум', 'Тариф для тех, кто хочет быть особенным. Включает в себя 2000 минут, 1000 SMS и 20 Гб трафика', NULL, '01/01/2022', 2000, 25, 1000, 40, 20.0, 1, NULL, 5000, 0);


INSERT INTO UnlimitedServices (unl_tariff, unl_service)
VALUES
	('Пик', 'vk.com'),
	('Пик', 'telegram.org'),
	('Пик', 'whatsapp.com'),
	('Пик', 'youtube.com'),
	('Пик', 'yandex.ru'),
	('Пик', 'wikipedia.org'),
	('Пик', 'mail.ru'),
	('Чат', 'telegram.org'),
	('Чат', 'whatsapp.com');


OPEN SYMMETRIC KEY SymKey_Encr_Address
DECRYPTION BY PASSWORD = 'AddressSymmetricKeyPassword123';
INSERT INTO HomeAddress (adr_id, adr_region, adr_city, adr_locality, adr_street, adr_home, adr_apartment)
VALUES
	(1, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Москва'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Басманный р-н'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Бакунинская'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'3'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'18')),
	(2, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Пушкин'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Пушкин'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Новая'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'8'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'47')),
	(3, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Зеленоград'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Зеленоград'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Спортивная'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'44'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'9')),
	(4, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Ростовская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Шахты'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Центральный'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Дзержинского'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'26/1'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'13')),
	(5, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Адмиралтейский'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Ленина'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'11'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'36')),
	(6, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Ростовская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Ростов-на-Дону'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Ленинский'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Октябрьской революции'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'105'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'68')),
	(7, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Кронштадт'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Центральный'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Новая'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'13а'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'12')),
	(8, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Москва'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Алтуфьевский р-н'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Стандартная'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'7'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'30')),
	(9, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Москва'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Красная Пресня'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Заморенова'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'39к4'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'80')),
	(10, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Кронштадт'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Центральный'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Васильевская'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'2'), 
		NULL),
	(11, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Москва'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Косино-Ухтомский'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Колхозная'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'40'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'6')),
	(12, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Зеленоград'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Зеленоград'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Зеленая'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'90/3'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'5')),
	(13, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Москва'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Лефортово'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Солдатская'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'22'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'41')),	
	(14, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Зеленоград'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Зеленоград'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Гагарина'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'5'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'30')),
	(15, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Кронштадт'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Центральный'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Васильевская'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'78'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'2')),
	(16, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Московская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Красногорск'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Райцентр'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Городская'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'122'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'11')),
	(17, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Василеостровский'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Елизаровская'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'38б'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'20')),
	(18, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Пушкин'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Шушары'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Южнопортовая'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'17к2'), 
		NULL),
	(19, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Санкт-Петербург'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Кировский'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Попова'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'1'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'33')),
	(20, ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Ростовская область'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Таганрог'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Соловки'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'Нижняя Казачья'), 
		ENCRYPTBYKEY(KEY_GUID('SymKey_Encr_Address'), N'8в'), 
		NULL);
CLOSE SYMMETRIC KEY SymKey_Encr_Address;


INSERT INTO Passport(ppt_series_number, ppt_issued_by, ppt_issued_date, ppt_division_code, ppt_date_of_birth, ppt_address, ppt_gender)
VALUES
	('1111 111111', 'МВД России', '2000/01/01', '123-456', '01/01/1990', 1, 'M'),
	('2222 222222', 'ФМС России', '2001/02/02', '654-321', '02/02/1991', 2, 'M'),
	('3333 333333', 'МВД России', '2002/03/03', '987-654', '03/03/1992', 3, 'M'),
	('4444 444444', 'ФМС России', '2003/04/04', '321-987', '04/04/1993', 4, 'M'),
	('5555 555555', 'МВД России', '2004/05/05', '654-321', '05/05/1994', 5, 'M'),
	('6666 666666', 'ФМС России', '2005/06/06', '123-456', '06/06/1995', 5, 'F'),
	('7777 777777', 'МВД России', '2006/07/07', '987-654', '07/07/1996', 6, 'M'),
	('8888 888888', 'ФМС России', '2007/08/08', '321-987', '08/08/1997', 7, 'F'),
	('9999 999999', 'МВД России', '2008/09/09', '654-321', '09/09/1998', 8, 'M'),
	('1010 101010', 'ФМС России', '2009/10/10', '123-456', '10/10/1999', 9, 'M'),
	('2020 202020', 'МВД России', '2010/11/11', '987-654', '11/11/2000', 10, 'F'),
	('3030 303030', 'ФМС России', '2011/12/12', '321-987', '12/12/2001', 11, 'M'),
	('4040 404040', 'МВД России', '2012/01/01', '654-321', '01/01/2002', 11, 'F'),
	('5050 505050', 'ФМС России', '2013/02/02', '123-456', '02/02/2003', 11, 'M'),
	('6060 606060', 'МВД России', '2014/03/03', '987-654', '03/03/2004', 12, 'M'),
	('7070 707070', 'ФМС России', '2015/04/04', '321-987', '04/04/2005', 13, 'M'),
	('8080 808080', 'МВД России', '2016/05/05', '654-321', '05/05/2006', 14, 'F'),
	('9090 909090', 'ФМС России', '2017/06/06', '123-456', '06/06/2007', 15, 'M'),
	('1212 121212', 'МВД России', '2018/07/07', '987-654', '07/07/2008', 16, 'M'),
	('2323 232323', 'ФМС России', '2019/08/08', '321-987', '08/08/2009', 17, 'M'),
	('3434 343434', 'МВД России', '2020/09/09', '654-321', '09/09/2010', 17, 'F'),
	('4545 454545', 'ФМС России', '2021/10/10', '123-456', '10/10/2011', 18, 'F'),
	('5656 565656', 'МВД России', '2022/11/11', '987-654', '11/11/2012', 19, 'M'),
	('6767 676767', 'ФМС России', '2023/12/12', '321-987', '12/12/2013', 20, 'M');



INSERT INTO Subscriber (sub_phone_number, sub_name, sub_passport, sub_joining_date, sub_tariff, sub_balance, sub_email)
VALUES
	('+79123456789', 'Голый Андрей Иванович', '1111 111111', '01/10/2021', 'Старт', 100, 'golyi@example.com'),
	('+79123456788', 'Гаражный Денис Витальевич', '2222 222222', '02/05/2020', 'Пик', 200, 'garazhny@example.com'),
	('+79123456787', 'Ровный Анатолий Петрович', '3333 333333', '03/09/2021', 'Пик', 300, 'rovnyi@example.com'),
	('+79123456786', 'Котов Иван Степанович', '4444 444444', '04/12/2019', 'Эконом', 400, 'kotov@example.com'),
	('+79123456785', 'Пыхтеловский Геннадий Андреевич', '5555 555555', '05/04/2022', 'Старт', 500, 'pykhtelovsky@example.com'),
	('+79123456784', 'Пыхтеловская Елена Эдуардовна', '6666 666666', '06/02/2021', 'Пик', 600, 'pykhtelovskaya@example.com'),
	('+79123456783', 'Поляк Петр Евгеньевич', '7777 777777', '07/10/2020', 'Премиум', 700, 'polyak@example.com'),
	('+79123456782', 'Гренкина Виктория Дмитриевна', '8888 888888', '08/07/2020', 'Чат', 800, 'grenkina@example.com'),
	('+79123456781', 'Безударный Владимир Николаевич', '9999 999999', '09/09/2020', 'VIP', 900, 'bezudarny@example.com'),
	('+79123456780', 'Громовой Матвей Витальевич', '1010 101010', '10/11/2022', 'Чат', 1000, 'gromovoy@example.com'),
	('+79123456779', 'Бурова Александра Александровна', '2020 202020', '11/12/2019', 'Пик', 100, 'burova@example.com'),
	('+79123456778', 'Федоров Борис Федорович', '3030 303030', '12/06/2021', 'Чат', 200, 'fedorov@example.com'),
	('+79123456777', 'Федорова Анастасия Владимировна', '4040 404040', '13/06/2021', 'Максимальный', 200, 'fedorova@example.com'),
	('+79123456776', 'Федоров Дмитрий Борисович', '5050 505050', '14/06/2021', 'Чат', 200, 'fedoroff@example.com'),
	('+79123456775', 'Хлебцев Вячеслав Ильич', '6060 606060', '15/03/2020', 'Пик', 200, 'khlebtsev@example.com'),
	('+79123456774', 'Блинов Николай Павлович', '7070 707070', '16/12/2022', 'Чат', 200, 'blinov@example.com'),
	('+79123456773', 'Дурасова София Викторовна', '8080 808080', '17/07/2020', 'Максимальный', 200, 'durasova@example.com'),
	('+79123456772', 'Ульянов Петр Алексеевич', '9090 909090', '18/03/2020', 'Пик', 200, 'ulyanov@example.com'),
	('+79123456771', 'Астапов Кирилл Николаевич', '1212 121212', '19/04/2021', 'Старт', 200, 'astapov@example.com'),
	('+79123456770', 'Капустин Олег Васильевич', '2323 232323', '20/09/2021', 'Пик', 200, 'kapustin@example.com'),
	('+79123456769', 'Капустина Ольга Валерьевна', '3434 343434', '21/11/2022', 'Чат', 200, 'kapustina@example.com'),
	('+79123456768', 'Сулейманова Аида Айсаровна', '4545 454545', '22/12/2022', 'VIP', 200, 'suleimanova@example.com'),
	('+79123456767', 'Прутов Егор Семенович', '5656 565656', '23/02/2020', 'Чат', 200, 'prutov@example.com'),
	('+79123456766', 'Рыбак Ярослав Олегович', '6767 676767', '24/12/2019', 'Максимальный', 200, 'rybak@example.com');


INSERT INTO Package (pck_subscriber, pck_minutes, pck_sms, pck_internet, pck_billing_date)
VALUES
	('+79123456789', 1020, 145, 6999540, 13),
	('+79123456788', 1020, 145, 6999540, 13),
	('+79123456787', 1020, 145, 6999540, 13),
	('+79123456786', 1020, 145, 6999540, 13),
	('+79123456785', 1020, 145, 6999540, 13),
	('+79123456784', 1020, 145, 6999540, 13),
	('+79123456783', 1020, 145, 6999540, 13),
	('+79123456782', 1020, 145, 6999540, 13),
	('+79123456781', 1020, 145, 6999540, 13),
	('+79123456780', 1020, 145, 6999540, 13),
	('+79123456779', 1020, 145, 6999540, 13),
	('+79123456778', 1020, 145, 6999540, 13),
	('+79123456777', 1020, 145, 6999540, 13),
	('+79123456776', 1020, 145, 6999540, 13),
	('+79123456775', 1020, 145, 6999540, 13),
	('+79123456774', 1020, 145, 6999540, 13),
	('+79123456773', 1020, 145, 6999540, 13),
	('+79123456772', 1020, 145, 6999540, 13),
	('+79123456771', 1020, 145, 6999540, 13),
	('+79123456770', 1020, 145, 6999540, 13),
	('+79123456769', 1020, 145, 6999540, 13),
	('+79123456768', 1020, 145, 6999540, 13),
	('+79123456767', 1020, 145, 6999540, 13),
	('+79123456766', 1020, 145, 6999540, 13);


DISABLE TRIGGER trig_sellingsInput ON Sellings;
INSERT INTO Sellings (sll_subscriber, sll_date, sll_tariff)
VALUES
	('+79123456789', '01/10/2021', 'Старт'),
	('+79123456788', '02/05/2020', 'Пик'),
	('+79123456787', '03/09/2021', 'Пик'),
	('+79123456786', '04/12/2019', 'Эконом'),
	('+79123456785', '05/04/2022', 'Старт'),
	('+79123456784', '06/02/2021', 'Пик'),
	('+79123456783', '07/01/2020', 'Пик'),
	('+79123456783', '07/05/2020', 'VIP'),
	('+79123456783', '07/10/2020', 'Премиум'),
	('+79123456782', '08/07/2020', 'Чат'),
	('+79123456781', '09/09/2020', 'VIP'),
	('+79123456780', '10/11/2022', 'Чат'),
	('+79123456779', '11/12/2019', 'Пик'),
	('+79123456778', '12/06/2021', 'Чат'),
	('+79123456777', '13/01/2021', 'Старт'),
	('+79123456777', '13/06/2021', 'Максимальный'),
	('+79123456776', '14/06/2021', 'Чат'),
	('+79123456775', '15/03/2020', 'Пик'),
	('+79123456774', '16/12/2022', 'Чат'),
	('+79123456773', '17/07/2020', 'Максимальный'),
	('+79123456772', '18/03/2020', 'Пик'),
	('+79123456771', '19/04/2021', 'Старт'),
	('+79123456770', '20/09/2021', 'Пик'),
	('+79123456769', '21/11/2022', 'Чат'),
	('+79123456768', '22/12/2021', 'Пик'),
	('+79123456768', '22/03/2022', 'Чат'),
	('+79123456768', '22/12/2022', 'VIP'),
	('+79123456767', '23/02/2020', 'Чат'),
	('+79123456766', '24/12/2019', 'Максимальный');
ENABLE TRIGGER trig_sellingsInput ON Sellings;

DISABLE TRIGGER trig_billingsInput ON Billings;
INSERT INTO Billings (bll_subscriber, bll_date, bll_money)
VALUES
	('+79123456789', '01/10/2021', 100),
	('+79123456788', '02/05/2020', 200),
	('+79123456787', '03/09/2021', 300),
	('+79123456786', '04/12/2019', 400),
	('+79123456785', '05/04/2022', 500),
	('+79123456784', '06/02/2021', 600),
	('+79123456783', '07/10/2020', 700),
	('+79123456782', '08/07/2020', 800),
	('+79123456781', '09/09/2020', 900),
	('+79123456780', '10/11/2022', 1000),
	('+79123456779', '11/12/2019', 100),
	('+79123456778', '12/06/2021', 200),
	('+79123456777', '13/06/2021', 200),
	('+79123456776', '14/06/2021', 200),
	('+79123456775', '15/03/2020', 200),
	('+79123456774', '16/12/2022', 200),
	('+79123456773', '17/07/2020', 200),
	('+79123456772', '18/03/2020', 200),
	('+79123456771', '19/04/2021', 200),
	('+79123456770', '20/09/2021', 200),
	('+79123456769', '21/11/2022', 200),
	('+79123456768', '22/12/2022', 200),
	('+79123456767', '23/02/2020', 200),
	('+79123456766', '24/12/2019', 200);
ENABLE TRIGGER trig_billingsInput ON Billings;


DECLARE @phones TABLE (
    phone VARCHAR(20) NOT NULL
)

DECLARE @types TABLE (
    type_ VARCHAR(15) NOT NULL
)

INSERT INTO @types VALUES ('Outgoing call'), ('SMS'), ('Internet')

INSERT INTO @phones
SELECT sub_phone_number FROM Subscriber

DECLARE @startDate DATETIME = '01/11/2019'
DECLARE @endDate DATETIME = '31/12/2022'

DECLARE @count INT = 1
WHILE @count <= 5000
BEGIN
	DECLARE @cur_type VARCHAR(15) = (SELECT TOP(1) type_ FROM @types ORDER BY NEWID());
    INSERT INTO Traffic (trf_subscriber, trf_datetime, trf_type, trf_description, trf_amount, trf_pay)
    SELECT TOP(1) phone, DATEADD(day, ABS(CHECKSUM(NEWID())) % DATEDIFF(day, @startDate, @endDate), @startDate) AS q, @cur_type AS trf_type,
    CASE (@cur_type)
        WHEN 'Outgoing call' THEN CAST(ABS(CHECKSUM(NEWID())) % 1000000000 + 1000000000 AS VARCHAR(20))
        WHEN 'SMS' THEN CAST(ABS(CHECKSUM(NEWID())) % 1000000000 + 1000000000 AS VARCHAR(20))
        WHEN 'Internet' THEN 'www.mysite.com'
    END,
    CASE (@cur_type)
        WHEN 'Outgoing call' THEN CAST(ABS(CHECKSUM(NEWID())) % 30 + 1 AS DECIMAL(5, 2))
        WHEN 'SMS' THEN CAST(ABS(CHECKSUM(NEWID())) % 2 + 1 AS DECIMAL(5, 2))
        WHEN 'Internet' THEN CAST(ABS(CHECKSUM(NEWID())) % 180001 + 2000 AS DECIMAL(10, 2))
    END, 0
    FROM @phones
    ORDER BY NEWID()
    SET @count = @count + 1
END