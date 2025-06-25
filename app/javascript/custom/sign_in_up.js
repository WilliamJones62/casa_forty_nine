function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
function signUpInUser() {
    var emailField = document.getElementById("email");
    var email = emailField.value;

    if (email == "") {
        alert("Please enter an email address.");
        return;
      }
    if (!isValidEmail(email)) {
        alert("Please enter a valid email address.");
        return;
      }
        
    const req = new XMLHttpRequest();
    req.onload = function() {
        var jsonResponse = JSON.parse(this.responseText);
        if('error' in jsonResponse){
            var relativeURL = '/users/sign_up';
        } else {
            var relativeURL = '/users/sign_in';
        }
        const absoluteURL = new URL(relativeURL, window.location.href);
        window.location.href = absoluteURL;
      }
  
    req.open('GET', '/api/user_by_email.json?email='+email);
    req.send();
    
}