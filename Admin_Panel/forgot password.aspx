<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgot password.aspx.cs" Inherits="f1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
 <style>
.zoom {
  transition: transform .2s; /* Animation */
 
}

.zoom:hover {
  transform: scale(1.2); 
}
</style>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
 <div class="form-gap"></div>
 <div  style="background-color: transparent; ">
<div class="container">
	<div class="row">
		<div class="col-md-5 col-md-offset-4">
            <div class="panel panel-default">
              <div class="panel-body">
                <div class="text-center">
                  <h3><i class="fa fa-lock fa-4x"></i></h3>
                  <h2 class="text-center">Forgot Password?</h2>
                  <p>You can reset your password here.</p>
                  <div class="panel-body">
    
                    <form id="register-form" role="form" autocomplete="off" class="form" method="post">
    
                      <div class="form-group">
                        <div class="input-group">
                          <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                           <asp:TextBox ID="txtEmail" placeholder="Email address" class="form-control" runat="server" Width ="350" />
                           
      
                          
                        </div>
                      </div>
                      
                      <div class="form-group">
                      <asp:Button ID="Button1" Text="Reset Password"  
                              class="btn btn-lg btn-primary btn-block" runat="server" OnClick="SendEmail" 
                              ValidationGroup="a" />
                              <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="red" ErrorMessage="Please Enter Valid Email Address" ControlToValidate="txtEmail" ValidationGroup="a"></asp:RequiredFieldValidator>
                        <%--<input name="recover-submit" class="btn btn-lg btn-primary btn-block" value="Reset Password" type="submit">--%>
                      </div>
                      <br />
                      <asp:Label ID="lblMessage" runat="server" />
                      <br />
                      <input type="hidden" class="hide" name="token" id="token" value="">
                      <a href="Login.aspx" class="txt2 bo1">

        <asp:Image ID="Image1" runat="server"  Height="50" Width="50" ImageUrl="~/assets/images/back-images.png" /> Back
						</a> 
                    </form>
    
                  </div>
                </div>
              </div>
            </div>
          </div>
	</div>
    </div>
</div>
    </form>
</body>
</html>
