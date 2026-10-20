using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ConnectionFactory
/// </summary>
public class ConnectionFactory
{
    private static SqlConnection connection = null;
	public ConnectionFactory()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public static SqlConnection getConnection()
    {
        if (connection == null)
        {
            connection = new SqlConnection();
            connection.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            connection.Open();
        }
        else
        {
            if (connection.State == System.Data.ConnectionState.Closed)
            {
                connection.Open();
            }
        }
        return connection;
    }

}