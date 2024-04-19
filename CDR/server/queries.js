const mysql = require('mysql');
const pool = mysql.createPool({
     host: '127.0.0.1', 
     user: 'kappa', 
     password: 'kappa',
     database: 'cdr',
     port: 3306
});

function cercaEstudiant(uid, request, response){
  pool.getConnection(function(err, connection) {
    if (err){
      console.error('Error al obtener la conexión: ', err)
      return;
    }
    connection.query('SELECT name FROM students WHERE student_id= ?', [uid],function(error, results, fields) {
      connection.release();
      response.writeHead(200, {
        "Content-Type": "application/json",
      });
      response.write(
        JSON.stringify({
          name: results[0].name,
          student_id: results[0].student_id
        })
      );
      response.end();
    });
  }) 
}

function timetables(){
  
}

module.exports = { cercaEstudiant, timetables};

