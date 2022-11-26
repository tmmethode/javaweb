<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java_action.java_action" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java_action.JavaUsers"%>
<%@page import="java_action.LoginBean"%>
<%@page import="java_action.ChatHistory"%>
<%
     if(request.getParameter("action")!=null)
     {
        int from_userid=(Integer) session.getAttribute("user_id");
        int to_userid=Integer.parseInt(request.getParameter("to_userId"));
        java_action jction=new java_action();
        String UserName=jction.getUserName(to_userid);
        List<ChatHistory> chats=jction.getAllChatHistory(to_userid,from_userid);
        %>
        <div class="chat">
         <div class="chat-header clearfix">
            <div class="row">
                <div class="col-lg-6">
                    <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                        <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
                    </a>
                    <div class="chat-about">
                        <h6 class="m-b-0"><%= UserName %></h6>
                        <small>Last seen: 2 hours ago</small>
                    </div>
                </div>
            </div>
        </div>
        <div class="chat-history ref_chatHistory" data-touserid="<%= to_userid %>">
        <ul class="m-b-0">
        <%
        for(int i=0;i<chats.size();i++)
        {
         int toUserID=chats.get(i).getTo_userid();
         if(toUserID==to_userid)
         {
     %>
            
            <li class="clearfix">
                <div class="message-data">
                    <span class="message-data-time"><%=chats.get(i).getTimestamp() %></span>
                </div>
                <div class="message my-message"><%=chats.get(i).getMessage_sent() %></div>                                    
            </li>                               
         <% 
         }
          else
          {
         %>
            <li class="clearfix">
                <div class="message-data text-right">
                    <span class="message-data-time"><%=chats.get(i).getTimestamp() %></span>
                    <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
                </div>
                <div class="message other-message float-right"> <%=chats.get(i).getMessage_sent() %></div>
            </li>
     <% 
         }
       }
    %>
      </ul>
      </div>
      <div class="chat-message clearfix">
        <div class="input-group mb-0">
            <div class="input-group-prepend" id="sendChat" data-touserid="<%= to_userid %>">
                <span class="input-group-text"><i class="fa fa-send"></i></span>
            </div>
            <input type="text" class="form-control" id="inserChat" placeholder="Enter text here...">                                    
        </div>
      </div>
   </div>
            <%
     }
    %>
