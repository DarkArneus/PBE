const mysql = require('mysql');
var url = require('url');
const pool = mysql.createPool({
     host: '127.0.0.1', 
     user: 'kappa', 
     password: 'kappa',
     database: 'cdr',
     port: 3306
});

function writeResponse(sql, response) {
  pool.getConnection(function(err, connection) {
    if (err){
      console.error('Error al obtener la conexión: ', err)
      return;
    }

    connection.query(sql,function(error, results, fields) {
      connection.release();
      if (error){
        response.writeHead(404, { "Content-Type": "application/json" });
        response.write(JSON.stringify({ error: 'Error al ejecutar la consulta SQL:', err }));
        response.end()
        return;
      }

      response.writeHead(200, {
        "Content-Type": "application/json",
      });

      response.write(
        JSON.stringify(results));
      response.end();
    });
  }) 
}

function cercaEstudiant(request, response){
    sql = 'SELECT name FROM students WHERE student_id='+url.parse(request.url,true).query.student_id+';';
    writeResponse(sql, response);
}

function searchQuery(request, response) {
  const reqURL = request.url;
  // PARSE
  var q = url.parse(reqURL, true); // parseamos la url
  query = q.query;
  param_keys = Object.keys(q.query); // retorna un array amb els parametres
  param_values = Object.values(q.query); //retorna array amb els valors dels parametres
  const keywordsOb={'[gt]': ' >', '[lt]':' <', '[gte]':' >=', '[lte]':' <='};
  const reserved_key = ['limit'];
  reserved = {}
  var sql="";
  //example.com/marks?subject=abc&name=123
  console.log(query);
  // FOR PER CAMBIAR: param1[gt] per param1 > per fer la query SQL
  for (let clave in query) {
    query[clave]='= ' + "'" + query[clave] + "'";
    for (let keyword in keywordsOb) {
      if (clave.includes(keyword)) {
        old = clave
        clave = clave.replace(keyword, keywordsOb[keyword]);
        query[clave] = query[old].replace('= ','');
        delete query[old];
        console.log(clave);
      }
      console.log(query);
    }
  }
  
    for (const clave in query) {
      if (clave !== 'limit') { // Ignorar el límite temporalmente
        sql = sql + ` AND ${clave} ${query[clave]}`;
        console.log(sql);
      }
    }

    if ('limit' in query) {
      sql = sql + ` LIMIT ${query['limit'].replace(/['=]/g, '')}`;
    }

    return sql+';';
  //} 
}

module.exports = { cercaEstudiant, searchQuery, writeResponse};
