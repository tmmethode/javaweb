<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java_action.java_action" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java_action.JavaUsers"%>
<%@page import="java_action.LoginBean"%>
<%
    if(request.getParameter("action")!=null)
    {
       String input_message=request.getParameter("userInput");
       int to_userId=Integer.parseInt(request.getParameter("to_userId"));
       int from_userId=(Integer) session.getAttribute("user_id");
       java_action jaction=new java_action();
       jaction.insertUserChat(from_userId,input_message,to_userId);
    }

%>