function login(){
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    var error = document.getElementById("loginFailed");

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