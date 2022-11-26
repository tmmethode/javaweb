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
      String action=request.getParameter("action");
      
      if(action.equals("check_login"))
      {     
        java_action jaction=new java_action();
        String email=request.getParameter("email");
        String password=request.getParameter("password");
        List<LoginBean> login=jaction.checkLogin(email,password); 
        String username=login.get(0).getUserName();
        JSONObject json_output=null;
        Map<String , String> map=new HashMap();
        if(login.get(0).isIsLogin())
        {
           map.put("success","success");
           session.setAttribute("login_email",email);
           session.setAttribute("user_name",username);
           int user_id=login.get(0).getUserId();
           session.setAttribute("user_id",user_id);
           json_output=new JSONObject(map);
        }
        else
        {
           map.put("message","Wrong Email or Password");
           json_output=new JSONObject(map);
        }
        out.println(json_output);
      }
      
      if(action.equals("signup"))
      {
         JSONObject json=null;
         Map<String,Integer> map=new HashMap();
         String name=request.getParameter("name");
         String email=request.getParameter("email");
         String password=request.getParameter("password");
         java_action jaction=new java_action();
         int output=jaction.insertNewUser(name,email,password);
         map.put("result",output);
         json=new JSONObject(map);
         out.println(json);
      }
      if(action.equals("fetchAllUser"))
      {
         int user_id=(Integer)session.getAttribute("user_id");
         java_action jaction=new java_action();
         List<JavaUsers> listUser=jaction.getAllUsers(user_id);
         %>
          <ul class="list-unstyled chat-list mt-2 mb-0">
         <%
         for(int i=0;i<listUser.size();i++)
         {
           %>
         
            <li class="clearfix get_chat" data-touserid="<%=  listUser.get(i).getUser_id() %>">
                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
                <div class="about">
                    <div class="name"><%= listUser.get(i).getName() %></div>
                    <div class="status"> <i class="fa fa-circle offline"></i> left 7 mins ago </div>                                            
                </div>
            </li>
                       
        <% } %>
         </ul>
     <% } 
}%>