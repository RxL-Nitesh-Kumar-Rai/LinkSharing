$(document).ready(function () {
    $('.searchPostsTable').DataTable();
    $('.searchTopicsTable').DataTable();
    $(".searchUsersTable").DataTable();
    $(".trendingTopicInvite").click(function () {
        $("#inputGroupSelect03").val($(this).prev().text()).attr('disabled',true);
        $("#navInvite").trigger("click");
    });
    $(".searchSubscribe").click(function () {
        var topicId=$(this).next().text();
        var topicSeriousness="casual";
        subscribe(topicId,topicSeriousness);
    });
    $(".searchUnsubscribe").click(function () {
        var topicId=$(this).next().text();
        unsubscribe(topicId);
    });
    $(".searchMarkAsRead").click(function () {
        var postId=$(this).next().text();
        markAsReadPost(postId)
    });
});
