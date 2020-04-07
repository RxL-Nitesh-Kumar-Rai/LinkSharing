var changepass=function (password) {
    $.ajax({
        url:"/dashBoard/changepass",
        type:"POST",
        data:{"password":password},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Password updated").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }
        },
    });

};

$(document).ready(function() {
    $('.profileTopicsTable1').DataTable();
    $('.profileTopicsTable2').DataTable();
    $('.profileSubscriptionsTable').DataTable();
    $('.profilePostsTable').DataTable();
    $(".topicEdit").click(function () {
        $(this).parent().siblings().eq(1).children(".topicName").attr("disabled",false);
        $(this).parent().siblings().eq(2).children(".topicSave").attr("disabled",false);
        $(this).parent().siblings().eq(2).children(".topicCancel").attr("disabled",false);
        $(this).parent().siblings().eq(8).children(".topicSeriousness").attr("disabled",false);
        $(this).parent().siblings().eq(9).children(".topicVisibility").attr("disabled",false);
    });
    $(".topicCancel").click(function () {
        $(this).parent().siblings().eq(1).children(".topicName").attr("disabled",true);
        $(this).prev().attr("disabled",true);
        $(this).attr("disabled",true);
        $(this).parent().siblings().eq(7).children(".topicSeriousness").attr("disabled",true);
        $(this).parent().siblings().eq(8).children(".topicVisibility").attr("disabled",true)
    });
    $(".topicSave").click(function () {
        var topicName=$(this).parent().siblings().eq(1).children(".topicName").val();
        var topicId=$(this).parent().siblings().eq(9).children(".topicId").text();
        var topicType=$(this).parent().siblings().eq(8).children(".topicVisibility").val();
        console.log(topicName+topicId+topicType)
        editTopic(topicName,topicId,topicType);
    });
    $(".topicDelete").click(function () {
        var topicId=$(this).parent().siblings().eq(2).children(".topicId").text();
        // alert(topicId)
        deleteTopic(topicId);
    });
    $(".topicSeriousness").change(function () {
        var topicId=$(this).parent().siblings().eq(2).children(".topicId").text();
        var topicSeriousness=$(this).val();
        changeTopicSeriousness(topicId,topicSeriousness);
    });

    $(".topicSeriousness2").change(function () {
        var topicId=$(this).prev().text();
        var topicSeriousness=$(this).val()
        changeTopicSeriousness(topicId,topicSeriousness);
    });
    $(".topicInvite").click(function () {
        $("#inputGroupSelect03").val($(this).prev().text()).attr('disabled',true);
        $("#navInvite").trigger("click");
    });
    $(".userProfileMarkAsRead").click(function () {
        var postId=$(this).next().text();
        markAsReadPost(postId);
    });
    $("#cPass").blur(function () {
        if($("#cPass").val()!=$("#pass").val() && $("#pass").val()!=""){
            $("#btn-2").attr('disabled',true).attr('title','Please write same password in both fields');
            $("#hidden-field-fail").text("Please write same password in both fields").attr('hidden',false).fadeToggle(3000).fadeOut(3000);
        }
    });
    $("#cPass").keyup(function () {
        if($("#cPass").val()==$("#pass").val()&& $("#pass").val()!=""){
            $("#btn-2").attr('disabled',false).attr('title','Both passwords are matching');
        }
    });
    $("#pass").keyup(function() {
        if((($("#pass").val()!=$("#cPass").val()) && $("#cPass").val()!="" )){
            $("#btn-2").attr('disabled', true);
            $("#btn-2").attr('title','Write correct password to register');
            $("#cPass").attr("title", "Write correct password to register");
        }
    });
    $("#pass").keyup(function() {
        if((($("#pass").val()==$("#cPass").val()) && $("#cPass").val()!="" )){
            $("#btn-2").attr('disabled', false);
            $("#btn-2").attr('title','Now you can register');
            $("#cPass").attr("title", "Password is matching");
        }
    });
    $("#btn-2").click(function () {
        var password=$("#pass").val();
        changepass(password);
    });
    $(".topic2-subscribe").click(function () {
        var topicId=$(this).prev().text();
        var seriousness='casual'
        subscribe(topicId,seriousness)
    });
    $(".topic2-Invite").click(function () {
        $("#inputGroupSelect03").val($(this).next().text()).attr('disabled',true);
        // console.log($(this).next().text())
        $("#navInvite").trigger("click");
    });
});