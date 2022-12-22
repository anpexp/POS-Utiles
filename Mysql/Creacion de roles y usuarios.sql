USE Utiles;

INSERT INTO 'Utiles'.'Empleado' ('empID', 'empHorario', 'empSalario', 'empPosicion', 'empNombre', 'empTelefono', 'empEmail')
			VALUES (1020819837, '7-5', 1250000, 'vendedor', 'Cristian Camilo Guerrero Lopez', '3115499252', 'cris4@gmail.com'),
            (1040131433, '7-5', 1250000, 'logistica', 'Juan Angel Jaimes Realpe', '3194519231', 'loAnJ99@gmail.com'),
            (1051256835, '7-5', 2000000, 'gerente', 'Tatiana Sofia Murillo Romero', '3149671752', '0an44@gmail.com'),
            (1090464967, '7-5', 3000000, 'dueño', 'Oscar Luis Poveda Avila', '3032715776', '0wn3r@gmail.com');

-- CREACIÓN ROLES

CREATE ROLE
	'vendedor'@'localhost',
	'logistica'@'localhost',
	'gerente'@'localhost',
	'dueño'@'localhost';
    
-- PERMISOS ROLES
    
GRANT ALL PRIVILEGES ON Utiles TO 'dueño'@'localhost';

GRANT SELECT ON vw_empleados TO  'gerente'@'localhost';
GRANT SELECT ON Proveedor TO  'gerente'@'localhost';
GRANT ALL ON FacturaDeCompra TO  'gerente'@'localhost';
GRANT ALL ON Cliente TO  'gerente'@'localhost';
GRANT ALL ON comCantidadHerramienta TO  'gerente'@'localhost';
GRANT ALL ON Producto TO  'gerente'@'localhost';
GRANT ALL ON UsoHerramienta TO  'gerente'@'localhost';
GRANT ALL ON ReqHerramienta TO  'gerente'@'localhost';
GRANT ALL ON Herramienta TO  'gerente'@'localhost';
GRANT ALL ON venCantidadServicio TO  'gerente'@'localhost';
GRANT ALL ON Servicio TO  'gerente'@'localhost';
GRANT ALL ON FacturaDeVenta TO  'gerente'@'localhost';

GRANT ALL ON vw_FacturaVenta TO  'gerente'@'localhost';
GRANT ALL ON vw_compra TO  'gerente'@'localhost';
GRANT ALL ON vw_Vendidos TO  'gerente'@'localhost';
GRANT ALL ON vw_datosFactura TO  'gerente'@'localhost';
GRANT ALL ON vw_datosCompra  TO  'gerente'@'localhost';
GRANT ALL ON accounts  TO  'gerente'@'localhost';
GRANT ALL ON Empleado  TO  'gerente'@'localhost';
GRANT ALL ON Proveedor  TO  'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE ingresosMes TO  'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE ganancia_producto TO  'gerente'@'localhost';



GRANT ALL ON vw_datosCompra TO  'logistica'@'localhost';
GRANT ALL ON vw_control TO 'logistica'@'localhost';

GRANT SELECT ON Herramienta TO  'logistica'@'localhost';
GRANT SELECT ON Producto TO  'logistica'@'localhost';
GRANT SELECT ON Servicio TO  'logistica'@'localhost';


GRANT ALL ON vw_Vendidos TO  'vendedor'@'localhost';
GRANT ALL ON vw_FacturaVenta TO  'vendedor'@'localhost';

GRANT SELECT ON Herramienta TO  'vendedor'@'localhost';
GRANT SELECT ON Producto TO  'vendedor'@'localhost';
GRANT SELECT ON Servicio TO  'vendedor'@'localhost';

-- CREACION DE USUARIOS

CREATE USER 'José Rodriguez'@'localhost' IDENTIFIED BY '5678';
CREATE USER 'Laura Benites'@'localhost' IDENTIFIED BY '1257';
CREATE USER 'Diego Perez'@'localhost' IDENTIFIED BY '9865';
CREATE USER 'Juan Hernandez'@'localhost' IDENTIFIED BY '5432';

CREATE USER 'Cristian Guerrero'@'localhost' IDENTIFIED BY '5643';
CREATE USER 'Juan Jaimes'@'localhost' IDENTIFIED BY '9847';
CREATE USER 'Tatiana Murillo'@'localhost' IDENTIFIED BY '2349';
CREATE USER 'Oscar Poveda'@'localhost' IDENTIFIED BY '1234';

-- OTORGAR ROLES A USUARIOS

GRANT 'logistica'@'localhost' TO
	'Juan Jaimes'@'localhost',
	'José Rodriguez'@'localhost';

GRANT 'vendedor'@'localhost' TO
	'Juan Hernandez'@'localhost',
	'Diego Perez'@'localhost',
	'Laura Benites'@'localhost',
    'Cristian Guerrero'@'localhost';
    
GRANT 'gerente'@'localhost' TO 'Tatiana Murillo'@'localhost';

GRANT 'dueño'@'localhost' TO 'Cristian Guerrero'@'localhost';

ALTER USER 'Tatiana Murillo'@'localhost' IDENTIFIED WITH mysql_native_password BY '2349';
SET DEFAULT ROLE 'gerente'@'localhost' TO 'Tatiana Murillo'@'localhost';
FLUSH privileges;

SELECT * FROM empleado;