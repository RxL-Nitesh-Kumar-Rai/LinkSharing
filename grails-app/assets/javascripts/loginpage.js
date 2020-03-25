$(document).ready(function(){

    $("#cPass").blur(function(){
        if(($("#pass").val()!=$("#cPass").val()) && $("#pass").val()!="" ){


            alert("Password and confirm password do not match")
            $("#cPass").attr("title", "Password does not match");
            $("#btn-2").attr('disabled', true).focus();
            $("#btn-2").attr('title','Write correct password to register')
        }
        $("#cPass").keyup(function() {
            if((($("#pass").val()==$("#cPass").val()) && $("#pass").val()!="" )){
                $("#btn-2").attr('disabled', false)
                $("#btn-2").attr('title','Now you can register')
                $("#cPass").attr("title", "Password is matching");
            }
        });
    });
});
