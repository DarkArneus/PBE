const queries = require('./queries');
var url = require('url');
const http = require('http')
const server = http.createServer((request, response) => {
    const reqURL = request.url;
    const reqMethod = request.method;
    
    // PARSE
    var q = url.parse(reqURL, true); // parseamos la url
    data = q.query // q.data retorna un objecte json
    table = q.pathname; //  cogemos lo que hay antes de ?
    //example.com/marks?subject=abc&name=123
    switch (reqMethod) {
      default: {
        defaultHandler(resquest, response)
      }
      case "GET": {
        if(table === "/students") {
            console.log(data.student_id);
            test = queries.cercaEstudiant(data.student_id, request, response);
            console.log(test)
        }
        if(table === "/marks"){

        }
        if(table === "/tasks"){

        }
        if(table === "/timetables"){

        }
        break;

      } 
    }
  });
 
  const port = 9000; // Puerto en el que el servidor escuchará

// Iniciar el servidor y hacerlo escuchar en el puerto especificado
server.listen(port, () => {
    console.log(`Servidor escuchando en el puerto ${port}`);
});