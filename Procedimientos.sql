USE [PV_ProyectoFinal]
GO

/**Procedimientos almacenados del proyecto**/


/*PROCEDIMIENTO DE LOGIN DEL SISTEMA

Parametros: 

-> email, digitado por el usuario
-> clave, digitado por el usuario
-> idPersona, este dato es output, debe ser capturado para manejarlo por el sistema en diferentes casos
-> esEmpleado, dato output, permite saber si el login lo realiza un empleado o un cliente en el sistema
-> accesso, dato output, permite saber si los datos existen y que el usuario este activo en el sistema, para permitir el acceso
-> nombreCompleto, dato output para permitir extraer el nombre del usuario, especialmente el cliente y manejarlo en el sistema

El procedimiento busca realizar el login en el proyecto mientras 
los paramtros sean iguales a los datos que estan dentro de la base
*/
CREATE PROCEDURE [dbo].[spLOGIN]
 @email VARCHAR(150),
 @clave VARCHAR(15),
 @idPersona INT OUTPUT,
 @esEmpleado BIT OUTPUT,
 @acceso INT OUTPUT, 
 @nombreCompleto VARCHAR(250)  OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

    SET @idPersona = NULL;
    SET @esEmpleado = NULL;
    SET @acceso = 0;
    SET @nombreCompleto = NULL;

    DECLARE @estado VARCHAR(1);

 SELECT top 1
        @idPersona = idPersona,
        @nombreCompleto = nombreCompleto,
        @esEmpleado = esEmpleado,
        @estado = estado
  FROM [PV_ProyectoFinal].dbo.Persona 
   WHERE email = @email AND
         clave = @clave;
         
         IF @idPersona is not null and @estado = 'A'
            SET @acceso = 1;
END
GO

/*PROCEDIMIENTO DE CONSULTAR PARA LA GESTION DE RESERVACIONES
    
Parametro de entrada:

-> IdPersona: este parametro se requiera para mostrar todas las reservaciones excepto las del mismo que realiza login.

El procedimiento muestra los datos de diferentes tablas y las une atraves de inner join, 
se establece el orden descendente y que cumpla con la consigna de no mostrar las reservaciones 
del empleado que realiza el login
*/

CREATE PROCEDURE [dbo].[spConsultarGestionReservasion]
@idPersona int
AS
BEGIN
    
     SELECT r.idReservacion,
               p.nombreCompleto as cliente,
               h.nombre as hotel, 
               r.fechaEntrada,
               r.fechaSalida,
               r.costoTotal,
               r.estado
        FROM [PV_ProyectoFinal].dbo.Reservacion r
        INNER JOIN [PV_ProyectoFinal].dbo.Persona p on r.idPersona = p.idPersona
        INNER JOIN [PV_ProyectoFinal].dbo.Habitacion hb on r.idHabitacion = hb.idHabitacion
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel h on hb.idHotel = h.idHotel
        Where  p.idPersona <> @idPersona 
        Order by r.idReservacion DESC;
END 
GO


/*PROCEDIMIENTO DE PARA CONSULTAR LAS RESERVACIONES DEL CLIENTE 

Procedimiento:

-> IdPersona: este parametro se requiera para mostrar todas las reservaciones del mismo usuario

El procedimiento muestra los datos de diferentes tablas y las une atraves de inner join, 
se establece el orden descendente y que cumpla con la consigna de no mostrar las reservaciones 
del Cliente que realiza el login
*/

CREATE PROCEDURE [dbo].[spConsultarClienteReservacion] 
  @IdPersona INT
AS
BEGIN
 SELECT r.idReservacion,
        h.nombre as hotel, 
        r.fechaEntrada,
        r.fechaSalida,
        r.costoTotal,
        r.estado
        FROM [PV_ProyectoFinal].dbo.Reservacion r
        INNER JOIN [PV_ProyectoFinal].dbo.Persona p on r.idPersona = p.idPersona
        INNER JOIN [PV_ProyectoFinal].dbo.Habitacion hb on r.idHabitacion = hb.idHabitacion
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel h on hb.idHotel = h.idHotel
        WHERE r.idPersona = @IdPersona
        Order by r.idReservacion DESC;
END
GO



/*PROCEDIMIENTO DE OBTENER RESERVACION POR ID DE RESERVACION

Parametros de entrada:

-> IdReservacion: Este dato permite la comparacion del dato de la URL, con el de la base
-> idPersona: Este dato se inicia como nullo para evitar errores si la persona no se especifica cuando es un empleado.
-> esEmpleado: Este dato identifica si un usuario es empleado o cliente

El procedimiento permite encontrar una reservacion en especifico para consultar esos datos,
emplea un where donde busca que coincidan las reservaciones, y busca que sea un empleado 
y si no que el id del cliente sea igual al de la sesión abierta.

*/

CREATE PROCEDURE [dbo].[spObtenerReservacionById] 
@idReservacion int,
 @idPersona int = null,
 @esEmpleado bit
AS
BEGIN
SELECT TOP 1
              r.idReservacion,
               r.idPersona,
               h.nombre as hotel, 
               hb.numeroHabitacion,
               p.nombreCompleto as cliente,
               r.fechaEntrada,
               r.fechaSalida,
               r.totalDiasReservacion,
               r.numeroNinhos,
               r.numeroAdultos, 
               r.costoTotal,
               r.estado
        FROM [PV_ProyectoFinal].dbo.Reservacion r
        INNER JOIN [PV_ProyectoFinal].dbo.Persona p on r.idPersona = p.idPersona
        INNER JOIN [PV_ProyectoFinal].dbo.Habitacion hb on r.idHabitacion = hb.idHabitacion
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel h on hb.idHotel = h.idHotel
        Where  r.idReservacion = @idReservacion
        AND (@esEmpleado = 1 OR r.idPersona = @idPersona)
        Order by r.idReservacion DESC;

END
GO

/*PROCEDIMIENTO PARA OBTENER LA BITACORA POR ID DE RESERVACION

Parametros:

-> idReservacion: este parametro se solicita para comparar de la URL y encontrar los datos de la bitacora

Este procedimiento almacenado permite mostrar los cambios dados a las reservaciones con la bitacora,
mostrando las acciones, fechas y el nombre de la persona que realiza los cambios sobre la reservacion

*/


CREATE PROCEDURE [dbo].[spObtenerBitacoraById]   
@idReservacion int
AS
BEGIN
 SELECT b.fechaDeLaAccion,
        b.accionRealizada,
        p.nombreCompleto
        FROM [PV_ProyectoFinal].dbo.Bitacora b
        INNER JOIN [PV_ProyectoFinal].dbo.Persona p on b.idPersona = p.idPersona
        WHERE b.idReservacion = @idReservacion 
        Order by b.idBitacora DESC;
END
GO

/*PROCEDIMIENTO DE CAPTURAR VALORES DE HOTEL*/
CREATE PROCEDURE [dbo].[spObtenerHoteles]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idHotel, nombre FROM [PV_ProyectoFinal].dbo.Hotel
    ORDER BY nombre asc;
END;
GO

/*PROCEDIMIENTO DE CAPTURAR A LOS CLIENTES*/


CREATE PROCEDURE [dbo].[spObtenerCientes]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idPersona, nombreCompleto FROM [PV_ProyectoFinal].dbo.Persona
    WHERE estado = 'A'
    ORDER BY nombreCompleto asc;
END;
GO

/*PROCEDIMIENTO OBTENER CANTIDADES Y HABITACION*/

CREATE PROCEDURE [dbo].[spObtenerCostosyHabitacion]
    @idHotel INT,
    @personasTotal INT
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH HabitacionesValidas AS
    (
        SELECT 
            hb.idHabitacion,
            hb.capacidadMaxima,
            (
                SELECT COUNT(*) 
                FROM Reservacion r 
                WHERE r.idHabitacion = hb.idHabitacion
            ) AS TotalReservas
        FROM Habitacion hb
        WHERE hb.idHotel = @idHotel
          AND hb.estado = 'A'
          AND hb.capacidadMaxima >= @personasTotal
    )
    SELECT TOP 1
        h.costoPorCadaAdulto,
        h.costoPorCadaNinho,
        hv.capacidadMaxima,
        hv.idHabitacion
    FROM HabitacionesValidas hv
    INNER JOIN Hotel h ON h.idHotel = @idHotel
    WHERE h.idHotel = @idHotel
    ORDER BY hv.TotalReservas ASC;  
END;
GO



/* PROCEDIMIENTO QUE CREA UNA RESERVACIÓN EN LA BASE

Parametros:

-> idPersona: capyura el id de la persona que realiza sesion en caso de ser cliente
-> nombreHotel: este datos captura el nombre del hotel elegido por el usuario
-> nombrePersona: este dato es para capturar el nombre de a quien se le asignaria la reservación
-> fechaEntrada: este dato captura la fecha seleccionada para la entrada al hotel
-> fechaSalida: este dato captura la fecha seleccionada para la salida al hotel
-> numeroNinhos: captura el numero de niños seleccionados por el usuario
-> numeroAdultos: captura el numero de adultos seleccionados por el usuario (no menos de 1)
-> costoPorAdulto: este dato se captura del sistema ya que pueden haber cambios a futuro con los precios
-> costoPorNinho: este dato se captura del sistema ya que pueden haber cambios a futuro con los precios.
-> costoTotal: el calculo de este dato se realiza en el sistema en caso de haber un futuro cambio y no corregir la BD

Este procedimiento crea una reservacion capturando los datos mencionados, para despues validar los ID 
el  nombreHotel se utiliza para buscar el id, al igual que el nombrePersona se usa para capturar el id, 
el ultimo id seria el de la habitacion que utiliza la comparacion entre el idhotel y el estado actual de la habitacion
despues valida las fechas para encontrar los dias (diferencias entre las fechas) por medio de el datediff, 
y por ultmo el insert junto a un update para actualizar el estado de la habitación



*/

CREATE PROCEDURE [dbo].[spCrearReservacion]
 @idPersona int,
 @idHabitacion int,
 @fechaEntrada DateTime,
 @fechaSalida DateTime,
 @numeroNinhos int,
 @numeroAdultos int,
 @costoPorCadaAdulto numeric(10,2),
 @costoPorCadaNinho numeric(10,2),
 @idEmpleado int
AS
BEGIN

    DECLARE @totalDias INT;
    SET @totalDias = DATEDIFF(DAY, @fechaEntrada, @fechaSalida);
    IF @totalDias <= 0
        SET @totalDias = 1; --minimo 1 día

    DECLARE @CostoTotal numeric(14,2);
    SET @CostoTotal =  @totalDias * ((@numeroAdultos * @costoPorCadaAdulto) + (@numeroNinhos * @costoPorCadaNinho));


  INSERT INTO [dbo].[Reservacion]
    (
        idPersona,
        idHabitacion,
        fechaEntrada,
        fechaSalida,
        numeroAdultos,
        numeroNinhos,
        totalDiasReservacion,
        costoPorCadaAdulto,
        costoPorCadaNinho,
        costoTotal,
        fechaCreacion,
        estado
    )
    VALUES
    (
        @idPersona,
        @idHabitacion,
        @fechaEntrada,
        @fechaSalida,
        @numeroAdultos,
        @numeroNinhos,
        @totalDias,
        @costoPorCadaAdulto,
        @costoPorCadaNinho,
        @costoTotal,
        GETDATE(),
        'A'
    );

    UPDATE Habitacion
    SET estado = 'I'
    WHERE idHabitacion = @idHabitacion;

   DECLARE @idReservacion INT = SCOPE_IDENTITY();
   
   INSERT INTO Bitacora(
        idReservacion,
        idPersona,
        accionRealizada,
        fechaDeLaAccion
    )
    Values( 
        @idReservacion,
        @idEmpleado,
        'CREADA',
         GETDATE());

END
GO

/* PROCEDIMIENTO QUE MUESTRA LOS CLIENTES EN EL DROPDOWNLIST
->idPersona: el dato permite comparar el usuario de la sesion y la bd, y que este no muestre su nombre en el filtro

Este procedimiento permite visualizar los datos del filtro por medio de la conexion
*/


CREATE PROCEDURE [dbo].[spFiltroClientes]
@idCliente int
AS
BEGIN
    Select p.idPersona,
           p.nombreCompleto
    from Persona p
    Where  p.idPersona <> @idCliente and
           p.estado = 'A'
        Order by nombreCompleto ASC;
END
GO

/*PROCEDIMIENTO PARA FILTRAR RESERVACION EN LA TABLA

-> idCliente: dato que permite filtrar por cliente seleccionado en el filtro
-> fechaEntrada: dato que permite encontrar datos segun la fecha seleccionada
-> fechaSalida: dato que permite encontrar datos segun la fecha seleccionada

Este procedimiento permite encontrar y mostrar los datos en la tabla segun lo seleccionado en el filtro, 
los cuales sus datos son los datos de entrada para funcionar segun el procedimiento*/


CREATE PROCEDURE [dbo].[spFiltroReservaciones]
@idCliente int,
@fechaEntrada date,
@fechaSalida date
AS
BEGIN
   SELECT r.idReservacion,
               p.nombreCompleto as cliente,
               h.nombre as hotel, 
               r.fechaEntrada,
               r.fechaSalida,
               r.costoTotal,
               r.estado
        FROM [PV_ProyectoFinal].dbo.Reservacion r
        INNER JOIN [PV_ProyectoFinal].dbo.Persona p on r.idPersona = p.idPersona
        INNER JOIN [PV_ProyectoFinal].dbo.Habitacion hb on r.idHabitacion = hb.idHabitacion
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel h on hb.idHotel = h.idHotel
        Where (@idCliente = 0 or p.idPersona = @idCliente) 
       and r.fechaEntrada <= @fechaSalida  
       and r.fechaSalida >= @fechaEntrada
        Order by r.idReservacion DESC;
END
GO

/*PROCEDIMIENTO PARA CANCELAR LAS RESERVACIONES

->idReservacion: Parametro de entrada para capturar la reservacion  a cancelar
->idEmpleado: Parametro de entrada para capturar el id del empleado y colocarlo en la bitacora
*/

CREATE PROCEDURE [dbo].[spCancelarReservacion]
    @idReservacion INT,
    @idEmpleado int
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @idHabitacion INT;

    -- Obtener habitación asociada
    SELECT @idHabitacion = idHabitacion
    FROM Reservacion
    WHERE idReservacion = @idReservacion;

    -- Cancelar la reservación
    UPDATE Reservacion
    SET estado = 'I'
    WHERE idReservacion = @idReservacion;

    -- Liberar la habitación
    UPDATE Habitacion
    SET estado = 'A'
    WHERE idHabitacion = @idHabitacion;

    -- Insertar en bitácora
    INSERT INTO Bitacora(idReservacion, idPersona, accionRealizada, fechaDeLaAccion)
    VALUES(@idReservacion, @idEmpleado, 'CANCELADA', GETDATE());

END
GO

/**/

/*PROCEDIMIENTO PARA EDITAR UNA RESERVACION

->idReservacion: Parametro de entrada para capturar la reservacion a editar
-> fechaEntrada: este dato captura la fecha seleccionada para la entrada al hotel
-> fechaSalida: este dato captura la fecha seleccionada para la salida al hotel
-> numeroNinhos: captura el numero de niños seleccionados por el usuario
-> numeroAdultos: captura el numero de adultos seleccionados por el usuario (no menos de 1)
-> idPersonaAccion: es el id de la persona que realiza la accion sobre la reservacion
*/

CREATE PROCEDURE [dbo].[spEditarReservacion]
 @idReservacion INT,
 @fechaEntrada DATETIME,
 @fechaSalida DATETIME,
 @numeroAdultos INT,
 @numeroNinhos INT,
 @idPersonaAccion INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @costoAdulto NUMERIC(10,2),
            @costoNinho NUMERIC(10,2),
            @idHabitacion INT,
            @totalDias INT,
            @costoTotal NUMERIC(14,2);

    -- Obtener costo y habitación actual de la reservación
    SELECT 
        @costoAdulto = costoPorCadaAdulto,
        @costoNinho  = costoPorCadaNinho,
        @idHabitacion = idHabitacion
    FROM Reservacion
    WHERE idReservacion = @idReservacion;

    -- Calcular total de días
    SET @totalDias = DATEDIFF(DAY, @fechaEntrada, @fechaSalida);
    IF @totalDias <= 0 SET @totalDias = 1;

    -- Calcular costo total
    SET @costoTotal =
        (@numeroAdultos * @costoAdulto * @totalDias)
        + (@numeroNinhos * @costoNinho * @totalDias);

    -- Actualizar la reservación
    UPDATE Reservacion
    SET fechaEntrada = @fechaEntrada,
        fechaSalida  = @fechaSalida,
        numeroAdultos = @numeroAdultos,
        numeroNinhos = @numeroNinhos,
        totalDiasReservacion = @totalDias,
        costoTotal = @costoTotal,
        fechaModificacion = GETDATE()
    WHERE idReservacion = @idReservacion;

    -- Guardar el cambio en la bitácora
    INSERT INTO Bitacora
    (idReservacion, idPersona, accionRealizada, fechaDeLaAccion)
    VALUES
    (@idReservacion, @idPersonaAccion, 'CORREGIDA', GETDATE());
END
GO

/*PROCEDIMIENTO PARA LISTAR HABITACIONES
*/

CREATE PROCEDURE [dbo].[spListarHabitaciones]
 AS
 BEGIN
	Select Ha.idHabitacion, Ho.Nombre, Ha.numeroHabitacion,Ha.capacidadMaxima,Ha.estado
	from Habitacion Ha
		inner join Hotel Ho on Ha.idHotel=Ho.idHotel
	order by Ho.nombre,Ha.estado,Ha.numeroHabitacion
 END
 GO
 
/*PROCEDIMIENTO PARA CREAR HABITACION

*/ 

CREATE PROCEDURE [dbo].[spCrearHabitacion]
	@idHotel INT,
    @numeroHabitacion VARCHAR(10),
    @capacidadMaxima INT,
    @descripcion VARCHAR(500),
    @estado VARCHAR(1)
AS
BEGIN
    SET NOCOUNT ON;

    -- Si no existe, insertar la nueva habitación
    INSERT INTO [dbo].[Habitacion] 
        ([idHotel], [numeroHabitacion], [capacidadMaxima], [descripcion], [estado]) 
    VALUES 
        (@idHotel, @numeroHabitacion, @capacidadMaxima, @descripcion, @estado);
END
GO


/*PROCEDIMIENTO QUE VALIDA LA EXISTENCIA DE UNA HABITACION*/
CREATE PROCEDURE [dbo].[spValidarHabitacion] 
    @idHotel INT,
    @numeroHabitacion VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(1) AS Existe
    FROM [dbo].[Habitacion]
    WHERE idHotel = @idHotel
      AND numeroHabitacion = @numeroHabitacion;
END
GO


/*PROCEDIMIENTO BUSCAR HABITACION*/

CREATE PROCEDURE [dbo].[spBuscarHabitacionById]
    @idHabitacion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Ha.idHabitacion     AS IdHabitacion,
        Ha.idHotel          AS IdHotel,
        Ho.nombre           AS Hotel,
        Ha.numeroHabitacion AS NumeroHabitacion,
        Ha.capacidadMaxima  AS CapacidadMaxima,
        Ha.descripcion      AS Descripcion
    FROM dbo.Habitacion Ha
    INNER JOIN dbo.Hotel Ho 
        ON Ha.idHotel = Ho.idHotel
    WHERE Ha.idHabitacion = @idHabitacion;
END
GO



/*PROCEDIMIENTO PARA EDITAR HABITACION

*/

CREATE PROCEDURE [dbo].[spEditarHabitacion]
    @idHabitacion INT,
    @idHotel INT,
    @numeroHabitacion VARCHAR(50),
    @capacidadMaxima INT,
    @descripcion VARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Habitacion
    SET 
        idHotel = @idHotel,
        numeroHabitacion = @numeroHabitacion,
        capacidadMaxima = @capacidadMaxima,
        descripcion = @descripcion
    WHERE idHabitacion = @idHabitacion;
END
GO

/*Inactivar una habitacion*/
CREATE PROCEDURE [dbo].[spInactivarHabitacion]
    @idHabitacion INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Habitacion
    SET estado = 'I'
    WHERE idHabitacion = @idHabitacion;
END;
GO

