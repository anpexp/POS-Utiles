use Utiles;

-- contar facturas en un rango de totales
drop function if exists factura_compra_rango;
delimiter $$
create function factura_compra_rango(min INT,max INT) returns int deterministic
  begin
	declare facturas int;
	SELECT count(*) into facturas from  FacturaDeCompra where fcTotal <= max and min <= fcTotal;
    return facturas;
  end $$
delimiter ;
-- select factura_compra_montoMAX(1000,10000);
-- select* from FacturaDeCompra;

-- contar el numero de facturas de compra realizadas en un mes en espefico
drop function if exists factura_compra_fecha;
delimiter $$
create function factura_compra_fecha(mes int) returns int deterministic
  begin
	declare facturas int;
	SELECT count(*) into facturas from  FacturaDeCompra where fcFecha like concat('%_%',mes,'%_%') AND mes != 0;
    return facturas;
  end $$
delimiter ;
-- select factura_compra_fecha(7);
-- select* from FacturaDeCompra;

-- cuantas compras a realizado un cliente en un mes

drop function if exists factura_venta_cliente;
delimiter $$ 
create function factura_venta_cliente(mes int,id int) returns int deterministic 
  begin
	declare cliente int DEFAULT 0;
	SELECT count(*) into cliente from FacturaDeVenta  where fvFecha like concat('%_%',mes,'%_%') AND cliID = id AND mes != 0;
    RETURN cliente;
  end $$
delimiter ;
-- select factura_venta_cliente(9,1001133455);
-- select* from FacturaDeVenta;

-- promedio de ventas al mes

drop function if exists avgMES;
delimiter $$ 
create function avgMES(mes int) returns int deterministic 
  begin
	declare promedio int DEFAULT 0;
	SELECT AVG(fvTotal) into promedio from FacturaDeVenta  where fvFecha like concat('%_%',mes,'%_%');
    RETURN promedio;
  end $$
delimiter ;
-- select avgMES(9);
-- select* from FacturaDeVenta;


