﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;

public partial class Admin_Panel_Gallery_Master : System.Web.UI.Page
{
    string imagepath1 = "";
    string imagepath2 = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PASSWORD"] == null)
            Response.Redirect("Login.aspx");
        else
        {

        
        Label13.Visible = false;

        if (!IsPostBack)
        {
            lblpid.Visible = false;

            GRID_DATA();
        }
        }
    }



    protected void btnup_Click(object sender, EventArgs e)
    {


        string extension = Path.GetExtension(FileUpload1.FileName);
        if (extension == ".png" || extension == ".jpg" || extension == ".jpeg" || extension == ".bmp" || extension == ".PNG" || extension == ".JPG" || extension == ".JPEG" || extension == ".BMP")
        {
            isDirectoryExist();
            if (!System.IO.Directory.Exists(Server.MapPath(@"~/GalleryImages/" + FileUpload1.FileName)))
            {
                string filepath = Server.MapPath(@"~/GalleryImages/" + FileUpload1.FileName);
                FileUpload1.SaveAs(filepath);
                imagepath1 = @"~/GalleryImages/" + FileUpload1.FileName + "";
                // Label12.ForeColor = Color.Green;
                Label12.Text = "file" + FileUpload1.FileName + "is uploaded sucessfully";
                Label13.Text = imagepath1;
                Image1.ImageUrl = Label13.Text;
            }
            else
            {
                //Label12.ForeColor = Color.Red;
                Label12.Text = "file allready exists";
                imagepath1 = @"~/GalleryImages/" + FileUpload1.FileName + "";
                Label13.Text = imagepath1;
                Image1.ImageUrl = Label13.Text;

            }
        }
        else
        {
            Label12.Visible = true;
            Label12.Text = "not a image file";

        }
    }
    public void isDirectoryExist()
    {
        if (!System.IO.Directory.Exists(Server.MapPath(@"~/GalleryImages/")))
        {
            System.IO.Directory.CreateDirectory(Server.MapPath(@"~/GalleryImages/"));
        }

    }
    protected void btnadd_Click(object sender, EventArgs e)
    {

        try
        {
            if (btnadd.Text == "Update")
            {
                UpdateData();
            }
            else
            {
                if (txtimgnm.Text != "" && Image1.ImageUrl != "")
                {
                    SqlCommand cmd2 = new SqlCommand("select count(*) from GALLERY where IMAGES_NAME='" + txtimgnm.Text + "'");
                    cmd2.Connection = ConnectionFactory.getConnection();

                    int ImgPresent = Convert.ToInt32(cmd2.ExecuteScalar());

                    if (ImgPresent != 0)
                    {
                        Label3.ForeColor = Color.Red;
                        Label3.Text = "Image all ready Present.";
                    }
                    else
                    {

                        SqlCommand cmd = new SqlCommand("GALLERY_SP");
                        cmd.Parameters.AddWithValue("@ACTION", "INSERT");
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = ConnectionFactory.getConnection();
                        cmd.Parameters.AddWithValue("@IMAGES", Label13.Text);
                        cmd.Parameters.AddWithValue("@IMAGES_NAME", txtimgnm.Text);
                        cmd.Parameters.AddWithValue("@IMAGES_DESC", txtimgdesc.Text);
                        cmd.ExecuteNonQuery();

                        Label3.ForeColor = Color.Green;
                        Label3.Text = "Image added successfully.....";

                        Clear_Data();
                        GRID_DATA();
                        GridView1.DataBind();

                    }
                }
                else
                {
                    Label3.ForeColor = Color.Red;
                    Label3.Text = "Please Fill Manadatory Fields";
                }

            }
        }
        catch (Exception ex)
        {
            Label3.Text = ex.Message;
        }
    }

    private void Clear_Data()
    {
        txtimgnm.Text = "";
        txtimgdesc.Text = "";
        Image1.ImageUrl = "";
        Label12.Text = "";
    }
    private void UpdateData()
    {
        if (Image1.ImageUrl != "")
        {
            SqlCommand cmd = new SqlCommand("GALLERY_SP");
            cmd.Parameters.AddWithValue("@ACTION", "UPDATE");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = ConnectionFactory.getConnection();
            cmd.Parameters.AddWithValue("@IMAGES_ID", lblpid.Text);
            cmd.Parameters.AddWithValue("@IMAGES", Label13.Text);
            cmd.Parameters.AddWithValue("@IMAGES_NAME", txtimgnm.Text);
            cmd.Parameters.AddWithValue("@IMAGES_DESC", txtimgdesc.Text);
            cmd.Connection = ConnectionFactory.getConnection();

            cmd.ExecuteNonQuery();
            GRID_DATA();
            Label3.ForeColor = Color.Green;
            Label3.Text = " Updated successfully....";
            Clear_Data();
           // lbltitle.Text = "ADD GALLERY";
            btnadd.Text = "Add";
        }
        else
        {
            Label3.ForeColor = Color.Red;
            Label3.Text = "Please Fill Manadatory Fields";
        }

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            long selectid = long.Parse(GridView1.DataKeys[GridView1.SelectedIndex].Value.ToString());
            lblpid.Text = selectid.ToString();
            SqlCommand cmd1 = new SqlCommand("GALLERY_SP");
            cmd1.Parameters.AddWithValue("@ACTION", "SELECT");
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@IMAGES_ID", lblpid.Text);
            cmd1.Connection = ConnectionFactory.getConnection();

            SqlDataAdapter ad1 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            ad1.Fill(dt1);
            if (dt1.Rows.Count > 0)
            {

                // TextBox1.Text = dt1.Rows[0]["Category"].ToString();

                Image1.ImageUrl = Label13.Text = dt1.Rows[0]["IMAGES"].ToString();
                txtimgnm.Text = dt1.Rows[0]["IMAGES_NAME"].ToString();
                txtimgdesc.Text = dt1.Rows[0]["IMAGES_DESC"].ToString();



            }
            btnadd.Text = "Update";
           // lbltitle.Text = "UPDATE GALLERY";

        }
        catch (Exception ex)
        {
            Label3.Text = ex.Message;
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete1")
        {
            //Label3.Visible = true;
            try
            {
                long delid = long.Parse(e.CommandArgument.ToString());
                SqlCommand cmd7 = new SqlCommand("GALLERY_SP");
                cmd7.Connection = ConnectionFactory.getConnection();
                cmd7.Parameters.AddWithValue("@ACTION", "DELETE");
                cmd7.CommandType = CommandType.StoredProcedure;
                cmd7.Parameters.AddWithValue("@IMAGES_ID", delid);
                cmd7.ExecuteNonQuery();


                Label3.ForeColor = Color.Green;
                Label3.Text = "Image Deleted successfully....";


                GRID_DATA();
            }
            catch (Exception ex)
            {

                Label3.Text = ex.Message;
            }

        }
    }

    private void GRID_DATA()
    {
        SqlCommand cmd6 = new SqlCommand("GALLERY_SP");
        cmd6.Parameters.AddWithValue("@ACTION", "SELECTALL");
        cmd6.CommandType = CommandType.StoredProcedure;
        cmd6.Connection = ConnectionFactory.getConnection();
        SqlDataAdapter adps = new SqlDataAdapter(cmd6);
        DataTable dtbs = new DataTable();
        adps.Fill(dtbs);
        GridView1.DataSourceID = null;
        GridView1.DataSource = dtbs;
        GridView1.DataBind();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton l = (LinkButton)e.Row.FindControl("LinkButton1");
            l.Attributes.Add("onclick", "javascript:return " +
            "confirm('Are you sure to delete :  " +
            DataBinder.Eval(e.Row.DataItem, "IMAGES_NAME") + "')");

            Session["Rowno"] = DataBinder.Eval(e.Row.DataItem, "IMAGES_ID").ToString();
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataBind();
        GRID_DATA();
    }
    protected void Close_Click(object sender, EventArgs e)
    {
        Clear_Data();
        btnadd.Text = "Add";
       // lbltitle.Text = "Add Gallery";
        GridView1.SelectedIndex = -1;
    }
}