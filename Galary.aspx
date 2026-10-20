<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Galary.aspx.cs" Inherits="Galary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>Gallary</h1>
								<p class="mb-4">Donec vitae odio quis nisl dapibus malesuada. Nullam ac aliquet velit. Aliquam vulputate velit imperdiet dolor tempor tristique.</p>
								<p><a href="" class="btn btn-secondary me-2">Shop Now</a><a href="#" class="btn btn-white-outline">Explore</a></p>
							</div>
						</div>
						<div class="col-lg-7">
							<div class="hero-img-wrap">
								<img src="images/couch.png" class="img-fluid">
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->
    		<!-- Start Blog Section -->
		<div class="blog-section">
			<div class="container">
				
				<div class="row">
                <asp:ListView ID="ListView1" runat="server"> 
                    <ItemTemplate> 
					<div class="col-12 col-sm-6 col-md-4 mb-5">
						<div class="post-entry">
							<a href="#" class="post-thumbnail">
                                <asp:Image ID="Image1" ImageUrl='<%# Eval("IMAGES") %>'  runat="server" Height="100"  width="200" />

							</a>
                     
							<div class="post-content-entry">
								<h3><a href="#"><%# Eval("IMAGES_NAME") %></a></h3>
								<div class="meta">
									<span>by <a href="#"><%# Eval("IMAGES_DESC") %></a></span> <span>on <a href="#">Dec 19, 2021</a></span>
								</div>
							</div>
						</div>
					</div>
                    </ItemTemplate>
                    </asp:ListView>
					
				</div>
			</div>
		</div>
		<!-- End Blog Section -->	
</asp:Content>

