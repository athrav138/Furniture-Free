<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Panel/MasterPage1.master" AutoEventWireup="true" CodeFile="Change_Pass.aspx.cs" Inherits="Admin_Panel_Change_Pass" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="page-wrapper">
			<div class="main-page">
				<div class="forms">
					<h3 class="title1"></h3>
					<!---728x90--->
					
					<div class=" form-grids row form-grids-right">
						<div class="widget-shadow " data-example-id="basic-forms"> 
							<div class="form-title">
								<h4>Change Password</h4>
							</div>

							<div class="form-body">
                            
						<div class="">
							<div class=" panel-body-inputin">
								<div class="form-horizontal">

                                    <div class="form-group">

                                        <asp:Label ID="Label1" runat="server" class="col-md-3 control-label" Text="Enter Old Password"></asp:Label>

									<%--	<label class="col-md-2 control-label">Enter Old Password</label>--%>
										<div class="col-md-4">
											<div class="input-group input-icon right">	
                                            <span class="input-group-addon">
													<i class="fa fa-envelope-o"></i>
												</span>						
                                                <asp:TextBox ID="txtoldPass" runat="server" class="form-control1"  
                                                    style="height: 30px;" TextMode="Password"></asp:TextBox>

												<%--<input type="text" class="form-control1" placeholder="Email Address">--%>
											</div>
										</div>
									</div>
									
									<div class="form-group">

                                        <asp:Label ID="Label2" runat="server" class="col-md-3 control-label" Text="Enter New Password"></asp:Label>

									<%--	<label class="col-md-2 control-label">Enter Old Password</label>--%>
										<div class="col-md-4">
											<div class="input-group input-icon right">	
                                            <span class="input-group-addon">
													<i class="fa fa-envelope-o"></i>
												</span>						
                                                <asp:TextBox ID="txtnewPass" runat="server" class="form-control1"  
                                                    style="height: 30px;" TextMode="Password"></asp:TextBox>

												<%--<input type="text" class="form-control1" placeholder="Email Address">--%>
											</div>
										</div>
									</div>


									<div class="form-group">
										 <asp:Label ID="Label3" runat="server" class="col-md-3 control-label" Text="Re-Enter New Password"></asp:Label>
										<div class="col-md-4">
											<div class="input-group input-icon right">
                                            <span class="input-group-addon">
													<i class="fa fa-key"></i>
												</span>
												
												 <asp:TextBox ID="txtnewRPass" runat="server" class="form-control1"  
                                                    style="height: 30px;" TextMode="Password"></asp:TextBox>
											</div>
										</div>
										
									</div>

                            <asp:Button ID="btSearch" runat="server"  class="btn btn-default "  Text="Change" 
                                        ForeColor="White" BackColor="#6699FF" style="margin-left:10%;" 
                                        onclick="btSearch_Click" />

                             <asp:Button ID="btclose" runat="server"  class="btn btn-default "  Text="Close" 
                                        ForeColor="White" BackColor="#6699FF" onclick="btclose_Click" />

                              <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red"></asp:Label>


								</div>
                               
							</div>
						</div>
                            </div>
						</div>
					</div>
					<!---728x90--->
					
					
					<!---728x90--->
					
					
				</div>
			</div>
		</div>
</asp:Content>

<asp:Content ID="Content3" runat="server" 
    contentplaceholderid="ContentPlaceHolder2">
 <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
   
			 <ul class="nav" id="side-menu">

                <li ><a href="Home.aspx"><i class="fa fa-home nav_icon"></i>Home</a> </li>

                <li class="active"><a href="Change_Pass.aspx"><i class="fa fa-key" aria-hidden="true" style="padding-right:15px;">
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


