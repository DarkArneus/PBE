function submitForm(){
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;

    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) { // Quan la solicitut s'ha completat 
        var responseData = JSON.parse(this.responseText);
        displayStudentData(responseData);
      }
    };
    var url = `http://localhost:9000/students?username=${encodeURIComponent(username)}&password=${encodeURIComponent(password)}`;

    xhr.open("GET", url, true);
    xhr.send();
}