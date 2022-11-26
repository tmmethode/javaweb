<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<meta http-equiv="refresh" content="10">-->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
        <link rel="stylesheet" href="css/styles.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.js"></script>
    </head>
    <body>
        <%
            if(session.getAttribute("login_email")==null)
            {
              response.sendRedirect("login.jsp");
            }
        %>
        <div class="mt-0">
        <div class="row clearfix">
            <div class="col-lg-12">
                <div class="card chat-app">
                    <div id="plist" class="people-list mt-0">
                        <div class="hidden-sm ml-0 mb-2 mt-0">
                            <a href="javascript:void(0);" class="btn btn-outline-secondary" style="border:none"><i class="fa fa-user" aria-hidden="true"></i>&nbsp;&nbsp;<%= session.getAttribute("user_name") %></a>
<!--                            <a href="javascript:void(0);" class="btn btn-outline-primary"><i class="fa fa-image"></i></a>
                            <a href="javascript:void(0);" class="btn btn-outline-info"><i class="fa fa-cogs"></i></a>-->
                            <a href="javascript:void(0);" class="btn btn-outline-warning" title="Logout"><i class="fa fa-sign-out"></i></a>
                        </div>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-search"></i></span>
                            </div>
                            <input type="text" class="form-control" placeholder="Search...">
                        </div>
                        <div id="fetchAllUsers">
                            
                        </div>
                    </div>
                    <div id="getChatHistory">                               
                    </div>
                </div>
            </div>
        </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                fetchAllUser();
                 $("#sendChat").css("cursor","pointer");
                function fetchAllUser()
                {
                    $.ajax({
                       url:"jsp_action/jsp_action.jsp",
                       method:"POST",
                       data:{action:"fetchAllUser"},
                       success:function(data)
                       {
                          $("#fetchAllUsers").html(data);
                       }
                    });
                }
                setInterval(function(){
                      chatHistoryRefresh();     
                },5000);
                function chatHistoryRefresh()
                {
                    $(".ref_chatHistory").each(function() {
                        var toUserId=$(this).data("touserid");
                        fetchChatHistory(toUserId);
                    });
                }
                $(document).on("click",".get_chat",function()
                {
                    var toUserId=$(this).data("touserid");
                    fetchChatHistory(toUserId);     
                });
                
                function fetchChatHistory(to_userId)
                {
                    $.ajax({
                        url:"jsp_action/actionFetchChatHistory.jsp",
                        method:"POST",
                        data:{action:"fetchChatHistory",to_userId:to_userId},
                        success:function(data)
                        {
                            $("#getChatHistory").html(data);
                        }
                    });
                }
                $(document).on("click","#sendChat",function(){
                   var user_input=$("#inserChat").val();
                   var to_userId=$(this).data("touserid");
                   if(user_input!=="")
                   {
                       $.ajax({
                          url:"jsp_action/action_insertChat.jsp",
                          method:"POST",
                          dataType:"text",
                          data:{action:"insertChat",userInput:user_input,to_userId:to_userId},
                          success:function(data)
                          {
                            fetchChatHistory(to_userId);
                          }
                       });
                   }
                });
            });
        </script>
    </body>
</html>
