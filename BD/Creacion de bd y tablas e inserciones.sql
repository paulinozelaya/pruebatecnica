-- Crear la base de datos
CREATE DATABASE pruebaTecnicaPaulinoZelaya;
GO

-- Usar la base de datos recién creada
USE pruebaTecnicaPaulinoZelaya;
GO

-- Crear la tabla para almacenar los saldos
CREATE TABLE Saldos (
    SaldoID INT IDENTITY(1,1) PRIMARY KEY,
    Saldo INT NOT NULL
);

-- Insertar los saldos proporcionados en la tabla Saldos
INSERT INTO Saldos (Saldo) VALUES 
(2277), (3953), (4726), (1414), (627), (1784), (1634), (3958), (2156), (1347), 
(2166), (820), (2325), (3613), (2389), (4130), (2007), (3027), (2591), (3940), 
(3888), (2975), (4470), (2291), (3393), (3588), (3286), (2293), (4353), (3315), 
(4900), (794), (4424), (4505), (2643), (2217), (4193), (2893), (4120), (3352), 
(2355), (3219), (3064), (4893), (272), (1299), (4725), (1900), (4927), (4011);
GO

-- Crear la tabla para los gestores
CREATE TABLE Gestores (
    GestorID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50)
);

-- Insertar gestores ficticios para la prueba
INSERT INTO Gestores (Nombre) VALUES 
('Gestor 1'), ('Gestor 2'), ('Gestor 3'), ('Gestor 4'), ('Gestor 5'), 
('Gestor 6'), ('Gestor 7'), ('Gestor 8'), ('Gestor 9'), ('Gestor 10');
GO

-- Crear la tabla para las asignaciones
CREATE TABLE Asignaciones (
    AsignacionID INT IDENTITY(1,1) PRIMARY KEY,
    GestorID INT NOT NULL,
    SaldoID INT NOT NULL,
    FOREIGN KEY (GestorID) REFERENCES Gestores(GestorID),
    FOREIGN KEY (SaldoID) REFERENCES Saldos(SaldoID)
);
GO

