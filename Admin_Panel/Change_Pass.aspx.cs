using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

public partial class Admin_Panel_Change_Pass : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PASSWORD"] == null)
            Response.Redirect("Login.aspx");
        else
        {

        }
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        if (txtnewPass.Text != "" && txtnewRPass.Text != "")
        {
            if ((txtnewPass.Text == txtnewRPass.Text) && (txtoldPass.Text != ""))
            {

                SqlCommand cmd = new SqlCommand("select PASSWORD from ADMIN_LOGIN where USERNAME='ADMIN' ");
                cmd.Connection = ConnectionFactory.getConnection();

                SqlDataAdapter sdaAgent = new SqlDataAdapter(cmd);
                DataTable dsAgent = new DataTable();
                sdaAgent.Fill(dsAgent);
                string stpass = dsAgent.Rows[0]["PASSWORD"].ToString();
                if (stpass == txtoldPass.Text.ToString())
                {

                    SqlCommand cmd1 = new SqlCommand("update ADMIN_LOGIN set PASSWORD=@PASSWORD  where ID=1");
                    cmd1.Connection = ConnectionFactory.getConnection();
                    cmd1.Parameters.AddWithValue("@PASSWORD", txtnewPass.Text.ToString());

                    int i;

                    i = Convert.ToInt32(cmd1.ExecuteNonQuery());
                    if (i > 0)
                    {
                        txtoldPass.Text = "";
                        txtnewPass.Text = "";
                        txtnewRPass.Text = "";
                        lblmsg.ForeColor = Color.Green;
                        lblmsg.Text = "Passsword Changed Successfully......";
                    }
                    else
                    {
                        lblmsg.ForeColor = Color.Red;
                        lblmsg.Text = "Error in updating Password.....";
                    }
                    cmd1.Dispose();
                }
                else
                {
                    lblmsg.ForeColor = Color.Red;
                    lblmsg.Text = "Pls Enter Correct Password..... ";
                    txtoldPass.Text = "";
                    txtoldPass.Focus();
                }
                cmd.Dispose();
            }
            else
            {
                txtnewRPass.Text = "";
                txtnewRPass.Focus();
                lblmsg.ForeColor = Color.Red;
                lblmsg.Text = "Pls Re-enter New Password..... ";
            }
        }
        else
        {
            lblmsg.ForeColor = Color.Red;
            lblmsg.Text = "Please Enter All Fields.";
        }
    }
    protected void btclose_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }

}