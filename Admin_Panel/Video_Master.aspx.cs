﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

public partial class Admin_Panel_Video_Master : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        if (txtsrc.Text != "" && txttitle.Text != "")
        {
            SqlCommand cmd = new SqlCommand("insert into VIDEO_TB(VIDEO_TITLE,VIDEO_SRC) values('" + txttitle.Text + "','" + txtsrc.Text + "')");
            cmd.Connection = ConnectionFactory.getConnection();
            cmd.ExecuteNonQuery();
            lblmsg.ForeColor = Color.Green;
            lblmsg.Text = "Data Uploaded Successfully.";
            txttitle.Text = "";
            txtsrc.Text = "";
            GridView1.DataBind();
        }
        else
        {
            lblmsg.ForeColor = Color.Red;
            lblmsg.Text = "Please enter valid Data.";
        }

    }
    protected void Close_Click(object sender, EventArgs e)
    {
        txtsrc.Text = "";
        txttitle.Text = "";
        btnadd.Text = "Add";
        lblmsg.Text = "";
        GridView1.SelectedIndex = -1;
    }
}