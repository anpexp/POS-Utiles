use Utiles;
#DROP TABLE registroProductos;
create table registroProductos(
  prodID INT,
  prodNombre VARCHAR(45) NOT NULL,
  prodPrecioVenta INT NOT NULL,
  prodPrecioCompra INT NOT NULL,
  prodFecha datetime,
  provID INT NOT NULL,
  operacion varchar(20)
);
-- registro de productos comprados
#drop trigger ProductoAdicion;
delimiter |
CREATE TRIGGER ProductoAdicion after INSERT  ON  Producto FOR EACH ROW 
BEGIN 
	if new.prodID not in (select prodID from registroProductos) then
		INSERT INTO registroProductos (prodID,prodNombre,prodPrecioVenta,prodPrecioCompra,prodFecha,provID,operacion) 
		values (new.prodID,new.prodNombre,new.prodPrecioVenta,new.prodPrecioCompra,CURDATE(), new.provID,'Adicionado');
	end if ;
END; | 
delimiter ;
-- actulizacion del producto
delimiter |
CREATE TRIGGER ProductoActualizado after update  ON  Producto FOR EACH ROW 
BEGIN 
    INSERT INTO registroProductos (prodID,prodNombre,prodPrecioVenta,prodPrecioCompra,prodFecha,provID,operacion) 
    values (new.prodID,new.prodNombre,new.prodPrecioVenta,new.prodPrecioCompra,CURDATE(), new.provID,'Actulizado');
END; | 
delimiter ;
-- eliminar producto
delimiter |
CREATE TRIGGER ProductoEliminado after delete  ON  Producto FOR EACH ROW 
BEGIN 
    INSERT INTO registroProductos (prodID,prodNombre,prodPrecioVenta,prodPrecioCompra,prodFecha,provID,operacion) 
    values (old.prodID,old.prodNombre,old.prodPrecioVenta,old.prodPrecioCompra,CURDATE(), old.provID,'eliminado');
END; | 
delimiter ;

/*
call actualizarProducto(109,'plastico',4000,2000,10,2,102);
calL añadirProducto(109,'Cinta r5',5000,2000,10,2,102);
calL eliminarProducto(111);
*/

