USE pruebaTecnicaPaulinoZelaya
go

-- Crear el procedimiento almacenado
CREATE PROCEDURE prAsignarSaldosAGestores
AS
BEGIN
    -- Variables necesarias
    DECLARE @NumeroGestores INT = 10;
    DECLARE @ContadorGestores INT = 1;
    DECLARE @SaldoID INT;

    -- Tabla temporal para almacenar los saldos ordenados
    CREATE TABLE #SaldosOrdenados (
        SaldoID INT,
        Saldo INT
    );

    -- Insertar los saldos proporcionados en la tabla temporal ordenados en orden descendente
    INSERT INTO #SaldosOrdenados (SaldoID, Saldo)
    SELECT SaldoID, Saldo
    FROM Saldos
    ORDER BY Saldo DESC;

    -- Cursor para recorrer los saldos ordenados
    DECLARE saldo_cursor CURSOR FOR
    SELECT SaldoID
    FROM #SaldosOrdenados;

    -- Abrir el cursor
    OPEN saldo_cursor;

    -- Obtener el primer saldo del cursor
    FETCH NEXT FROM saldo_cursor INTO @SaldoID;

    -- Bucle para asignar los saldos a los gestores
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insertar la asignación en la tabla Asignaciones
        INSERT INTO Asignaciones (GestorID, SaldoID)
        VALUES (@ContadorGestores, @SaldoID);

        -- Incrementar el contador de gestores
        SET @ContadorGestores = @ContadorGestores + 1;

        -- Reiniciar el contador si excede el número de gestores
        IF @ContadorGestores > @NumeroGestores
        BEGIN
            SET @ContadorGestores = 1;
        END

        -- Obtener el siguiente saldo del cursor
        FETCH NEXT FROM saldo_cursor INTO @SaldoID;
    END

    -- Cerrar y eliminar el cursor
    CLOSE saldo_cursor;
    DEALLOCATE saldo_cursor;

    -- Limpiar la tabla temporal
    DROP TABLE #SaldosOrdenados;

    -- Devolver la tabla de asignaciones
    SELECT A.AsignacionID, G.Nombre AS Gestor, S.Saldo 
    FROM Asignaciones A
    JOIN Gestores G ON A.GestorID = G.GestorID
    JOIN Saldos S ON A.SaldoID = S.SaldoID;
END;
GO
