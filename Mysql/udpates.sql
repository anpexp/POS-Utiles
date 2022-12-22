use Utiles;

-- cambiar producto minimo a 2
UPDATE `Utiles`.`Producto` SET prodMinimo = 2 WHERE  prodDisponibles <= 2;
SELECT * FROM `Utiles`.`Producto`;

-- productos con proveedor con id 103 menores a 1000, aumentarles 201
UPDATE `Utiles`.`Producto` SET prodPrecioVenta = (prodPrecioVenta+201) WHERE provID = 103 AND prodPrecioVenta < 1000;
SELECT * FROM `Utiles`.`Producto`;

-- producto que mayores a 8000 , actualizar su nombre a mayusculas.
UPDATE `Utiles`.`Producto` SET prodNombre=UPPER(prodNombre)  WHERE prodPrecioVenta > 8000;
SELECT * FROM `Utiles`.`Producto`;
UPDATE `Utiles`.`Producto` SET prodNombre=Lower(prodNombre)  WHERE prodPrecioVenta > 8000;

-- lista  de ganancia de venta de cada producto y dejar los que resaltar en MAY los que tengan una ganancia mayor a 500
-- DROP view vw_producto2;
CREATE VIEW vw_producto2 AS SELECT
	prodNombre, 
    ProdPrecioVenta,
    ProdPrecioCompra,
    (ProdPrecioVenta - ProdPrecioCompra) AS 'GANANCIA'
 	FROM `Utiles`.`Producto`;
UPDATE vw_producto2 SET prodNombre=UPPER(prodNombre) WHERE (ProdPrecioVenta - ProdPrecioCompra) > 500;
SELECT * FROM vw_producto2;

-- En Nombre de los clientes para cada  
CREATE VIEW vw_facturas AS SELECT
	 cliNombre
     FROM `Utiles`.`Cliente` JOIN `Utiles`.`FacturaDeVenta` ON (Cliente.cliID=FacturaDeVenta.cliID);
SELECT *FROM vw_facturas;

-- promedio en dinero de las facturas de compra por cada uno de los diferentes proveedores
SELECT provID, AVG(prodPrecioVenta) FROM Producto
    GROUP BY provID
    HAVING AVG(prodPrecioVenta);

-- actualizar nombre del empleado que atendio al cliente,todas ventas las realizo 'Laura Alejandra Benites Muños'
-- cambiar a table por view
CREATE table facturas2 AS SELECT
	cliNombre,empNombre
	FROM `Utiles`.`Cliente` JOIN `Utiles`.`Empleado` 
    where cliID in (SELECT cliID FROM `Utiles`.`FacturaDeVenta`) AND empID IN (SELECT empID FROM `Utiles`.`FacturaDeVenta`);
UPDATE  facturas2 SET empNombre  = 'Laura Alejandra Benites Muños' WHERE empNombre  = 'Diego Alejandro Perez Torres';  
SELECT *FROM facturas2;
    
-- mostrar las facturas despues de Enero 2022 y cambiar a null
UPDATE `Utiles`.`FacturaDeVenta` SET fvFecha = 'null' WHERE fvFecha > '01/30/2022';
SELECT * FROM `Utiles`.`FacturaDeVenta`;
    
--  aumentar 50 a los productos menores 1000
UPDATE `Utiles`.`Producto` SET prodPrecioVenta = prodPrecioVenta+50
	WHERE prodPrecioVenta < 1000; 
SELECT * FROM `Utiles`.`Producto`;

-- borrar vw_producto2 
DROP VIEW vw_producto2;
    
DELETE FROM Producto Where prodNombre = 'Carpeta';
select * From Producto;