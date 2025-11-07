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



/*PROCEDIMIENTO DE CONSULTAR PARA LA GESTION DE RESERVACIONES
    
Parametro de entrada:

-> IdPersona: este parametro se requiera para mostrar todas las reservaciones excepto las del mismo que realiza login.

El procedimiento muestra los datos de diferentes tablas y las une atraves de inner join, 
se establece el orden descendente y que cumpla con la consigna de no mostrar las reservaciones 
del empleado que realiza el login
*/
USE [PV_ProyectoFinal]
GO
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



/*PROCEDIMIENTO DE PARA CONSULTAR LAS RESERVACIONES DEL CLIENTE 

Procedimiento:

-> IdPersona: este parametro se requiera para mostrar todas las reservaciones del mismo usuario

El procedimiento muestra los datos de diferentes tablas y las une atraves de inner join, 
se establece el orden descendente y que cumpla con la consigna de no mostrar las reservaciones 
del Cliente que realiza el login
*/

USE [PV_ProyectoFinal]
GO
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
        INNER JOIN [PV_ProyectoFinal].dbo.Hotel H on hb.idHotel = h.idHotel
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
USE [PV_ProyectoFinal]
GO
CREATE PROCEDURE [dbo].[spObtenerReservacionById] 
@idReservacion int,
 @idPersona int = null,
 @esEmpleado bit
AS
BEGIN
SELECT TOP 1
              r.idReservacion,
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


/*PROCEDIMIENTO PARA OBTENER LA BITACORA POR ID DE RESERVACION

Parametros:

-> idReservacion: este parametro se solicita para comparar de la URL y encontrar los datos de la bitacora

Este procedimiento almacenado permite mostrar los cambios dados a las reservaciones con la bitacora,
mostrando las acciones, fechas y el nombre de la persona que realiza los cambios sobre la reservacion

*/

USE [PV_ProyectoFinal]
GO
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

/*PROCEDIMIENTO DE CAPTURAR A LOS CLIENTES*/

USE [PV_ProyectoFinal]
GO
CREATE PROCEDURE [dbo].[spObtenerCientes]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT idPersona, nombreCompleto FROM [PV_ProyectoFinal].dbo.Persona
    WHERE estado = 'A'
    ORDER BY nombreCompleto asc;
END;


/* PROCEDIMIENTO QUE CREA UNA RESERVACIÓN EN LA BASE

Parametros:

-> nombreHotel: este datos captura el nombre del hotel elegido por el usuario
-> nombrePersona: este dato es para capturar el nombre de a quien se le asignaria la reservación
-> fechaEntrada: este dato captura la fecha seleccionada para la entrada al hotel
-> fechaSalida: este dato captura la fecha seleccionada para la salida al hotel
-> numeroNinhos: captura el numero de niños seleccionadas por el usuario
-> numeroAdultos: captura el numero de adultos seleccionadas por el usuario (no menos de 1)
-> costoPorAdulto: este dato se captura del sistema ya que pueden haber cambios a futuro con los precios
-> costoPorNinho: este dato se captura del sistema ya que pueden haber cambios a futuro con los precios.
-> costoTotal: el calculo de este dato se realiza en el sistema en caso de haber un futuro cambio y no corregir la BD

Este procedimiento crea una reservacion capturando los datos mencionados, para despues validar los ID 
el  nombreHotel se utiliza para buscar el id, al igual que el nombrePersona se usa para capturar el id, 
el ultimo id seria el de la habitacion que utiliza la comparacion entre el idhotel y el estado actual de la habitacion
despues valida las fechas para encontrar los dias (diferencias entre las fechas) por medio de el datediff, 
y por ultmo el insert junto a un update para actualizar el estado de la habitación



*/
USE [PV_ProyectoFinal]
GO
CREATE PROCEDURE [dbo].[spCrearReservacion]
 @idPersona int,
 @idHotel int,
 @fechaEntrada DateTime,
 @fechaSalida DateTime,
 @numeroNinhos int,
 @numeroAdultos int,
 @costoPorCadaAdulto numeric(10,2),
 @costoPorCadaNinho numeric(10,2),
 @costoTotal numeric(14,2)
AS
BEGIN

    Declare @idHabitacion int;
    SELECT TOP 1 @idHabitacion = idHabitacion
        FROM Habitacion
        WHERE idHotel = @idHotel AND estado = 'A';
     
    
    DECLARE @totalDias INT;

    SET @totalDias = DATEDIFF(DAY, @fechaEntrada, @fechaSalida);
    IF @totalDias <= 0
        SET @totalDias = 1; --minimo 1 día


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

END
