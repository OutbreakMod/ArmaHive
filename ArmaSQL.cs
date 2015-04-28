using MySql.Data.MySqlClient;
using System;

namespace ArmaHive
{
    class ArmaSQL
    {

        public static string GetConnectionString()
        {
            MySqlConnectionStringBuilder ConnString = new MySqlConnectionStringBuilder();
            {
                ConnString.Server = "localhost";
                ConnString.Port = 3306;
                ConnString.UserID = "root";
                ConnString.Password = "dickface31";
                ConnString.Database = "arma_hive";
                ConnString.MinimumPoolSize = 0;
                ConnString.MaximumPoolSize = 30;
            }
            return ConnString.ToString();
        }

        public static MySqlConnection GetConnection()
        {
            MySqlConnection sqlConnection = new MySqlConnection(GetConnectionString());
            sqlConnection.Open();
            return sqlConnection;
        }

        public static string ExecuteUpdate(String table, String field, String fieldSet, String where, String equals)
        {
            MySqlConnection sqlConnecton = GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.Parameters.AddWithValue("set", fieldSet);
            command.CommandText = "UPDATE `" + table + "` SET `" + field + "` = @set WHERE `" + where + "` = '" + equals + "'";

            String found = string.Empty;

            try
            {
                command.ExecuteNonQuery();
                found = "Select: " + GetField(table, field, where, equals);
            }
            catch (Exception e)
            {
                found = "ERROR ArmaHive: " + e;
            }

            sqlConnecton.Close();

            return found;
        }

        public static string ExecuteDelete(String table, String where, String equals)
        {
            MySqlConnection sqlConnecton = GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.CommandText = "DELETE FROM `" + table + "` WHERE `" + where + "` = '" + equals + "'";

            String found = string.Empty;

            try
            {
                command.ExecuteNonQuery();
                found = "Deleted from table: " + table;
            }
            catch (Exception e)
            {
                found = "ERROR ArmaHive: " + e;
            }

            sqlConnecton.Close();

            return found;
        }

        public static string GetField(String table, String field, String where, String equals)
        {
            MySqlConnection sqlConnecton = GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.CommandText = "SELECT `" + field + "` FROM `" + table + "` WHERE `" + where + "` = '" + equals + "'";

            String found = string.Empty;

            try
            {
                found = command.ExecuteScalar().ToString();
            }
            catch (Exception e)
            {
                found = "ERROR ArmaHive: " + e;
            }

            sqlConnecton.Close();

            return found;
        }

        public static string GetExists(String table, String where, String equals)
        {
            MySqlConnection sqlConnecton = GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.CommandText = "SELECT * FROM `" + table + "` WHERE `" + where + "` = '" + equals + "'";

            String found = "false";

            try
            {
                MySqlDataReader reader = command.ExecuteReader();
                found = reader.HasRows ? "true" : "false";
            }
            catch (Exception e)
            {
                found = "ERROR ArmaHive: " + e;
            }

            sqlConnecton.Close();

            return found;
        }
    }
}
