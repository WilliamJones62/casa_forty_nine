function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
function signUpInUser() {
    var urlField = document.getElementById("applicationUrl");
    var applicationUrl = urlField.innerHTML;
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
            var relativeURL = applicationUrl+'/users/sign_up';
        } else {
            var relativeURL = applicationUrl+'/users/sign_in';
        }
        const absoluteURL = new URL(relativeURL, window.location.href);
        window.location.href = absoluteURL.href;
      }
    req.open('GET', applicationUrl+'/api/user_by_email?email='+email);
    req.send();
    
}