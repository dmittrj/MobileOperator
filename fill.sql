/* This query fills all tables in DB with some values */

USE MobileOperator_by_DmitryBalabanov;

INSERT INTO [Passport] VALUES ('2398', '129833', 'ГУ МВД России', '2000/09/11', '500-111', '1980/08/17');
INSERT INTO [Passport] VALUES ('8567', '897644', 'ГУ МВД России', '2002/03/30', '500-111', '1982/03/7');
INSERT INTO [Passport] VALUES ('7891', '456789', 'ГУ МВД России', '2001/05/13', '300-111', '1985/11/25');
INSERT INTO [Passport] VALUES ('6543', '123456', 'ГУ МВД России', '1999/02/28', '700-111', '1978/04/10');
INSERT INTO [Passport] VALUES ('2847', '237569', 'ГУ МВД России', '2004/11/10', '800-111', '1990/07/19');
INSERT INTO [Passport] VALUES ('9677', '974125', 'ГУ МВД России', '2005/06/18', '100-111', '1975/12/06');
INSERT INTO [Passport] VALUES ('3456', '789321', 'ГУ МВД России', '2003/09/17', '200-111', '1995/02/14');
INSERT INTO [Passport] VALUES ('5678', '654123', 'ГУ МВД России', '2007/01/23', '600-111', '1986/09/30');
INSERT INTO [Passport] VALUES ('1234', '789456', 'ГУ МВД России', '1998/10/25', '900-111', '1973/06/15');
INSERT INTO [Passport] VALUES ('9876', '654987', 'ГУ МВД России', '2009/08/19', '400-111', '1988/01/01');

INSERT INTO [Subscriber] VALUES ('Голый Андрей Иванович', '2398', '129833', '2023/01/06', 3);
INSERT INTO [Subscriber] VALUES ('Гаражный Денис Витальевич', '8567', '897644', '2022/12/29', 2);
INSERT INTO [Subscriber] VALUES ('Ровный Анатолий Петрович', '7891', '456789', '2022/11/30', 1);
INSERT INTO [Subscriber] VALUES ('Котов Иван Степанович', '6543', '123456', '2022/11/01', 2);
INSERT INTO [Subscriber] VALUES ('Пыхтеловский Геннадий Андреевич', '2847', '237569', '2023/02/14', 1);
INSERT INTO [Subscriber] VALUES ('Збзызина Елена Эдуардовна', '9677', '974125', '2023/01/20', 3);
INSERT INTO [Subscriber] VALUES ('Брысь Петр Евгеньвич', '3456', '789321', '2022/10/15', 2);
INSERT INTO [Subscriber] VALUES ('Женатая Виктория Дмитриевна', '5678', '654123', '2022/12/01', 1);
INSERT INTO [Subscriber] VALUES ('Безударный Владимир Николаевич', '1234', '789456', '2022/10/31', 3);
INSERT INTO [Subscriber] VALUES ('Калинкин-Малинкин Матвей Витальевич', '9876', '654987', '2023/03/14', 1);