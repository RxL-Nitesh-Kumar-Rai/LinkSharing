var createTopic=function () {
    $.ajax({
        url:"/dashBoard/createTopic",
        type:"POST",
        data:{"tName":$("#topicName").val(),"tType":$("#inputGroupSelect01").val()},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Topic created").fadeToggle(3000).fadeOut(3000)
            // alert('lol')
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You have already created a topic with this name").fadeToggle(3000).fadeOut(3000)
            }

        },
    });
};

var sendInvitation=function (emailInvite,emailTopic) {
    $.ajax({
        url:"/resources/sendInvitation",
        // url:"/inviteLink/sendInvite",
        type:"POST",
        data:{"emailInvite":emailInvite,"emailTopic":emailTopic},
        success:function(data){
                $("#hidden-field-success").attr("hidden",false).text("Invitation sent").fadeToggle(3000).fadeOut(3000)
        },
    });
};

var createLink=function () {
    $.ajax({
        url:"/dashBoard/createLink",
        type:"POST",
        data:{"linkDescription":$("#linkdescription").val(),"topicLink":$("#inputGroupSelect04").val(),"linkUrl":$("#linkurl").val()},
        success:function(data){
            $("#hidden-field-success").attr("hidden",false).text("Link created").fadeToggle(3000).fadeOut(3000)
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
    $("#inviteButton").click(function () {
        $("#inviteCancel").trigger("click")
        var emailInvite=$("#emailInvite").val();
        var emailTopic=$("#inputGroupSelect03").val();
        sendInvitation(emailInvite,emailTopic)
    });


});
