var createTopic=function () {
    $.ajax({
        url:"/dashBoard/createTopic",
        type:"POST",
        data:{"tName":$("#topicName").val(),"tType":$("#inputGroupSelect01").val()},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Topic created").fadeOut(10000)
            // alert('lol')
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You have already created a topic with this name").fadeOut(10000)
            }

        },
    });
};

var createLink=function () {
    $.ajax({
        url:"/dashBoard/createLink",
        type:"POST",
        data:{"linkDescription":$("#linkdescription").val(),"topicLink":$("#inputGroupSelect04").val(),"linkUrl":$("#linkurl").val()},
        success:function(data){

                $("#hidden-field-success").attr("hidden",false).text("Link created").fadeOut(10000)
        },
    });
};


$(document).ready(function(){
    $("#form1-btn1").click(function(){
        createTopic();
        $("#form1-btn2").trigger("click")
    });

    $("#form3-btn1").click(function(){
        createLink();
        $("#form3-btn2").trigger("click")
    });



});
