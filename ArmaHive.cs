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

        public string GetObjectSpawns()
        {
            MySqlCommand command = ArmaSQL.GetConnection().CreateCommand();

            DataTable dataTable = new DataTable();

            //command.Parameters.AddWithValue("@name", Hive);
            command.CommandText = "SELECT * FROM object_spawns";

            using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
            {
                adapter.Fill(dataTable);
            }

            command.CommandText = null;
            List<String> storage = new List<String>();

            foreach (DataRow row in dataTable.Rows)
            {
                storage.Add("[" + row["id"] + ", \"" + row["class"] + "\", " + row["position"] + ", " + row["dir"] + "]");
            }

            command.Connection.Close();

            return "[" + string.Join(",", storage.ToArray()) + "]";
        }

        public string GetObjectStorage(string Hive)
        {
            MySqlCommand command = ArmaSQL.GetConnection().CreateCommand();

            DataTable dataTable = new DataTable();

            command.Parameters.AddWithValue("@name", Hive);
            command.CommandText = "SELECT * FROM object_data WHERE server_name = @name";

            using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
            {
                adapter.Fill(dataTable);
            }

            command.CommandText = null;
            List<String> storage = new List<String>();

            foreach (DataRow row in dataTable.Rows)
            {
                if (row["inventory"].ToString().Length == 0)
                {
                    row["inventory"] = "[]";
                }

                if (row["hitpoints"].ToString().Length == 0)
                {
                    row["hitpoints"] = "[]";
                }

                storage.Add("[" + row["id"] + ", \"" + row["class"] + "\", " + row["position"] + ", " + row["dir"] + ", " + row["inventory"] + ", " + row["hitpoints"] + ", " + row["fuel"] + ", " + row["damage"] + "]");
            }

            command.Connection.Close();

            return "[" + string.Join(",", storage.ToArray()) + "]";
        }

        public string NewObject(string Hive, string clazz, string position, String dir, String inventory, String hitPoints, String fuel, String damage)
        {
            MySqlConnection sqlConnecton = ArmaSQL.GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.Parameters.AddWithValue("@class", clazz);
            command.Parameters.AddWithValue("@position", position);
            command.Parameters.AddWithValue("@dir", dir);
            command.Parameters.AddWithValue("@server_name", Hive);
            command.Parameters.AddWithValue("@inventory", inventory);
            command.Parameters.AddWithValue("@hitpoints", hitPoints);
            command.Parameters.AddWithValue("@fuel", fuel);
            command.Parameters.AddWithValue("@damage", damage);
            command.CommandText = "INSERT INTO object_data (class, position, dir, server_name, inventory, hitpoints, fuel, damage) VALUES (@class, @position, @dir, @server_name, @inventory, @hitpoints, @fuel, @damage)";

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

        public static string UpdateObject(string Hive, string id, string inventory, string hitPoints, string position, string dir, string fuel, string damage)
        {
            MySqlConnection sqlConnecton = ArmaSQL.GetConnection();
            MySqlCommand command = sqlConnecton.CreateCommand();

            command.Parameters.AddWithValue("@id", int.Parse(id));
            command.Parameters.AddWithValue("@last_updated", DateTime.Now.ToString());
            command.Parameters.AddWithValue("@inventory", inventory);
            command.Parameters.AddWithValue("@hitpoints", hitPoints);
            command.Parameters.AddWithValue("@position", position);
            command.Parameters.AddWithValue("@dir", dir);
            command.Parameters.AddWithValue("@fuel", fuel);
            command.Parameters.AddWithValue("@damage", damage);
            command.CommandText = "UPDATE object_data SET inventory = @inventory, last_updated = NOW(), hitpoints = @hitpoints, position = @position, dir = @dir, fuel = @fuel, damage = @damage WHERE id = @id";

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
