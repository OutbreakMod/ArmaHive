using Arma2Net.AddInProxy;
using MySql.Data.MySqlClient;
using System;
using System.IO;
using System.Linq;

namespace ArmaHive
{
    [AddIn("ArmaHive")]
    public class ArmaHive : MethodAddIn
    {
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
