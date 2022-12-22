const express = require('express');
const {engine} = require('express-handlebars');
const myconnection = require('express-myconnection');
const mysql = require('mysql');
const session = require('express-session');
const bodyParser = require('body-parser');
const { get } = require('express/lib/response');
const path = require('path');
var events = require('events');
const { response } = require('express');
var eventEmitter = new events.EventEmitter();


const app = express();
app.set('port', 4000);

app.set('views', __dirname + '/views');


app.use(bodyParser.urlencoded({
    extended:true
}))
app.use(bodyParser.json());
app.use(express.json());

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'Tatiana Murillo',
    password: '2349',
    port: 3306,
    database: 'Utiles'
});

app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));

app.listen(app.get('port'), () => {
    console.log('Listening on port ', app.get('port'));
});

app.use(express.static(path.join(__dirname)));


app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname+ '/index.html'));
//    connection.query('SELECT * FROM Empleado',

});



app.post('/auth', function(request, response) {
	// Capture the input fields
	let username = request.body.username;
	let password = request.body.password;
	// Ensure the input fields exists and are not empty
	if (username && password) {
		// Execute SQL query that'll select the account from the database based on the specified username and password
		connection.query('SELECT * FROM accounts WHERE username = ? AND password = ?', [username, password], function(error, results, fields) {
			// If there is an issue with the query, output the error
			if (error) throw error;
			// If the account exists
			if (results.length > 0) {
				// Authenticate the user
				request.session.loggedin = true;
				request.session.username = username;
				// Redirect to home page
				response.redirect('/ListaAcciones.html');
                //response.sendFile(path.join(__dirname+ '/ListaAcciones.html'));
			} else {
				response.send('Incorrect Username and/or Password!');
			}
			response.end();
		});
	} else {
		response.send('Please enter Username and Password!');
		response.end();
	}
});



app.get('/ListaAcciones', function(request, response) {
	// If the user is loggedin
	if (request.session.loggedin) {
		// Output username
		//response.send('Welcome back, ' + request.session.username + '!');
        response.sendFile(path.join(__dirname+ '/ListaAcciones.html'));
	} else {
		// Not logged in
		response.send('Please login to view this page!');
	}
    response.end();
});

//RELLENAR TABLA EMPLEADOS

var emp;
var hor;
var sal;
var pos;
var nom;
var tel;
var ema;


app.get('/Empleado', (req,res)=>{
    connection.query('SELECT empID, empNombre, empEmail, empTelefono  FROM Empleado', (error, filas)=>{
        if(error){
            throw error;
        }
        if(filas.length>0){
            res.send(filas);
        }
        res.end()});
});


app.post('/empID', function(req,res){
    let consulta=req.body.NAME;
        connection.query('SELECT * FROM Empleado WHERE empID = ? ', [consulta], function(err, results){
            if (err) throw err;
            if(results.length>0){
                emp = req.body.NAME;
                res.redirect('/EEmpleado.html');
            }
            else{
                res.send('no encontrado');
            }
            res.end();
        });
});

//POST para editar un empleado
app.get('/EEmpleado', function(req,res){
    connection.query('SELECT * FROM Empleado WHERE empID = ?', [emp], function(err, results){
        if (err) throw err;
        if(results.length>0){
            hor = results[0].empHorario;
            sal = results[0].empSalario;
            pos = results[0].empPosicion;
            nom = results[0].empNombre;
            tel = results[0].empTelefono;
            ema = results[0].empEmail;
            res.send(results);
        }
        else{
            res.send('no encontrado');
        }
    res.end();
    });
});

//post para insertar empleado
app.post('/empIDins', function(req,res){
    let ID=parseInt(req.body.NAME,10);
    let Horario=req.body.hor;
    let Salario=parseInt(req.body.sal,10);
    let Posicion=req.body.pos;
    let Nombre=req.body.nom;
    let Telefono=parseInt(req.body.tel,10);
    let Email=req.body.ema;
    connection.query('INSERT INTO Empleado (empID, empHorario, empSalario, empPosicion, empNombre, empTelefono, empEmail) VALUES (?, ?, ?, ?, ?, ?, ?);', [ID, Horario, Salario, Posicion, Nombre, Telefono, Email], function(err, results){
        if (err) throw err;
        res.redirect('/Empleado.html');
    });
});

//POST para eliminar empleado
app.post('/empIDdel', function(req, res){
    connection.query('DELETE FROM Empleado WHERE empID = ?', [emp], function(err, results){
        if (err) throw err;
        else{
            res.redirect('/Empleado.html');
        };
    });
});

//POST para editar empleado
app.post('/empIDedt', function(req, res){
    let ID=parseInt(req.body.NAME,10);
    let Horario=req.body.hor;
    let Salario=parseInt(req.body.sal,10);
    let Posicion=req.body.pos;
    let Nombre=req.body.nom;
    let Telefono=parseInt(req.body.tel,10);
    let Email=req.body.ema;
    connection.query('UPDATE Empleado SET empHorario=?, empSalario = ?, empPosicion = ?, empNombre = ?, empTelefono=?, empEmail=? WHERE empID=?', [Horario, Salario, Posicion, Nombre, Telefono, Email, ID], function(err, results){
        if (err) throw err;
    });
    res.redirect('/Empleado.html');
});




//vista de datos de compra
app.get('/vw_datosCompra', (req,res)=>{
    connection.query('SELECT *  FROM vw_datosCompra', (error, filas)=>{
        if(error){
            throw error;
        }
        if(filas.length>0){
            res.send(filas);
        }
        res.end()});
});


//entrar a la vista
var FdC;
app.post('/vw_dConsulta', function(req,res){
    let consulta=req.body.NAME;
        connection.query('SELECT * FROM vw_datosCompra WHERE vw_datosCompra.idFactura = ? ', [consulta], function(err, results){
            if (err) throw err;
            if(results.length>0){
                FdC = req.body.NAME;
                res.redirect('/vw_datosCompravis.html');
            }
            else{
                res.send('no encontrado');
            }
        });
});

//Datos especificos de una factura
var fec;
var ndf;
var prd;
var prc;
var prv;
var can;


app.get('/vw_compraDatos', function(req, res){
    connection.query('SELECT * FROM vw_datosCompra WHERE vw_datosCompra.idFactura = ? ', [FdC], function(err, results){0
        if (err) throw err;
        if(results.length>0){
            fec = results[0].fcFecha;
            ndf = results[0].idFactura;
            prd = results[0].prodNombre;
            prc = results[0].prodPrecioCompra;
            prv = results[0].provNombre;
            can = results[0].ccpCantidad;
            res.send(results);
        }
        else{
            res.send('no encontrado');
        }
    });
});

app.get('/vw_compraDatos', function(req, res){
    connection.query('SELECT * FROM vw_datosCompra WHERE vw_datosCompra.idFactura = ? ', [FdC], function(err, results){0
        if (err) throw err;
        if(results.length>0){
            fec = results[0].fcFecha;
            ndf = results[0].idFactura;
            prd = results[0].prodNombre;
            prc = results[0].prodPrecioCompra;
            prv = results[0].provNombre;
            can = results[0].ccpCantidad;
            res.send(results);
        }
        else{
            res.send('no encontrado');
        }
    });
});

app.post('/vwdatoscompraedt', function(req, res){
    let fec = req.body.fec;
    let ndf = parseInt(req.body.ndf,10);
    let prd = req.body.prd;
    let prc = parseInt(req.body.prc,10);
    let prv = req.body.prv;
    let can = parseInt(req.body.can,10);
    connection.query('UPDATE vw_datosCompra SET  prodNombre=?, prodPrecioCompra=? WHERE idFactura=?', [prd, prc, ndf], function(err, results){
        if (err) throw err;
    });
    connection.query('UPDATE vw_datosCompra SET  provNombre=?  WHERE idFactura=?', [prv, ndf], function(err, results){
        if (err) throw err;
    });
    connection.query('UPDATE vw_datosCompra SET  ccpCantidad=? WHERE idFactura=?', [can, ndf], function(err, results){
        if (err) throw err;
    });
    res.redirect('/vw_datosCompra.html');
});


//--------------------------------------ESTADISTICAS, PROCESOS ALMACENADOS Y ETC

var mes;

app.post('/ingresoMes', function(req,res){
    mes = parseInt(req.body.mes);
    connection.query('CALL ingresosMes(?);', [mes], function(err, results){
        if (err) throw err;
        if(results.length>0){
            console.log(mes + 'y');
            res.redirect('/Estadisticas2.html')
        }
        else{
            res.send('no encontrado');
        }
        res.end();
    });
});


app.get('/ingresosMes', function(req,res){
    connection.query('CALL ingresosMes(?);', [mes], function(err, results){
        console.log(mes);
        
        if(results.length>0){
            res.send(results);
            console.log(results);
            console.log(results[0][0].ventasDelMes);
        }
        else{
            res.send('no encontrado');
        }
    });
});

app.get('/gananciaproducto', (req,res)=>{
    connection.query('CALL ganancia_producto();', (error, filas)=>{
        if(error){
            throw error;
        }
        if(filas.length>0){
            console.log(filas);
            res.send(filas);
        }
        res.end()});
});



//------------------FUNCIONES DE PROVEEDOR--------------------

app.get('/Proveedor', (req,res)=>{
    connection.query('SELECT provID, provNombre, provEmail, provContacto  FROM Proveedor', (error, filas)=>{
        if(error){
            throw error;
        }
        if(filas.length>0){
            res.send(filas);
        }
        res.end()});
});

var provID;

app.post('/provID', function(req,res){
    let consulta=req.body.NAME;
        connection.query('SELECT * FROM Proveedor WHERE provID = ? ', [consulta], function(err, results){
            if (err) throw err;
            if(results.length>0){
                provID = req.body.NAME;
                res.redirect('/Proveedorvis.html');
            }
            else{
                res.send('no encontrado');
            }
            res.end();
        });
});



//Consulta individual de proveedor
app.get('/EProveedor', (req,res)=>{
    connection.query('SELECT provID, provNombre, provEmail, provContacto, provDireccion  FROM Proveedor WHERE provID = ? ', [provID],  (error, filas)=>{
        console.log(filas);
        if(error){
            throw error;
        }
        if(filas.length>0){
            res.send(filas);
        }
        res.end()});
});

//Edicion update de proveedor
app.post('/Proveedoredt', function(req, res){
    let provN = req.body.nom;
    let provEma = req.body.eml;
    let provCon = req.body.con;
    let provDir = req.body.dir;
    connection.query('UPDATE Proveedor SET provNombre = ?, provEmail=?, provContacto=?, provDireccion=? WHERE provID=?', [provN, provEma, provCon, provDir, provID], function(err, results){
        if (err) throw err;
    });
    res.redirect('/Proveedor.html');
});

//Insercion de proveedor
app.post('/Proveedorins', function(req, res){
    let newID = parseInt(req.body.prv, 10);
    let provN = req.body.nom;
    let provEma = req.body.eml;
    let provCon = parseInt(req.body.con, 10);
    let provDir = req.body.dir;
    connection.query('INSERT INTO Proveedor (provID, provNombre, provEmail, provContacto, provDireccion) VALUES (?,?,?,?,?);', [newID, provN, provEma, provCon, provDir], function(err, results){
        if (err) throw err;
    });
    res.redirect('/EProveedor.html');
});

//POST para eliminar proveedor
app.post('/Proveedordel', function(req, res){
    connection.query('DELETE FROM Proveedor WHERE provID = ?', [provID], function(err, results){
        if (err) throw err;
        else{
            res.redirect('/Proveedor.html');
        };
    });
});



//---------------VISTA DE FACTURAS DE VENTA--------------------
//vista de datos de VENTA
app.get('/FacturaDeVenta', (req,res)=>{
    connection.query('SELECT *  FROM vw_datosFactura', (error, filas)=>{
        if(error){
            throw error;
        }
        if(filas.length>0){
            res.send(filas);
        }
        res.end()});
});