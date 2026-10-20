 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Novus Admin Panel Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
SmartPhone Compatible web template, free WebDesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"   > addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Bootstrap Core CSS -->

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />

<link href="css1/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- Custom CSS -->
<link href="css1/style.css" rel='stylesheet' type='text/css' />
<!-- font CSS -->
<!-- font-awesome icons -->
<link href="css1/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
 <!-- js-->
<script src="js1/jquery-1.11.1.min.js"></script>
<script src="js1/modernizr.custom.js"></script>
<!--webfonts-->
<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
<!--//webfonts--> 
<!--animate-->
<link href="css1/animate.css" rel="stylesheet" type="text/css" media="all">
<script src="js1/wow.min.js"></script>
	<script>
	    new WOW().init();
	</script>
<!--//end-animate-->
<!-- Metis Menu -->
<script src="js1/metisMenu.min.js"></script>
<script src="js1/custom.js"></script>
<link href="css1/custom.css" rel="stylesheet">
<!--//Metis Menu -->
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="page-wrapper">
                <div class="main-page login-page ">
                    <!---728x90--->
                  <h4 style="text-align: center; font-size: 40px; padding-bottom: 14px; color: #6164c1;">
                     Dr. Naim Shaikh Hospital, Miraj</h4>
                    <div class="widget-shadow">
                        <div class="login-top" style="background: #6164c1;">
                            <h4 style="font-weight: bold;">Welcome to AdminPanel !  </h4>
                        </div>
                        <div class="login-body">
                            <form>

                            <asp:TextBox ID="txtuname" runat="server" class="user" placeholder="username"></asp:TextBox>

                            <asp:TextBox ID="txtupass" runat="server" class="lock" placeholder="password" TextMode="Password"></asp:TextBox>

                            <asp:Button ID="btn_login" runat="server" Text="submit" value="Sign In"
                                OnClick="btn_login_Click" />
                            <%--<asp:LinkButton runat="server" Text="Forget Password" ID="btnLink" OnClick="btnlink_Click" />--%>

                            <asp:Label ID="lblmsg" runat="server" Text="" class="control-label" for="inputSuccess"></asp:Label>



                                <br />
                                
                              <%--  <a href="forgot password.aspx" >Fogot Password</a>--%>
                                
                        </form>
                            

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>


    <!-- Classie -->
    <script src="js1/classie.js"></script>
    <script>
        var menuLeft = document.getElementById('cbp-spmenu-s1'),
            showLeftPush = document.getElementById('showLeftPush'),
            body = document.body;

        showLeftPush.onclick = function () {
            classie.toggle(this, 'active');
            classie.toggle(body, 'cbp-spmenu-push-toright');
            classie.toggle(menuLeft, 'cbp-spmenu-open');
            disableOther('showLeftPush');
        };

        function disableOther(button) {
            if (button !== 'showLeftPush') {
                classie.toggle(showLeftPush, 'disabled');
            }
        }
    </script>
    <!--scrolling js-->
    <script src="js1/jquery.nicescroll.js"></script>
    <script src="js1/scripts.js"></script>
    <!--//scrolling js-->
    <!-- Bootstrap Core JavaScript -->
    <script src="js1/bootstrap.js"> </script>

</body>
</html>
