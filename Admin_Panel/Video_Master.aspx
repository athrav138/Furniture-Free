
<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Panel/MasterPage1.master" AutoEventWireup="true" CodeFile="Video_Master.aspx.cs" Inherits="Admin_Panel_Video_Master" %>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<style>
.textbox { 
    background: white; 
    border: 1px solid #DDD; 
    border-radius: 5px; 
    box-shadow: 0 0 5px #DDD inset; 
    color: #666; 
    outline: none; 
    height:25px; 
    width: 275px; 
   } 
</style>
<div id="page-wrapper">

			<div class="main-page">
				<div class="forms">
					
					<!---728x90--->
					
					<div class=" form-grids row form-grids-right">
						<div class="widget-shadow " data-example-id="basic-forms"> 
							<div class="form-title">
								<h4>Video</h4>
							</div>
							<div class="form-body">

                            <div class="form-horizontal">
				
                                 <div class="form-group">
								

                          <asp:Label ID="Label1" runat="server"  class="col-sm-2 control-label" Text="Video Name"></asp:Label>
                                  <%--<label for="inputEmail3" class="col-sm-2 control-label">Email</label>--%> 
                                  <div class="col-sm-3"> 
                
                                      <asp:TextBox ID="txttitle" runat="server"  class="form-control" style="height: 30px;" ></asp:TextBox>
                                  
                        
                                   </div>
                                    </div>


                                 <div class="form-group">

                          <asp:Label ID="Label2" runat="server"  class="col-sm-2 control-label" Text="Video Path"></asp:Label>
                                  <%--<label for="inputEmail3" class="col-sm-2 control-label">Email</label>--%> 
                                  <div class="col-sm-3"> 

                                <asp:TextBox ID="txtsrc" runat="server"    class="form-control" style="height: 30px;"></asp:TextBox>
                        
                                   </div>
                                    </div>

                                  
                                       
            <asp:Label ID="lblmsg" runat="server"></asp:Label> 
                                
                                            
                                            
                    <div class="col-sm-offset-2">

                    <asp:Button ID="btnadd" runat="server"  class="btn mystyle" Text="Add" 
                            onclick="btnadd_Click" />
                                            <%-- <button type="submit" class="btn btn-default">Submit</button> --%>
                                          <%--   <a href="#"><span class="label label-success">Success</span></a>--%>
                         <%--   <asp:Button ID="Button1" runat="server"   class="label label-success " Text="Add" > --%>
                           

                                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                   <asp:Button ID="Close" runat="server"   
                            class="btn mystyle1 " Text="Close" onclick="Close_Click"/>

                                               </div>





            <div class=" form-grids row form-grids-right">
						<div class="widget-shadow " data-example-id="basic-forms"> 
							<div class="form-title">
								<h4>Video</h4>
							</div>
							<div class="form-body">
								
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="VIDEO_ID" 
                           class="table-responsive view " DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" >
                                                       
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="VIDEO_TITLE" HeaderText="Title" 
                            SortExpression="VIDEO_TITLE" />
                        <asp:BoundField DataField="VIDEO_SRC" HeaderText="Source" 
                            SortExpression="VIDEO_SRC" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>

                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                                        DeleteCommand="DELETE FROM [VIDEO_TB] WHERE [VIDEO_ID] = @VIDEO_ID" 
                                                        InsertCommand="INSERT INTO [VIDEO_TB] ([VIDEO_TITLE], [VIDEO_SRC]) VALUES (@VIDEO_TITLE, @VIDEO_SRC)" 
                                                        SelectCommand="SELECT * FROM [VIDEO_TB]" 
                                                        UpdateCommand="UPDATE [VIDEO_TB] SET [VIDEO_TITLE] = @VIDEO_TITLE, [VIDEO_SRC] = @VIDEO_SRC WHERE [VIDEO_ID] = @VIDEO_ID">
                                                        <DeleteParameters>
                                                            <asp:Parameter Name="VIDEO_ID" Type="Int64" />
                                                        </DeleteParameters>
                                                        <InsertParameters>
                                                            <asp:Parameter Name="VIDEO_TITLE" Type="String" />
                                                            <asp:Parameter Name="VIDEO_SRC" Type="String" />
                                                        </InsertParameters>
                                                        <UpdateParameters>
                                                            <asp:Parameter Name="VIDEO_TITLE" Type="String" />
                                                            <asp:Parameter Name="VIDEO_SRC" Type="String" />
                                                            <asp:Parameter Name="VIDEO_ID" Type="Int64" />
                                                        </UpdateParameters>
                                                    </asp:SqlDataSource>


                                                    <asp:Label ID="lblpid" runat="server" Visible="false"></asp:Label>


							</div>
						</div>
					</div>


                                               </div>
                                    

							</div>
						</div>
                        
					</div>
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

                <li><a href="Change_Pass.aspx"><i class="fa fa-key" aria-hidden="true" style="padding-right:15px;">
                    </i>Change Password </a></li>
			

                 <li ><a href="Gallery_Master.aspx">
                    <i class="fa fa-picture-o" aria-hidden="true" style="padding-right:15px;"></i>Gallery Master
                    </a></li>
                <li><a href="News_Master.aspx">
                    <i class="fa fa-play" aria-hidden="true" style="padding-right:15px;"></i>News Master
                    </a></li>
				  <li class="active"><a href="Video_Master.aspx">
                    <i class="fa fa-play" aria-hidden="true" style="padding-right:15px;"></i>Video Master
                    </a></li>
                 
                   <li><a href="Product_Master.aspx">
                    <i class="fa fa-play" aria-hidden="true" style="padding-right:15px;"></i>Services Master
                    </a></li>
                     
    
				
            </ul>

    </nav>
</asp:Content>


