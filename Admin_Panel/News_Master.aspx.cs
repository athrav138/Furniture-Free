using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_Panel_News_Master : System.Web.UI.Page
{
    string imagepath1 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PASSWORD"] == null)
            Response.Redirect("Login");
        else
        {
          if (!IsPostBack)
           {
               lblpid.Visible = false;
              Label13.Visible = false;
             GRID_DATA();
          }
        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["USERNAME"] = null;
        Session["PASSWORD"] = null;
        Response.Redirect("Login");
    }
    protected void btnup_Click(object sender, EventArgs e)
    {
        string extension = Path.GetExtension(FileUpload1.FileName);
        if (extension == ".png" || extension == ".jpg" || extension == ".jpeg" || extension == ".bmp" || extension == ".PNG" || extension == ".JPG" || extension == ".JPEG" || extension == ".BMP")
        {
            isDirectoryExist();
            if (!System.IO.Directory.Exists(Server.MapPath(@"~/NewsData/" + FileUpload1.FileName)))
            {
                string filepath = Server.MapPath(@"~/NewsData/" + FileUpload1.FileName);
                FileUpload1.SaveAs(filepath);
                imagepath1 = @"~/NewsData/" + FileUpload1.FileName + "";
                Label12.Visible = true;
                Label12.Text = "file" + FileUpload1.FileName + "is uploaded sucessfully";
                //  Label13.Visible = true;
                Label13.Text = imagepath1;
                Image1.ImageUrl = Label13.Text;
            }
            else
            {
                Label12.Visible = true;
                Label12.Text = "file allready exists";
                imagepath1 = @"~/NewsData/" + FileUpload1.FileName + "";
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

    private void isDirectoryExist()
    {
        if (!System.IO.Directory.Exists(Server.MapPath(@"~/NewsData/")))
        {
            System.IO.Directory.CreateDirectory(Server.MapPath(@"~/NewsData/"));
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
                SqlCommand cmd2 = new SqlCommand("select * from NEWS where NEWS_TITLE='" + txtimgnm.Text + "'");
                cmd2.Connection = ConnectionFactory.getConnection();
                int ImgPresent = Convert.ToInt32(cmd2.ExecuteScalar());

                if (ImgPresent != 0)
                {
                    Label3.Text = "News all ready Present.";
                }
                else
                {
                    if (txtdate.Text != "" && txtimgnm.Text != "" && Image1.ImageUrl != "")
                    {
                        SqlCommand cmd = new SqlCommand("NEWS_SP");
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = ConnectionFactory.getConnection();
                        cmd.Parameters.AddWithValue("@ACTION", "INSERT");
                        cmd.Parameters.AddWithValue("@NEWS_DATE", txtdate.Text);
                        cmd.Parameters.AddWithValue("@NEWS_IMAGE", Label13.Text);
                        cmd.Parameters.AddWithValue("@NEWS_TITLE", txtimgnm.Text);
                        cmd.Parameters.AddWithValue("@NEWS_DESC", txtimgdesc.Text);
                        cmd.ExecuteNonQuery();
                        Label3.Text = "Data Added Successfully";
                        clear();
                        GridView1.DataBind();
                    }
                    else
                    {
                        Label3.Text = "Please Enter Valid Data.";
                    }
                }
            }

        }
        catch (Exception ex)
        {
            Label3.Text = ex.Message;
        }
        GRID_DATA();
        clear();
    }

    private void GRID_DATA()
    {
        SqlCommand cmd6 = new SqlCommand("NEWS_SP");
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

    private void clear()
    {
        txtdate.Text = "";
        txtimgdesc.Text = "";
        txtimgnm.Text = "";
        Label12.Text = "";
        Image1.ImageUrl = "";
    }

    private void UpdateData()
    {
        if (txtdate.Text != "" && txtimgnm.Text != "" && Image1.ImageUrl != "")
        {
            SqlCommand cmd = new SqlCommand("NEWS_SP");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = ConnectionFactory.getConnection();
            cmd.Parameters.AddWithValue("@ACTION", "UPDATE");
            cmd.Parameters.AddWithValue("@NEWS_ID", lblpid.Text);
            cmd.Parameters.AddWithValue("@NEWS_DATE", txtdate.Text);
            cmd.Parameters.AddWithValue("@NEWS_IMAGE", Label13.Text);
            cmd.Parameters.AddWithValue("@NEWS_TITLE", txtimgnm.Text);
            cmd.Parameters.AddWithValue("@NEWS_DESC", txtimgdesc.Text);
            cmd.ExecuteNonQuery();
            GRID_DATA();
            Label3.Visible = true;
            Label3.Text = "News Updated Successfully.....";
            clear();
            btnadd.Text = "Add";
        }
        else
        {
            Label3.Visible = true;
            Label3.Text = "Please Enter Valid Data.";
        }

        GRID_DATA();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            long selectid = long.Parse(GridView1.DataKeys[GridView1.SelectedIndex].Value.ToString());
            lblpid.Text = selectid.ToString();
            SqlCommand cmd1 = new SqlCommand("NEWS_SP");
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Connection = ConnectionFactory.getConnection();
            cmd1.Parameters.AddWithValue("@ACTION", "SELECT");
            cmd1.Parameters.AddWithValue("@NEWS_ID", lblpid.Text);
            SqlDataAdapter ad1 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            ad1.Fill(dt1);
            if (dt1.Rows.Count > 0)
            {
                Image1.ImageUrl = Label13.Text = dt1.Rows[0]["NEWS_IMAGE"].ToString();
                txtimgnm.Text = dt1.Rows[0]["NEWS_TITLE"].ToString();
                txtimgdesc.Text = dt1.Rows[0]["NEWS_DESC"].ToString();
                txtdate.Text = dt1.Rows[0]["NEWS_DATE"].ToString();
            }
            btnadd.Text = "Update";
            //  lbltitle.Text = "UPDATE DATA";
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
            try
            {
                long id = long.Parse(e.CommandArgument.ToString());
                deltedata(id);
            }
            catch (Exception ex)
            {
                Label3.Text = ex.Message;
            }
        }
    }

    private void deltedata(long id)
    {
        SqlCommand cmd = new SqlCommand("NEWS_SP");
        cmd.Connection = ConnectionFactory.getConnection();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ACTION", "DELETE");
        cmd.Parameters.AddWithValue("@NEWS_ID", id);

        int i;
        i = cmd.ExecuteNonQuery();
        if (i > 0)
        {
            Label3.Text = "News deleted Successfully.....";
        }
        cmd.Dispose();
        GRID_DATA();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton l = (LinkButton)e.Row.FindControl("LinkButton1");
            l.Attributes.Add("onclick", "javascript:return " +
            "confirm('Are you sure to delete this News Title:  " +
            DataBinder.Eval(e.Row.DataItem, "NEWS_TITLE") + "')");

            Session["Rowno"] = DataBinder.Eval(e.Row.DataItem, "NEWS_ID").ToString();
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataBind();
    }
    protected void Close_Click(object sender, EventArgs e)
    {
        clear();
        btnadd.Text = "Add";
        //  lbltitle.Text = "Add News & Events ";
        GridView1.SelectedIndex = -1;
    
    }
}