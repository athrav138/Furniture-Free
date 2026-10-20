<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Panel/MasterPage1.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Admin_Panel_Home" %>

<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Panel/MasterPage1.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Panel_Default" %>--%>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="page-wrapper">
			<div class="main-page">
				
					<div class="clearfix"> </div>
				</div>
			
				<div class="elements  row" style="text-align:center;">
                   <%-- <asp:Label ID="Label1" runat="server" Text="OM GROUP"></asp:Label>--%>
                    <img src="../assets/img/logo.jpg" style="height:400px;"/>

                 
					<div class="clearfix"> </div>	
				</div>
				<!---728x90--->
				
			
		</div>


</asp:Content>

<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
   
		 <ul class="nav" id="side-menu">

                <li class="active"><a href="Home.aspx"><i class="fa fa-home nav_icon"></i>Home</a> </li>

                <li><a href="Change_Pass.aspx"><i class="fa fa-key" aria-hidden="true" style="padding-right:15px;">
                    </i>Change Password </a></li>
			

                 <li ><a href="Gallery_Master.aspx">
                    <i class="fa fa-picture-o" aria-hidden="true" style="padding-right:15px;"></i>Gallery Master
                    </a></li>
                <li><a href="News_Master.aspx">
                    <i class="fa fa-play" aria-hidden="true" style="padding-right:15px;"></i>News Master
                    </a></li>
				  <li><a href="Video_Master.aspx">
                    <i class="fa fa-play" aria-hidden="true" style="padding-right:15px;"></i>Video Master
                    </a></li>
                 
                   <li><a href="Product_Master.aspx">
                    <i class="fa fa-play" aria-hidden="true" style="padding-right:15px;"></i>Services Master
                    </a></li>

             
                     

				
            </ul>

    </nav>
</asp:Content>



