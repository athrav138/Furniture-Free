﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

public partial class Login1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblmsg.Text = "";
    }

    protected void btn_login_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con = new SqlConnection("Data Source=(local);Initial Catalog=FURNIDB;Integrated Security=True;");
            con.Open();
            SqlCommand cmd = new SqlCommand("Select * from AUTHO where USERNAME=@USERNAME and PASSWORD=@PASSWORD", con);
            cmd.Parameters.AddWithValue("@USERNAME", txtuname.Text.ToString());
            cmd.Parameters.AddWithValue("@PASSWORD", txtupass.Text.ToString());
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {

                Session["PASSWORD"] = reader["PASSWORD"].ToString();
                Session["USERNAME"] = reader["USERNAME"].ToString();

                reader.Close();
                cmd.Dispose();
                con.Close();
                Response.Redirect("Home.aspx");
            }
            else
            {
                reader.Close();
                cmd.Dispose();
                con.Close();
                lblmsg.Text = "Invalid Username and Password...";
                txtuname.Text = "";
                txtupass.Text = "";
            }
        }
        catch (Exception ex)
        {

            lblmsg.Visible = true;
            lblmsg.Text = ex.Message;
        }
    }
}