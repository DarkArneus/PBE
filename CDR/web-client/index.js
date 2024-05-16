function login(){
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    var error = document.getElementById("loginFailed");
    localStorage.setItem("username", username)

    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) { // Quan la solicitut s'ha completat 
        var responseData = JSON.parse(this.responseText);
        try{
          if(responseData.students[0].name){
            window.location.href = "menu.html"
            error.style.display = "none"
          }
        }catch(e){
          error.style.display = "block"
        }
      }
    };
    var url = `http://127.0.0.1:9000/students?name=${encodeURIComponent(username)}&student_id=${encodeURIComponent(password)}`;

    xhr.open("GET", url, true);
    xhr.send();
}

function search() {
  var query = document.getElementById("search").value;
  var username = localStorage.getItem('username');

  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function () {
      if (this.readyState == 4 && this.status == 200) { // Cuando la solicitud se ha completado 
          var responseData = JSON.parse(this.responseText);
          const titulo = Object.keys(responseData)[0];
          if (responseData[titulo].length === 0) {
              console.log("Query vacía");
              return;
          }

          const headers = Object.keys(responseData[titulo][0]);
          headers.pop();

          const grid = document.getElementById("grid");
          grid.innerHTML = "";

          // Crear encabezados de tabla
          const tr = document.createElement("tr");
          headers.forEach((encabezado) => {
              const th = document.createElement("th");
              th.innerText = encabezado;
              th.classList.add("table_headers");
              tr.appendChild(th);
          });
          grid.appendChild(tr);

          // Crear filas de tabla
          responseData[titulo].forEach((item) => {
              const tr = document.createElement("tr");
              headers.forEach((header) => {
                
                if (header === "date"){
                  item[header] = item[header].split("T")[0];
                }
                if(header === "day"){
                  dayss = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
                  item[header] = dayss[item[header]-1];
                }
                const td = document.createElement("td");
                td.innerText = item[header];
                tr.appendChild(td);
              });
              grid.appendChild(tr);
          });
      }
  };
  var url = `http://localhost:9000/${query}`
  xhr.open("GET", url, true);
  xhr.send();
}

function changeName(){
  var username = localStorage.getItem('username');
  document.getElementById("welcomeText").textContent += username;
}

function logout(){
  var xhr = new XMLHttpRequest();
  localStorage.clear()
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) { // Quan la solicitut s'ha completat 
      window.location.href = "index.html"
    }
  };
  var url = `http://localhost:9000/logout?`
  xhr.open("GET", url, true);
  xhr.send();
}

document.addEventListener("DOMContentLoaded", function() {
  changeName();
});