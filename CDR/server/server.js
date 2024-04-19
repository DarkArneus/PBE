const queries = require('./queries');
var url = require('url');
const http = require('http')
const server = http.createServer((request, response) => {
    const reqURL = request.url;
    const reqMethod = request.method;
    var student_uid;
    
    // PARSE
    var q = url.parse(reqURL, true); // parseamos la url
    data = q.query;
    table = q.pathname; //  cogemos lo que hay antes de ?
    param_keys = Object.keys(q.query); // retorna un array amb els parametres
    param_values = Object.values(q.query); //retorna array amb els valors dels parametres
    const keywords = ['[gt]', '[lt]','[gte]', '[lte]'];
    const reserved_key = ['order', 'orderby', 'limit'];
    const keywords_value = [' >','< ', ' >=', ' <='];
    reserved_found =[];
    reserved_values=[];
    var sql;
    //example.com/marks?subject=abc&name=123

    switch (reqMethod) {
      default: {
        defaultHandler(resquest, response)
      }
      case "GET": {
        if(table === "/students") {
          student_uid = data.student_uid;
          console.log(data.student_id);
          test = queries.cercaEstudiant(data.student_id, request, response);
        }
        if(param_keys.length){ //mirem que no tinguem una peticio buida sense parametres
          sql = "SELECT * FROM ${table} WHERE student = ${student_uid}"
          for (let i = 0; i <reserved_key.length; i++) {
            if (param_keys.includes(reserved_key[i])) {
              reserved_found.push(param_keys.splice(i ,1));
              reserved_values.push(param_values.splice(i, 1));
            }
          }
          for(let i = 0; i < param_keys.length; i++) {
            for (let j = 0; j < keywords; j++) {
              if(param_keys[i].includes(keywords[j]))
                param_keys[i] = param_keys[i].replace(keywords[j], keywords_value[j]);
              else
                param_keys[i]=param_keys[i]+' =';
           }
          }
        }
        for(let i = 0; i < param_keys.length-1; i++) {
          sql = sql + ' AND ${param_keys[i]} ${param_values[i]}';
          console.log(sql);
        } 
     }
    }
});
 
  const port = 9000; // Puerto en el que el servidor escuchara
  const host = '0.0.0.0';

// Iniciar el servidor y hacerlo escuchar en el puerto especificado
server.listen(port, host, () => {
    console.log(`Servidor escuchando en el puerto ${port}`);
});