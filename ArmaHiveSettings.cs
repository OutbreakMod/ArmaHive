using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmaHive
{
    public class ArmaHiveSettings
    {
        public static INIFile parser;
        public static Dictionary<String, String> config = null;

        public static void LoadConfig()
        {
            if (config == null)
            {
                config = new Dictionary<string, string>();
                parser = new INIFile("C:/ArmaHive/configuration.ini");

                config.Add("MYSQL_HOSTNAME", parser.Read("MySQL", "Hostname"));
                config.Add("MYSQL_USERNAME", parser.Read("MySQL", "Username"));
                config.Add("MYSQL_PASSWORD", parser.Read("MySQL", "Password"));
                config.Add("MYSQL_DATABASE", parser.Read("MySQL", "Database"));
                config.Add("MYSQL_PORT", parser.Read("MySQL", "Port"));

                config.Add("TIME_SETTING", parser.Read("Time", "Setting"));
                config.Add("TIME_VALUE", parser.Read("Time", "Value"));

                //config.Add("HIVE_NAME", parser.Read("Hive", "Name"));
            }
        }
    }
}
