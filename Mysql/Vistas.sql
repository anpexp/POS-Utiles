USE utiles;

/* VISTAS              */


#Total de vendidos
CREATE VIEW vw_Vendidos AS
SELECT prodNombre, vcpCantidad, prodPrecioVenta, vcpCantidad*prodPrecioVenta
FROM producto JOIN venCantidadProducto USING (prodID);

-- SELECT * FROM vw_Vendidos;



/*VISTA PARA LAS FACTURAS DE VENTA QUE INCLUYE SERVICIOS Y PRODUCTOS*/
-- DROP VIEW vw_FacturaVenta;

CREATE VIEW vw_FacturaVenta AS
SELECT prodNombre, vcpCantidad, prodPrecioVenta, vcpCantidad*prodPrecioVenta
FROM producto JOIN venCantidadProducto USING (prodID) WHERE fvID=112 UNION SELECT serNombre, vcsCantidad, serPrecio, vcsCantidad*serPrecio FROM servicio JOIN venCantidadServicio USING (serID)
WHERE fvID = 112;
-- SELECT * FROM vw_FacturaVenta;

-- AQUI SE INCLUYEN LOS DATOS POR APARTE QUE DEBE LLEVAR LA FACTURA
CREATE VIEW vw_datosFactura AS
SELECT cliNombre, empNombre, fvID, fvTotal, fvFecha
FROM FacturaDeVenta JOIN Cliente USING (cliID) JOIN empleado ON (empleado.empID=FacturaDeVenta.empID)
WHERE fvID = 114;
-- SELECT * FROM vw_datosFactura;

-- Factrura de compra para vendedor

-- DROP VIEW vw_compra;
CREATE VIEW vw_compra AS
SELECT `fcNo.de_factura`, fcFecha, ccpCantidad, prodNombre
FROM producto JOIN comCantidadProducto USING (prodID) JOIN FacturaDeCompra USING (`fcNo.de_factura`)
WHERE `fcNo.de_factura` = 1;
-- SELECT * FROM vw_compra;

/*VISTA PARA LOGISTICA */
#Tienen acceso a los mismos datos que vendedor en facturas de venta pero pueden modificar

#tienen acceso a mas datos de las facturas de compra
-- DROP VIEW vw_datosCompra;

CREATE VIEW vw_datosCompra AS
SELECT fcFecha, fcNo.de_factura, prodNombre, prodPrecioCompra, provNombre, ccpCantidad
FROM ((producto JOIN comCantidadProducto USING (prodID)JOIN Proveedor USING (provID)) JOIN FacturaDeCompra USING (`fcNo.de_factura`))
WHERE `fcNo.de_factura` = 7;
-- SELECT * FROM vw_datosCompra;

CREATE VIEW vw_control AS 
SELECT fcFecha, herID, herNombre, herPrecioCompra, provNombre, cchCantidad
FROM ((herramienta JOIN comCantidadHerramienta USING (herID)JOIN Proveedor USING (provID)) JOIN FacturaDeCompra USING (`fcNo.de_factura`))
WHERE `fcNo.de_factura` = 7;
-- SELECT * FROM vw_control;


#VISTA PARA GERENTE DE EMPLEADOS (requiere ocultar los salarios)
-- DROP VIEW vw_empleados;
CREATE VIEW vw_empleados AS
SELECT empID, empHorario, empPosicion, empNombre, empTelefono, empEmail
FROM empleado
GROUP BY empID, empNombre;
-- SELECT * FROM vw_empleados;
