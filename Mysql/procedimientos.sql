use Utiles;

-- mostrar facturas en funcion del provedoor
drop PROCEDURE if exists proveedor;
DELIMITER $$
	CREATE PROCEDURE proveedor(in id int, in total int )
	BEGIN
	SELECT * FROM FacturaDeCompra 
	NATURAL JOIN  Proveedor where provID = id; 
	END $$
DELIMITER ;

-- mostrar la ganancia por unidad de los productos
drop PROCEDURE if exists ganancia_producto;
DELIMITER $$
CREATE PROCEDURE ganancia_producto()
BEGIN
select prodNombre,prodPrecioVenta-prodPrecioCompra as Ganancia from Producto;
END;
$$
DELIMITER ;
-- call ganancia_producto();

-- consultar disponibilidad de una herramienta

drop procedure if exists consultar_her;
DELIMITER $$
CREATE PROCEDURE consultar_her(in her varchar(45))
BEGIN
select herNombre,herDisponibilidad from Herramienta where her = herNombre;
END ;
$$
DELIMITER ;
-- call consultar_her('tijeras');
-- select * FROM Herramienta;

-- lista de clientes con sus respectivas facturas, en un determinado mes
drop procedure if exists clienteMes;
DELIMITER $$
CREATE PROCEDURE clienteMes(in mes int)
BEGIN
	SELECT cliNombre,cliID,fvFecha FROM FacturaDeVenta 
	NATURAL JOIN  Cliente where fvFecha like concat('%_%',mes,'%_%') AND mes != 0; 
END ;
$$
DELIMITER ;
-- call clienteMes(1);
