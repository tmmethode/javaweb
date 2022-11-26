package java_action;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class java_action {
    Connection con;
    public void createConnection()
    {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/chat_application", "root", "");
        } catch (ClassNotFoundException classNotFoundException) {
            classNotFoundException.printStackTrace();
        } catch (SQLException sQLException) {
            sQLException.printStackTrace();
        }
    }
    public List<LoginBean> checkLogin(String email,String password)
    {
        boolean isLogin=false;
        List<LoginBean> output=new ArrayList();
        try {
            LoginBean login=new LoginBean();
            createConnection();
            String sql = "SELECT * FROM users WHERE user_email=? AND user_password=?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet result = stmt.executeQuery();
            while (result.next()) {
                int user_id=result.getInt("user_id");
                String return_email = result.getString("user_email");
                String return_password = result.getString("user_password");
                String userName=result.getString("user_name");
                if (return_email.equals(email) && return_password.equals(password)) {
                    String query="INSERT INTO `login_details`(`user_id`) VALUES (?)";
                    PreparedStatement substmt=con.prepareStatement(query);
                    substmt.setInt(1, user_id);
                    substmt.executeUpdate();
                    login.setUserId(user_id);
                    isLogin=true;
                    login.setIsLogin(isLogin);
                    login.setUserName(userName);
                    output.add(login);
                    break;
                }
            }
        } catch (SQLException sQLException) {
            sQLException.printStackTrace();
        }
        return output;
    }
    public int insertNewUser(String name,String email,String pass)
    {
        int out=0;
        try {
            createConnection();
            String query="SELECT `user_id`, `user_name`, `user_image`, `user_email`, `user_password` FROM `users` WHERE 1";
            PreparedStatement statement=con.prepareStatement(query);
            ResultSet result=statement.executeQuery();
            while(result.next())
            {
                String check_email=result.getString("user_email");
                if(check_email == null ? email != null : !check_email.equals(email))
                {
                    String sql="INSERT INTO `users`(`user_name`,`user_email`, `user_password`) VALUES (?,?,?)";
                    PreparedStatement stmt=con.prepareStatement(sql);
                    stmt.setString(1, name);
                    stmt.setString(2, email);
                    stmt.setString(3, pass);
                    out=stmt.executeUpdate();
                    break;
                }
                else{
                    out=-5;
                    break;
                }
            }            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return out;
    }
    public List<JavaUsers> getAllUsers(int login_id)
    {
        List<JavaUsers> output=new ArrayList();
        try {
            createConnection();
            String query="SELECT `user_id`, `user_name`, `user_image`, `user_email`, `user_password` FROM `users` WHERE user_id <> ?";
            PreparedStatement statement=con.prepareStatement(query);
            statement.setInt(1, login_id);
            ResultSet result=statement.executeQuery();
            while(result.next())
            {
                int user_id=result.getInt("user_id");
                String email = result.getString("user_email");
                String name = result.getString("user_name");
                JavaUsers user=new JavaUsers();
                user.setEmail(email);
                user.setName(name);
                user.setUser_id(user_id);
                output.add(user);
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return output;
    }
    public void insertUserChat(int from_userId,String chat_message,int to_userId)
    {
        try {
            createConnection();
            String sql = "INSERT INTO `chat_message`(`message_sent`, `to_user_id`, `from_user_id`) VALUES (?,?,?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, chat_message);
            stmt.setInt(2, to_userId);
            stmt.setInt(3, from_userId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<ChatHistory> getAllChatHistory(int to_userid,int from_userid)
    {
        List<ChatHistory> output=new ArrayList();
        try {
            createConnection();
            String sql = "SELECT `chat_id`, `message_sent`, `to_user_id`, `from_user_id`, `status`, `timestamp` FROM `chat_message` WHERE (to_user_id=? AND from_user_id=?) || (to_user_id=? AND from_user_id =?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, to_userid);
            stmt.setInt(2, from_userid); 
            stmt.setInt(3, from_userid);
            stmt.setInt(4, to_userid);           
            ResultSet result=stmt.executeQuery();
            while (result.next())
            {
               int chatId=result.getInt("chat_id");
               String message_sent=result.getString("message_sent");
               String timestamp=result.getString("timestamp");
               int status=result.getInt("status");
               int toUserId=result.getInt("to_user_id");
               int fromUserId=result.getInt("from_user_id");
               
               ChatHistory chating=new ChatHistory();
               chating.setTo_userid(toUserId);
               chating.setFrom_userid(fromUserId);
               chating.setChatId(chatId); 
               chating.setMessage_sent(message_sent);
               chating.setStatus(status);
               chating.setTimestamp(timestamp);
               output.add(chating);
            }
        } catch (SQLException sQLException) {
            sQLException.printStackTrace();
        }
        return output;
    }
    public String getUserName(int to_userId)
    {
        String output="";
        try
        {
            createConnection();
            String sql = "SELECT `user_name` FROM `users` WHERE user_id=?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, to_userId);
            ResultSet result = stmt.executeQuery();
            while (result.next()) {
                output = result.getString("user_name");
            }
        }
        catch (SQLException sQLException)
        {
            sQLException.printStackTrace();
        }
        return output;
    }
}
