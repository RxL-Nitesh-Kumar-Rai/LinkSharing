
$(document).ready(function(){

    $("#cPass").blur(function(){
        if(($("#pass").val()!=$("#cPass").val()) && $("#pass").val()!="" ){


            $("#hidden-field-fail").text("Please write same password in both fields").attr('hidden',false).fadeToggle(3000).fadeOut(3000);
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
        $("#pass").keyup(function() {
            if((($("#pass").val()!=$("#cPass").val()) && $("#cPass").val()!="" )){
                $("#btn-2").attr('disabled', true)
                $("#btn-2").attr('title','Write correct password to register')
                $("#cPass").attr("title", "Write correct password to register");
            }
        });
        $("#pass").keyup(function() {
            if((($("#pass").val()==$("#cPass").val()) && $("#cPass").val()!="" )){
                $("#btn-2").attr('disabled', false)
                $("#btn-2").attr('title','Now you can register')
                $("#cPass").attr("title", "Password is matching");
            }
        });
    });
});
