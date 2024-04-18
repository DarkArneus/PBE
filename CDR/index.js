const mysql = require('mysql');
const pool = mysql.createPool({
     host: '127.0.0.1', 
     user: 'kappa', 
     password: 'kappa',
     database: 'cdr',
     port: 3306
});

pool.getConnection(function(err, connection) {
  if (err) {
    console.error('Error al obtener la conexión:', err);
    return;
  }
  
  connection.query('SELECT * FROM tasks', function(error, results, fields) {
    connection.release(); // Devuelve la conexión al grupo de conexiones
  
    if (error) {
      console.error('Error al ejecutar la consulta:', error);
      return;
    }
  
    console.log('Resultados de la consulta:', results);
  });
});
