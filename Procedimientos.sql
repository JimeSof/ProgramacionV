/**Procedimientos almacenados del proyecto**/


/*PROCEDIMIENTO DE LOGIN DEL SISTEMA

Parametros: 

-> email, digitado por el usuario
-> clave, digitado por el usuario
-> idPersona, este dato es output, debe ser capturado para saber si existe el dato en la tabla
-> esEmpleado, dato output, permite saber si el login lo realiza un empleado o un cliente
-> accesso, dato output, permite saber si los datos existen y que el usuario este activo en el sistema, para permitir el acceso
-> nombreCompleto, dato output para permitir extraer el nombre del usuario, especialmente el cliente
*/
USE [PV_ProyectoFinal]
GO
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
         ELSE  
            SET @acceso = 0;
END
GO


/*PROCEDIMIENTO DE LEER/CONSULTAR RESERVACIONES*/

USE [PV_ProyectoFinal]
GO
CREATE PROCEDURE [dbo].[spConsultarReservaciones]
    @IdPersona INT,
    @EsEmpleado BIT
AS
BEGIN
    SET NOCOUNT ON;
    IF @EsEmpleado = 1
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
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel H on hb.idHotel = h.idHotel
        Order by r.idReservacion DESC;
    END
    ELSE IF @EsEmpleado = 0
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
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel H on hb.idHotel = h.idHotel
        WHERE r.idPersona = @IdPersona
        Order by r.idReservacion DESC;
    END
END
GO
/*EXEC SPConsultarReservaciones @IdPersona = 7, @EsEmpleado = 0;*/


/*PROCEDIMIENTO DE Prueba*/

USE [PV_ProyectoFinal]
GO
CREATE PROCEDURE [dbo].[ReadCliente] 
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
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel H on hb.idHotel = h.idHotel
        WHERE r.idPersona = @IdPersona
        Order by r.idReservacion DESC;
END
GO


/*PROCEDIMIENTO DE Prueba2*/
USE [PV_ProyectoFinal]
GO
CREATE PROCEDURE [dbo].[spConsultarGestionReservasion]
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
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel H on hb.idHotel = h.idHotel
        Order by r.idReservacion DESC;
END
GO

Exec spConsultarGestionReservasion;



