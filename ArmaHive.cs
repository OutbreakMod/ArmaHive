using Arma2Net.AddInProxy;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;

namespace ArmaHive
{
    [AddIn("ArmaHive")]
    public class ArmaHive : MethodAddIn
    {
        public ArmaHive()
        {
            ArmaHiveSettings.LoadConfig();
        }

        public string GetConfig(String key)
        {
            return ArmaHiveSettings.config[key];
        }

        public string GetDateNow()
        {
            return "[" + DateTime.Now.Year + "," + DateTime.Now.Month + "," + DateTime.Now.Day + "," + DateTime.Now.Hour + "," + DateTime.Now.Minute + "]";
        }

        public string GetUserStorage()
        {
             MySqlCommand command = ArmaSQL.GetConnection().CreateCommand();

            DataTable dataTable = new DataTable();

            command.Parameters.AddWithValue("@name", GetConfig("HIVE_NAME"));
            command.CommandText = "SELECT * FROM users_storage WHERE server_name = @name";

            using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
            {
                adapter.Fill(dataTable);
            }

            command.CommandText = null;
            List<String> storage = new List<String>();

            foreach (DataRow row in dataTable.Rows)
            {
                storage.Add("[" + row["id"] + ", \"" + row["class"] + "\", " + row["position"] + ", " + row["dir"] + ", " + row["inventory"] + "]");
            }

            command.Connection.Close();

            return "[" + string.Join(",", storage.ToArray()) + "]";
        }

        public string GetDateTimezone()
        {
            DateTime time = DateTime.Now;
          
            foreach (TimeZoneInfo timeZoneInfo in TimeZoneInfo.GetSystemTimeZones())
            {
                if (timeZoneInfo.BaseUtcOffset.Hours == int.Parse(GetConfig("TIME_VALUE").Replace("+", "")))
                {
                    TimeZoneInfo tzi = TimeZoneInfo.FindSystemTimeZoneById(timeZoneInfo.Id);
                    time = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, tzi);
                    break;
                }
            }

            return "[" + time.Year + "," + time.Month + "," + time.Day + "," + time.Hour + "," + time.Minute + "]";
        }

        public string NewUser(String uuid, String name, String position, String inventory)
        {
            MySqlConnection sqlConnecton = ArmaSQL.GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.CommandText = "INSERT INTO users (uuid, name, position, inventory) VALUES ('" + uuid + "', '" + name + "', '" + position + "', '" + inventory +"')";

            String found = string.Empty;

            try
            {
                command.ExecuteNonQuery();
                found = "NewUser: worked!";

            }
            catch (Exception e)
            {
                found = "ERROR ArmaHive: " + e;
            }

            sqlConnecton.Close();

            return found;
        }

        public string NewObject(String clazz, String position, String dir, String inventory)
        {
            MySqlConnection sqlConnecton = ArmaSQL.GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.Parameters.AddWithValue("@class", clazz);
            command.Parameters.AddWithValue("@position", position);
            command.Parameters.AddWithValue("@dir", dir);
            command.Parameters.AddWithValue("@server_name", GetConfig("HIVE_NAME"));
            command.Parameters.AddWithValue("@inventory", inventory);
            command.CommandText = "INSERT INTO users_storage (class, position, dir, server_name, inventory) VALUES (@class, @position, @dir, @server_name, @inventory)";

            String found = string.Empty;

            try
            {
                command.ExecuteNonQuery();
                long id = command.LastInsertedId;

                found = ""  + id;

            }
            catch (Exception e)
            {
                found = "ERROR ArmaHive: " + e;
            }

            sqlConnecton.Close();

            return found;
        }

        public static string UpdateObject(String id, String inventory)
        {
            MySqlConnection sqlConnecton = ArmaSQL.GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.Parameters.AddWithValue("@id", int.Parse(id));
            command.Parameters.AddWithValue("@last_updated", DateTime.Now.ToString());
            command.Parameters.AddWithValue("@inventory", inventory);
            command.CommandText = "UPDATE users_storage SET inventory = @inventory, last_updated = NOW() WHERE id = @id";

            String found = string.Empty;

            try
            {
                command.ExecuteNonQuery();
                found = "Select worked";
            }
            catch (Exception e)
            {
                found = "ERROR ArmaHive: " + e;
            }

            sqlConnecton.Close();

            return found;
        }


        public string Select(String table, String field, String where, String equals)
        {
            return ArmaSQL.GetField(table, field, where, equals);
        }

        public string Update(String table, String field, String fieldSet, String where, String equals)
        {
            return ArmaSQL.ExecuteUpdate(table, field, fieldSet, where, equals);
        }

        public string Exists(String table, String where, String equals)
        {
            return ArmaSQL.GetExists(table, where, equals);
        }

        public string Delete(String table, String where, String equals)
        {
            return ArmaSQL.ExecuteDelete(table, where, equals);
        }

    }
}
