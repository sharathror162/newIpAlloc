$(document).ready(function(){
    $("#btn2").click(function(){
        var email = $("#txt-fld").val();
        email_pattern = "^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$";
        if (email == email_pattern){
            alert("Email Field Cannot Be Empty");
        }
        else if (!(email.match(email_pattern))) {
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
});
