var createTopic=function () {
    $.ajax({
        url:"/dashBoard/createTopic",
        type:"POST",
        data:{"tName":$("#topicName").val(),"tType":$("#inputGroupSelect01").val()},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Topic created").fadeOut(10000)
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You have already created a topic with this name").fadeOut(10000)
            }

        },
    });
};


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
