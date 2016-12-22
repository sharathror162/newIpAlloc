$(document).ready(function(){
    $("#btn2").click(function(){
        var email = $("#txt-fld").val();
        var email_pattern = new RegExp("/^[a-z0-9]+\@+gmail.com$/");
        if (email == ""){
            alert("Email Field Cannot Be Empty");
        }
        else if (email_pattern.test(email)) {
            alert("Please Enter A Valid Email Address");
        }
        else {
            $.ajax({
                type: "POST",
                url: "/account/resend_activation",
                dataType: "html",
                data: {email: email},
                success: function (data) {
                    alert("Account activation link has been resent to the email " + email +
                          ".Please check your inbox.");
                }
            })
        }
    });

    $(".alert-link").click(function(){
        $("#resend-link").removeClass("txt-fld-group");
    });

    $( "#login-form" ).submit(function(event) {
        var login = $("#login-txt").val();
        var pwd = $("#pwd-txt").val();
        if ((login == "") && (pwd == "")){
            $("#f1").removeClass("txt-field").addClass("error");
            $("#f2").removeClass("txt-field").addClass("error");
            return false;
        }
    });
});


