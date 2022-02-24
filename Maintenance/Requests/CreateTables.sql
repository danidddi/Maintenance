drop table if exists [Services]
drop table if exists Workers
drop table if exists Clients
drop table if exists Cars
drop table if exists [Owners]
drop table if exists Specialtys
drop table if exists Persons
drop table if exists Colors

--ТАБЛИЦА ЦВЕТОВ
CREATE TABLE [dbo].Colors
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Color] NVARCHAR(50) NOT NULL   --цвет
)

--ТАБЛИЦА ПЕРСОН
CREATE TABLE [dbo].Persons
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Surname] NVARCHAR(50) NOT NULL,    --фамилия
    [Name] NVARCHAR(50) NOT NULL,       --имя
    [Patronymic] NVARCHAR(50) NOT NULL  --отчество
)

--ТАБЛИЦА СПЕЦИАЛЬНОСТЕЙ
CREATE TABLE [dbo].Specialtys
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Specialty] NVARCHAR(50) NOT NULL   --специальность
)



--ТАБЛИЦА ВЛАДЕЛЬЦЕВ
CREATE TABLE [dbo].[Owners]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [idPerson] INT NOT NULL,                --айди персоны
    [BornDate] DATE NOT NULL,               --дата рождения
    [PhoneNumber] NVARCHAR(13) NOT NULL,    --номер телефона
    [Registration] NVARCHAR(50) NOT NULL,   --прописка
    CONSTRAINT [FK_Owners_ToPersons] FOREIGN KEY ([idPerson]) REFERENCES Persons(id)

)

--ТАБЛИЦА АВТО
CREATE TABLE [dbo].Cars
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Brand] NVARCHAR(50) NOT NULL,       --марка
    [Model] NVARCHAR(50) NOT NULL,       --модель
    [idColor] INT NOT NULL,              --айди цвета
    [ReleaseYear] INT NOT NULL,          --год выпуска
    [Plate] NVARCHAR(20) NOT NULL,       --регистрационный номер
    [Defect] NVARCHAR(1024) NOT NULL,    --дефект
    [idOwner] INT NOT NULL,              --айди владельца
    CONSTRAINT [FK_Cars_ToColors] FOREIGN KEY ([idColor]) REFERENCES [Colors](id),
    CONSTRAINT [FK_Cars_ToOwners] FOREIGN KEY ([idOwner]) REFERENCES [Owners](id),
    CONSTRAINT [CK_Cars_ReleaseYear] CHECK (ReleaseYear > 1885 )

)

--ТАБЛИЦА КЛИЕНТОВ
CREATE TABLE [dbo].Clients
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [idPerson] INT NOT NULL,                --айди персоны
    [BornDate] DATE NOT NULL,               --дата рождения
    [Registration] NVARCHAR(100) NOT NULL,  --прописка
    [PhoneNumber] NVARCHAR(13) NOT NULL,    --номер телефона
    [idAuto] INT NOT NULL,                  --айди авто
    CONSTRAINT [FK_Clients_ToCars] FOREIGN KEY ([idAuto]) REFERENCES Cars(id),
    CONSTRAINT [FK_Clients_ToPersons] FOREIGN KEY ([idPerson]) REFERENCES Persons(id)
)

--ТАБЛИЦА РАБОТНИКОВ
CREATE TABLE [dbo].Workers
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [idPerson] INT NOT NULL,                --айди персоны
    [BornDate] DATE NOT NULL,               --дата рождения
    [PhoneNumber] NVARCHAR(13) NOT NULL,    --номер телефона
    [Registration] NVARCHAR(50) NOT NULL,   --прописка
    [idSpecialty] INT NOT NULL,             --айди специальности
    [Rank] NVARCHAR(50) NOT NULL,           --разряд
    [Employment] Date NOT NULL,             --дата начала работы
    CONSTRAINT [FK_Workers_ToPersons] FOREIGN KEY ([idPerson]) REFERENCES Persons(id),
    CONSTRAINT [FK_Workers_ToSpecialtys] FOREIGN KEY ([idSpecialty]) REFERENCES Specialtys(id)
)


--ТАБЛИЦА ЗАЯВОК НА ТЕХОБСУЛЖИВАНИЕ
CREATE TABLE [dbo].[Services]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [idClient] INT NOT NULL,                --айди клиента
    [idWorker] INT NOT NULL,                --айди работника
    [State] BIT NOT NULL,                   --состояние зявки
    [Purchases] NVARCHAR(1024) NOT NULL,    --закупки деталей для ремонта авто
    [DateAcceptance] Date NOT NULL,         --дата приема авто
    [DateIssuance] Date NOT NULL,           --дата выдачи авто
    [Outlay] INT NOT NULL,                  --затраты на детали
    [Pay] INT NOT NULL,                     --плата клиента
    CONSTRAINT [FK_Service_ToClients] FOREIGN KEY ([idClient]) REFERENCES Clients(id),
    CONSTRAINT [FK_Service_ToWorkers] FOREIGN KEY ([idWorker]) REFERENCES Workers(id),
    CONSTRAINT [CK_Service_Outlay] CHECK (Outlay > 0 ),
    CONSTRAINT [CK_Service_Pay] CHECK (Pay > 0 )


)
