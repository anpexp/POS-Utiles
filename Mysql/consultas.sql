USE utiles;

/* Scripts de consulta de la base de datos */
#Productos que contiene una factura buscado por id de la factura
SELECT prodNombre, vcpCantidad, prodPrecioVenta FROM (producto JOIN venCantidadProducto USING (prodID)) JOIN FacturaDeVenta USING (fvID) WHERE fvID=114;

-- Nombre empleado que atendió a cliente en cierta factura
SELECT empID, empNombre, cliNombre FROM (empleado JOIN FacturaDeVenta USING (empID)) JOIN Cliente USING (cliID) WHERE fvID = 112;

-- Facturas a nombre de un cliente específico
SELECT cliNombre, fvFecha,fvTotal FROM FacturaDeVenta JOIN Cliente USING (cliID) WHERE cliNombre = 'Martin Gomez';

-- Cantidad de facturas por empleado
SELECT empNombre, COUNT(fvID) FROM empleado JOIN FacturaDeVenta USING (empID) GROUP BY empNombre;

-- Cantidad de productos por proveedor
SELECT provNombre, COUNT(prodID)FROM producto JOIN Proveedor USING (provID) GROUP BY provID;

-- Lista completa de todas las personas
SELECT empID,empNombre FROM empleado UNION SELECT cliID,cliNombre FROM Cliente;

-- suma del total de ventas por fecha por empleado
SELECT fvFecha,empNombre, SUM(fvTotal) FROM empleado JOIN FacturaDeVenta USING (empID) GROUP BY fvFecha, empNombre;

-- Herramientas requeridas por cada servicio (null si no requiere herramientas)
SELECT serNombre, herNombre FROM (Servicio LEFT JOIN ReqHerramienta USING (serID)) LEFT JOIN Herramienta USING (herID);

-- Proveedor y compras realizadas
SELECT prodNombre,prodPrecioCompra,provNombre FROM producto LEFT JOIN Proveedor USING (provID);

-- Compras totales por cliente
SELECT cliNombre, SUM(fvTotal) FROM cliente JOIN FacturaDeVenta USING (cliID) GROUP BY cliNombre;