$(document).ready(function() {
    $(".signup-image-link,.signup-image-link").click(function(){
        $(".sign-in").toggle();
        $(".signup").toggle();
    });
    $(document).on("submit","#login-form",function(e){
        e.preventDefault();
        var email=$("#login_email").val();
        var password=$("#login_password").val();
        $.ajax({
            url:"jsp_action/jsp_action.jsp",
            method:"POST",
            dataType:"json",
            data:{action:"check_login",email:email,password:password},
            success:function(data)
            {
                if(data.success==="success")
                {
                  window.location.href="index.jsp";
                }
                else
                {
                    alert(data.message);
                }
            }
        });
    });
    $(document).on("submit","#register-form",function(e){
        e.preventDefault();
        var name=$("#name").val();
        var email=$("#email").val();
        var password=$("#pass").val();
        var re_password=$("#re_pass").val();
        if(password!==re_password)
        {
            alert("Password MisMatch");
        }
        else
        {
            $.ajax({
                url:"jsp_action/jsp_action.jsp",
                method:"POST",
                dataType:"json",
                data:{action:"signup",name:name,email:email,password:password},
                success:function(data)
                {
                    if(data.result>0)
                    {
                        alert("Sign Up successfully Now you can login");
                        window.location.href="login.jsp";
                    }
                    else
                    {
                        alert("Can't Signup Email Already Exists");
                    }
                }
            });
        }
    });
});