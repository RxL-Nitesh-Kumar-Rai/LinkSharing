
var ratePost=function(val){
    $.ajax({
        url:"/resources/ratePost",
        type:"POST",
        data:{"rating":val,"postId":$("#postId").text(),"postType":$("#postType").text()},
        success:function(data){
            if(data.success==true) {
                $("#hidden-field-success").attr("hidden", false).text("Rating successful").fadeToggle(3000).fadeOut(3000)
            }
            else{
                $("#hidden-field-fail").attr("hidden", false).text("Can't rate,you have already rated it").fadeToggle(3000).fadeOut(3000)
            }
        },
    });
};

var deletePost=function(val){
    $.ajax({
        url:"/resources/deletePost",
        type:"POST",
        data:{"postId":$("#postId").text(),"postType":$("#postType").text()},
        success:function(data){
            $("#hidden-field-success").attr("hidden",false).text("Post deleted").fadeToggle(3000).fadeOut(3000)

        },
    });
};

var editPost=function (postId,postDescription) {
    $.ajax({
        url:"/resources/editPost",
        type:"POST",
        data:{"postId":postId,"postDescription":postDescription},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("POst edited").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }
        },
    });

};

var deletePost=function (postId,postType) {
    $.ajax({
        url:"/resources/deletePost",
        type:"POST",
        data:{"postId":postId,"postType":postType},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Post deleted").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }
        },
    });

};




$(document).ready(function(){
    $("#rat1,#rat2,#rat3,#rat4,#rat5").click(function () {
        var val=$(this).attr("value")
        ratePost(val);
    });
    $("#delete").click(function () {
        deletePost();
    });
    $("#postEdit").click(function () {
        $(this).parent().siblings().eq(6).children(".postDescription").attr('hidden',true);
        $(this).parent().siblings().eq(6).children(".PostDescriptionTextArea").attr("hidden",false);
        $(this).next().next().attr("hidden",false);
        $(this).next().next().next().attr("hidden",false);
        $(this).next().attr("hidden",true);
    });
    $(".cancelEditedPost").click(function () {
        $(this).parent().siblings().eq(6).children(".postDescription").attr('hidden',false);
        $(this).parent().siblings().eq(6).children(".PostDescriptionTextArea").attr("hidden",true);
        $(this).prev().prev().attr("hidden",false)
        $(this).attr("hidden",true);
        $(this).prev().attr("hidden",true);
    });
    $(".saveEditedPost").click(function () {
        // var postId=$(this).prev().pre().prev().text();
        var postId=$(this).parent().children(".postId").text();
        var postDescription=$(this).parent().siblings().eq(6).children(".PostDescriptionTextArea").val();
        editPost(postId,postDescription);
    });
    $("#deletePost").click(function () {
        var postId=$(this).prev().prev().text();
        var postType=$(this).next().next().next().text();
        console.log(postId+postType);
        deletePost(postId,postType)
    });
    $(".viewPostTopicEdit").click(function () {
        $(this).parent().siblings().eq(0).children(".trendingTopicNameLink").attr("hidden",true);
        $(this).parent().siblings().eq(1).children(".trendingTopicSave").attr("hidden",false);
        $(this).parent().siblings().eq(1).children(".trendingTopicCancel").attr("hidden",false);
        $(this).parent().siblings().eq(0).children(".trendingTopicName").attr("hidden",false);
        $(this).parent().siblings().eq(8).children(".subscriptonSeriousness").attr("disabled",false);
        $(this).parent().siblings().eq(9).children(".topicVisibility").attr("disabled",false);
    });
    $(".trendingTopicCancel").click(function () {
        $(this).parent().siblings().eq(0).children(".trendingTopicNameLink").attr("hidden",false);
        $(this).prev().attr("hidden",true);
        $(this).attr("hidden",true);
        $(this).parent().siblings().eq(0).children(".trendingTopicName").attr("hidden",true);
        $(this).parent().siblings().eq(7).children(".subscriptonSeriousness").attr("disabled",true);
        $(this).parent().siblings().eq(8).children(".topicVisibility").attr("disabled",true);
    });
    $(".trendingTopicSave").click(function () {
        var topicId=$(this).next().next().text();
        var topicName=$(this).parent().siblings().eq(0).children(".trendingTopicName").val();
        var topicType=$(this).parent().siblings().eq(8).children(".topicVisibility").val()
        editTopic(topicName,topicId,topicType)
    });
    $(".subscriptonSeriousness").change(function () {
        var topicId=$(this).parent().siblings().eq(1).children(".topicId").text()
        var topicSeriousness=$(this).val()
        changeTopicSeriousness(topicId,topicSeriousness);
    });
    $(".viewPostTopicDelete").click(function () {
        var topicId=$(this).parent().siblings().eq(1).children(".topicId").text()
        deleteTopic(topicId);
    });
});

