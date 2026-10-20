<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Panel/MasterPage1.master" AutoEventWireup="true" CodeFile="Gallery_Master.aspx.cs" Inherits="Admin_Panel_Gallery_Master" %>

<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_Panel/MasterPage1.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Panel_Default" %>--%>


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
                            <h4>Gallery</h4>
                        </div>
                        <div class="form-body">

                            <div class="form-horizontal">

                                <div class="form-group">
                                    <asp:Label ID="Label1" runat="server" class="col-sm-2 control-label" Text="       Image Name "></asp:Label>
                                    <%--<label for="inputEmail3" class="col-sm-2 control-label">Email</label>--%>
                                    <div class="col-sm-3">

                                        <asp:TextBox ID="txtimgnm" runat="server" class="form-control" Style="height: 30px;"></asp:TextBox>


                                    </div>
                                </div>
                                <div class="form-group">


                                    <asp:Label ID="Label2" runat="server" class="col-sm-2 control-label" Text=" Image Description"></asp:Label>
                                    <%--<label for="inputEmail3" class="col-sm-2 control-label">Email</label>--%>
                                    <div class="col-sm-3">

                                        <asp:TextBox ID="txtimgdesc" runat="server" class="form-control" Style="height: 143px;" TextMode="MultiLine"></asp:TextBox>

                                    </div>
                                </div>

                                <div class="form-group ">
                                    <div class="col-sm-2">
                                        <asp:Label ID="Label6" runat="server" class="control-label" Text=" Select Image"></asp:Label>
                                    </div>

                                    <div class="col-sm-3">
                                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="addkey_btn" Style="width: 100%;" /><br />

                                        <asp:Button ID="btnup" runat="server" class="btn btn-default "
                                            CssClass="addkey_btn" Text="Upload" OnClick="btnup_Click" />
                                       <asp:Label ID="Label13" runat="server"></asp:Label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label8" runat="server" class="col-sm-2 control-label" Text="Image"></asp:Label>

                                    <asp:Label ID="Label12" runat="server"></asp:Label>

                                    <div class="col-sm-3">
                                        <asp:Image ID="Image1" runat="server" Height="146px" Width="205px" />
                                    </div>
                                </div>

                                <asp:Label ID="lblpath" runat="server" Visible="False"></asp:Label>
                                <asp:Label ID="Label4" runat="server" Visible="False"></asp:Label>
                                <asp:Label ID="lblmsg" runat="server"></asp:Label>

                                <div class="col-sm-offset-2">

                                    <asp:Button ID="btnadd" runat="server" class="btn mystyle" Text="Add"
                                        OnClick="btnadd_Click" />
                                    <%-- <button type="submit" class="btn btn-default">Submit</button> --%>
                                    <%--   <a href="#"><span class="label label-success">Success</span></a>--%>
                                    <%--   <asp:Button ID="Button1" runat="server"   class="label label-success " Text="Add" > --%>
                           

                                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                         <asp:Button ID="Close" runat="server"
                                             class="btn mystyle1 " Text="Close" OnClick="Close_Click" />
                                    <asp:Label ID="lblmsg1" runat="server"></asp:Label>

                                </div>
                                <asp:Label ID="Label3" runat="server"></asp:Label>

                                <div class=" form-grids row form-grids-right">
                                    <div class="widget-shadow " data-example-id="basic-forms">
                                        <div class="form-title">
                                            <h4>Gallery</h4>
                                        </div>
                                        <div class="form-body">
                                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" class="table-responsive"
                                                CellPadding="4" DataKeyNames="IMAGES_ID" DataSourceID="SqlDataSource1" ForeColor="#333333"
                                                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowCommand="GridView1_RowCommand"
                                                OnRowDataBound="GridView1_RowDataBound" OnPageIndexChanging="GridView1_PageIndexChanging"
                                                PageSize="7" GridLines="None" Style="text-align: center;">
                                                <AlternatingRowStyle BackColor="White" />
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("IMAGES_ID") %>'
                                                                CommandName="Delete1">Delete</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="IMAGES_NAME" HeaderText=" Name " SortExpression="IMAGES_NAME" />
                                                    <asp:BoundField DataField="IMAGES_DESC" HeaderText="Description" SortExpression="IMAGES_DESC" />
                                                    <asp:TemplateField HeaderText="Image" SortExpression="IMAGES">
                                                        <ItemTemplate>
                                                            <asp:Image ID="Image2" runat="server" Height="103px" ImageUrl='<%#Eval("IMAGES") %>'
                                                                Width="144px" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%#Eval("IMAGES") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
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
                                            <asp:Label ID="lblpid" runat="server"></asp:Label>

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

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder2">
 <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
   
			 <ul class="nav" id="side-menu">

                <li ><a href="Home.aspx"><i class="fa fa-home nav_icon"></i>Home</a> </li>

                <li><a href="Change_Pass.aspx"><i class="fa fa-key" aria-hidden="true" style="padding-right:15px;">
                    </i>Change Password </a></li>
			

                 <li class="active"><a href="Gallery_Master.aspx">
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


