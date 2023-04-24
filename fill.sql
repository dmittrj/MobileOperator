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

INSERT INTO Tariff (tar_name, tar_description, tar_restrictions, tar_creating_date, tar_minutes, tar_sms, tar_internet, tar_internet_speed, tar_cost, tar_archived)
VALUES
	('Старт', 'Тариф для тех, кто начинает пользоваться нашими услугами. Включает в себя 300 минут, 100 SMS и 1 Гб', NULL, '01/01/2022', 300, 100, 1.0, NULL, 500, 0),
	('Пик', 'Тариф для тех, кто много общается. Включает в себя 1000 минут, 500 SMS и 5 Гб трафика в месяц.', NULL, '01/01/2022', 1000, 500, 5.0, NULL, 1500, 0),
	('Максимальный', 'Самый полный тариф, включающий в себя все наши услуги. Неограниченное количество минут, SMS и 10 Гб', NULL, '01/01/2022', NULL, NULL, 10.0, 50, 3000, 0),
	('Эконом', 'Тариф для экономных пользователей, включающий в себя 100 минут, 50 SMS и 500 Мб трафика в месяц.', 'Недоступен для подключения жителям Москвы и области', '01/01/2022', 100, 50, 0.5, NULL, 300, 0),
	('VIP', 'Тариф для тех, кто ценит скорость и качество связи. Включает в себя 500 минут, 200 SMS и 10 Гб', NULL, '01/01/2022', 500, 200, 10.0, 100, 5000, 0),
	('Чат', 'Тариф для тех, кто много пишет сообщения. Неограниченное количество SMS и 1 Гб трафика в месяц.', NULL, '01/01/2022', NULL, NULL, 1.0, NULL, 500, 1),
	('Премиум', 'Тариф для тех, кто хочет быть особенным. Включает в себя 2000 минут, 1000 SMS и 20 Гб трафика', NULL, '01/01/2022', 2000, 1000, 20.0, NULL, 5000, 0);


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
	('+79123456789', 20, 45, 40, 13),
	('+79123456788', 20, 45, 40, 13),
	('+79123456787', 20, 45, 40, 13),
	('+79123456786', 20, 45, 40, 13),
	('+79123456785', 20, 45, 40, 13),
	('+79123456784', 20, 45, 40, 13),
	('+79123456783', 20, 45, 40, 13),
	('+79123456782', 20, 45, 40, 13),
	('+79123456781', 20, 45, 40, 13),
	('+79123456780', 20, 45, 40, 13),
	('+79123456779', 20, 45, 40, 13),
	('+79123456778', 20, 45, 40, 13),
	('+79123456777', 20, 45, 40, 13),
	('+79123456776', 20, 45, 40, 13),
	('+79123456775', 20, 45, 40, 13),
	('+79123456774', 20, 45, 40, 13),
	('+79123456773', 20, 45, 40, 13),
	('+79123456772', 20, 45, 40, 13),
	('+79123456771', 20, 45, 40, 13),
	('+79123456770', 20, 45, 40, 13),
	('+79123456769', 20, 45, 40, 13),
	('+79123456768', 20, 45, 40, 13),
	('+79123456767', 20, 45, 40, 13),
	('+79123456766', 20, 45, 40, 13);



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


/*INSERT INTO Traffic (trf_subscriber, trf_datetime, trf_type, trf_description, trf_amount, trf_pay) VALUES 
	('+79123456789', '01/01/2020', 'Outgoing call', '+79876543210', 1, 0),
	('+79123456788', '02/02/2021', 'Outgoing call', '+79876543211', 2, 0),
	('+79123456787', '03/03/2020', 'Outgoing call', '+79876543212', 3, 0),
	('+79123456786', '04/04/2021', 'Outgoing call', '+79876543213', 4, 0),
	('+79123456785', '05/05/2020', 'Outgoing call', '+79876543214', 5, 0),
	('+79123456784', '06/06/2021', 'Outgoing call', '+79876543215', 6, 0),
	('+79123456783', '07/07/2020', 'Outgoing call', '+79876543216', 7, 0),
	('+79123456782', '08/08/2021', 'Outgoing call', '+79876543217', 8, 0),
	('+79123456781', '09/09/2020', 'Outgoing call', '+79876543218', 9, 0),
	('+79123456780', '10/10/2021', 'Outgoing call', '+79876543219', 10, 0),
	('+79123456779', '11/11/2020', 'Outgoing call', '+79876543220', 11, 0),
	('+79123456778', '12/12/2021', 'Outgoing call', '+79876543221', 12, 0),
	('+79123456777', '13/01/2020', 'Outgoing call', '+79876543222', 13, 0),
	('+79123456776', '14/02/2021', 'Outgoing call', '+79876543223', 14, 0),
	('+79123456775', '15/03/2020', 'Outgoing call', '+79876543224', 15, 0),
	('+79123456774', '16/04/2021', 'Outgoing call', '+79876543225', 16, 0),
	('+79123456773', '17/05/2020', 'Outgoing call', '+79876543226', 17, 0),
	('+79123456772', '18/06/2021', 'Outgoing call', '+79876543227', 18, 0),
	('+79123456771', '19/07/2020', 'Outgoing call', '+79876543228', 19, 0),
	('+79123456770', '20/08/2021', 'Outgoing call', '+79876543229', 20, 0),
	('+79123456769', '21/09/2020', 'Outgoing call', '+79876543230', 21, 0),
	('+79123456768', '22/10/2021', 'Outgoing call', '+79876543231', 22, 2),
	('+79123456767', '23/11/2020', 'Outgoing call', '+79876543232', 23, 6),
	('+79123456766', '24/12/2021', 'Outgoing call', '+79876543233', 24, 10),
	
	('+79123456789', '13/01/2020', 'SMS', '+79876543210', 1, 0),
	('+79123456788', '14/02/2021', 'SMS', '+79876543211', 1, 0),
	('+79123456787', '15/03/2020', 'SMS', '+79876543212', 1, 0),
	('+79123456786', '16/04/2021', 'SMS', '+79876543213', 1, 0),
	('+79123456785', '17/05/2020', 'SMS', '+79876543214', 1, 0),
	('+79123456784', '18/06/2021', 'SMS', '+79876543215', 1, 0),
	('+79123456783', '19/07/2020', 'SMS', '+79876543216', 1, 0),
	('+79123456782', '20/08/2021', 'SMS', '+79876543217', 1, 0),
	('+79123456781', '21/09/2020', 'SMS', '+79876543218', 1, 0),
	('+79123456780', '22/10/2021', 'SMS', '+79876543219', 2, 0),
	('+79123456779', '23/11/2020', 'SMS', '+79876543220', 1, 3),
	('+79123456778', '24/12/2021', 'SMS', '+79876543221', 1, 0),
	('+79123456777', '01/01/2020', 'SMS', '+79876543222', 1, 0),
	('+79123456776', '02/02/2021', 'SMS', '+79876543223', 1, 0),
	('+79123456775', '03/03/2020', 'SMS', '+79876543224', 1, 0),
	('+79123456774', '04/04/2021', 'SMS', '+79876543225', 1, 0),
	('+79123456773', '05/05/2020', 'SMS', '+79876543226', 1, 0),
	('+79123456772', '06/06/2021', 'SMS', '+79876543227', 1, 0),
	('+79123456771', '07/07/2020', 'SMS', '+79876543228', 1, 0),
	('+79123456770', '08/08/2021', 'SMS', '+79876543229', 1, 0),
	('+79123456769', '09/09/2020', 'SMS', '+79876543230', 1, 0),
	('+79123456768', '10/10/2021', 'SMS', '+79876543231', 1, 0),
	('+79123456767', '11/11/2020', 'SMS', '+79876543232', 1, 0),
	('+79123456766', '12/12/2021', 'SMS', '+79876543233', 1, 3),
	
	('+79123456789', '19/07/2020', 'Internet', 'vk.com', 4512, 0),
	('+79123456788', '20/08/2021', 'Internet', 'youtube.com', 22917, 0),
	('+79123456787', '21/09/2020', 'Internet', 'telegram.org', 5610, 0),
	('+79123456786', '22/10/2021', 'Internet', 'example.com', 10923, 0),
	('+79123456785', '23/11/2020', 'Internet', 'example2.ru', 5348, 0),
	('+79123456784', '24/12/2021', 'Internet', 'example3.net', 31987, 0),
	('+79123456783', '01/01/2020', 'Internet', 'vk.com', 4512, 0),
	('+79123456782', '02/02/2021', 'Internet', 'youtube.com', 22917, 0),
	('+79123456781', '03/03/2020', 'Internet', 'telegram.org', 5610, 0),
	('+79123456780', '04/04/2021', 'Internet', 'example.com', 10923, 0),
	('+79123456779', '05/05/2020', 'Internet', 'example2.ru', 5348, 0),
	('+79123456778', '06/06/2021', 'Internet', 'example3.net', 31987, 0),
	('+79123456777', '07/07/2020', 'Internet', 'vk.com', 4512, 0),
	('+79123456776', '08/08/2021', 'Internet', 'youtube.com', 22917, 0),
	('+79123456775', '09/09/2020', 'Internet', 'telegram.org', 5610, 0),
	('+79123456774', '10/10/2021', 'Internet', 'example.com', 10923, 0),
	('+79123456773', '11/11/2020', 'Internet', 'example2.ru', 5348, 0),
	('+79123456772', '12/12/2021', 'Internet', 'example3.net', 31987, 0),
	('+79123456771', '13/01/2020', 'Internet', 'vk.com', 4512, 0),
	('+79123456770', '14/02/2021', 'Internet', 'youtube.com', 22917, 0),
	('+79123456769', '15/03/2020', 'Internet', 'telegram.org', 5610, 0),
	('+79123456768', '16/04/2021', 'Internet', 'example.com', 10923, 0),
	('+79123456767', '17/05/2020', 'Internet', 'example2.ru', 5348, 0),
	('+79123456766', '18/06/2021', 'Internet', 'example3.net', 31987, 0),

	('+79123456789', '03/01/2020', 'Outgoing call', '+79876543210', 21, 0),
	('+79123456788', '04/02/2021', 'Outgoing call', '+79876543211', 12, 0),
	('+79123456787', '05/03/2020', 'Outgoing call', '+79876543212', 23, 0),
	('+79123456786', '06/04/2021', 'Outgoing call', '+79876543213', 14, 0),
	('+79123456785', '07/05/2020', 'Outgoing call', '+79876543214', 25, 0),
	('+79123456784', '08/01/2021', 'Outgoing call', '+79876543215', 16, 0),
	('+79123456783', '09/02/2020', 'Outgoing call', '+79876543216', 27, 0),
	('+79123456782', '02/03/2021', 'Outgoing call', '+79876543217', 18, 0),
	('+79123456781', '01/04/2020', 'Outgoing call', '+79876543218', 29, 0),
	('+79123456780', '12/05/2021', 'Outgoing call', '+79876543219', 10, 0),
	('+79123456779', '13/01/2020', 'Outgoing call', '+79876543220', 21, 0),
	('+79123456778', '14/02/2021', 'Outgoing call', '+79876543221', 32, 0),
	('+79123456777', '15/03/2020', 'Outgoing call', '+79876543222', 23, 0),
	('+79123456776', '03/04/2021', 'Outgoing call', '+79876543223', 14, 0),
	('+79123456775', '04/05/2020', 'Outgoing call', '+79876543224', 35, 0),
	('+79123456774', '05/01/2021', 'Outgoing call', '+79876543225', 26, 0),
	('+79123456773', '06/02/2020', 'Outgoing call', '+79876543226', 17, 0),
	('+79123456772', '07/03/2021', 'Outgoing call', '+79876543227', 38, 0),
	('+79123456771', '08/04/2020', 'Outgoing call', '+79876543228', 29, 0),
	('+79123456770', '09/05/2021', 'Outgoing call', '+79876543229', 20, 0),
	('+79123456769', '07/01/2020', 'Outgoing call', '+79876543230', 31, 0),
	('+79123456768', '01/02/2021', 'Outgoing call', '+79876543231', 22, 2),
	('+79123456767', '12/03/2020', 'Outgoing call', '+79876543232', 33, 6),
	('+79123456766', '13/04/2021', 'Outgoing call', '+79876543233', 24, 1),
	
	('+79123456789', '04/09/2020', 'SMS', '+79876543210', 1, 0),
	('+79123456788', '05/10/2021', 'SMS', '+79876543211', 2, 0),
	('+79123456787', '06/11/2020', 'SMS', '+79876543212', 1, 0),
	('+79123456786', '07/12/2021', 'SMS', '+79876543213', 1, 0),
	('+79123456785', '08/01/2020', 'SMS', '+79876543214', 1, 0),
	('+79123456784', '04/02/2021', 'SMS', '+79876543215', 1, 0),
	('+79123456783', '05/03/2020', 'SMS', '+79876543216', 1, 3),
	('+79123456782', '06/04/2021', 'SMS', '+79876543217', 1, 0),
	('+79123456781', '07/05/2020', 'SMS', '+79876543218', 1, 0),
	('+79123456780', '08/09/2021', 'SMS', '+79876543219', 1, 0),
	('+79123456779', '04/10/2020', 'SMS', '+79876543220', 1, 3),
	('+79123456778', '05/11/2021', 'SMS', '+79876543221', 1, 0),
	('+79123456777', '06/12/2020', 'SMS', '+79876543222', 1, 0),
	('+79123456776', '07/01/2021', 'SMS', '+79876543223', 1, 0),
	('+79123456775', '08/02/2020', 'SMS', '+79876543224', 1, 0),
	('+79123456774', '04/03/2021', 'SMS', '+79876543225', 1, 0),
	('+79123456773', '05/04/2020', 'SMS', '+79876543226', 1, 0),
	('+79123456772', '06/05/2021', 'SMS', '+79876543227', 1, 3),
	('+79123456771', '07/07/2020', 'SMS', '+79876543228', 2, 0),
	('+79123456770', '08/02/2021', 'SMS', '+79876543229', 1, 0),
	('+79123456769', '09/03/2020', 'SMS', '+79876543230', 1, 0),
	('+79123456768', '11/04/2021', 'SMS', '+79876543231', 1, 0),
	('+79123456767', '20/05/2020', 'SMS', '+79876543232', 3, 0),
	('+79123456766', '16/09/2021', 'SMS', '+79876543233', 1, 3),
	
	('+79123456789', '01/12/2020', 'Internet', 'vk.com', 14512, 0),
	('+79123456788', '02/01/2021', 'Internet', 'youtube.com', 222917, 0),
	('+79123456787', '03/02/2020', 'Internet', 'telegram.org', 35610, 0),
	('+79123456786', '04/03/2021', 'Internet', 'example.com', 410923, 0),
	('+79123456785', '05/04/2020', 'Internet', 'example2.ru', 55348, 0),
	('+79123456784', '01/05/2021', 'Internet', 'example3.net', 631987, 0),
	('+79123456783', '02/06/2020', 'Internet', 'vk.com', 74512, 0),
	('+79123456782', '03/12/2021', 'Internet', 'youtube.com', 822917, 0),
	('+79123456781', '04/01/2020', 'Internet', 'telegram.org', 95610, 0),
	('+79123456780', '05/02/2021', 'Internet', 'example.com', 110923, 0),
	('+79123456779', '10/03/2020', 'Internet', 'example2.ru', 25348, 0),
	('+79123456778', '11/04/2021', 'Internet', 'example3.net', 331987, 0),
	('+79123456777', '12/05/2020', 'Internet', 'vk.com', 44512, 0),
	('+79123456776', '13/06/2021', 'Internet', 'youtube.com', 522917, 0),
	('+79123456775', '14/09/2020', 'Internet', 'telegram.org', 65610, 0),
	('+79123456774', '15/10/2021', 'Internet', 'example.com', 710923, 0),
	('+79123456773', '11/11/2020', 'Internet', 'example2.ru', 85348, 0),
	('+79123456772', '12/12/2021', 'Internet', 'example3.net', 931987, 0),
	('+79123456771', '13/01/2020', 'Internet', 'vk.com', 14512, 0),
	('+79123456770', '14/02/2021', 'Internet', 'youtube.com', 222917, 0),
	('+79123456769', '15/03/2020', 'Internet', 'telegram.org', 35610, 0),
	('+79123456768', '16/04/2021', 'Internet', 'example.com', 410923, 0),
	('+79123456767', '17/05/2020', 'Internet', 'example2.ru', 55348, 0),
	('+79123456766', '18/06/2021', 'Internet', 'example3.net', 631987, 0);*/

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

DECLARE @newTraffic TABLE (
    trf_subscriber VARCHAR(20) NOT NULL,
    trf_datetime DATETIME NOT NULL,
    trf_type VARCHAR(15) NOT NULL,
    trf_description VARCHAR(255) NOT NULL,
    trf_amount DECIMAL NOT NULL,
    trf_pay SMALLMONEY NOT NULL
)

DECLARE @count INT = 1
WHILE @count <= 200
BEGIN
    INSERT INTO @newTraffic (trf_subscriber, trf_datetime, trf_type, trf_description, trf_amount, trf_pay)
    SELECT TOP (1) phone, DATEADD(day, ABS(CHECKSUM(NEWID())) % DATEDIFF(day, @startDate, @endDate), @startDate) AS q, (SELECT TOP(1) type_ FROM @types ORDER BY NEWID()) AS trf_type,
    CASE (SELECT TOP(1) type_ FROM @types ORDER BY NEWID())
        WHEN 'Outgoing call' THEN CAST(ABS(CHECKSUM(NEWID())) % 1000000000 + 1000000000 AS VARCHAR(20))
        WHEN 'SMS' THEN CAST(ABS(CHECKSUM(NEWID())) % 1000000000 + 1000000000 AS VARCHAR(20))
        WHEN 'Internet' THEN 'www.' + LEFT(LOWER(NEWID()), 5) + '.com'
    END,
    CASE (SELECT TOP(1) type_ FROM @types ORDER BY NEWID())
        WHEN 'Outgoing call' THEN CAST(ABS(CHECKSUM(NEWID())) % 30 + 1 AS DECIMAL(5, 2))
        WHEN 'SMS' THEN CAST(ABS(CHECKSUM(NEWID())) % 30 + 1 AS DECIMAL(5, 2))
        WHEN 'Internet' THEN CAST(ABS(CHECKSUM(NEWID())) % 180001 + 2000 AS DECIMAL(10, 2))
    END,
    0
    FROM @phones
    ORDER BY NEWID()
    SET @count = @count + 1
END

INSERT INTO Traffic (trf_subscriber, trf_datetime, trf_type, trf_description, trf_amount, trf_pay)
SELECT trf_subscriber, trf_datetime, trf_type, trf_description, trf_amount, trf_pay FROM @newTraffic