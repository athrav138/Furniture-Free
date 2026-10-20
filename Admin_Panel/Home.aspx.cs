using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Drawing;

public partial class Admin_Panel_Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PASSWORD"] == null)
            Response.Redirect("Login.aspx");
        else
        {


        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["USERNAME"] = null;
        Session["PASSWORD"] = null;
        Response.Redirect("Login");
    }
}