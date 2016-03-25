using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmaHive
{
    class Utilities
    {
        public static string arrayToString(string Array)
        {
            String ArrayNew = "";

            foreach (string ch in Array.Replace("[", "").Replace("]", "").Split(','))
            {
                char c = (char)int.Parse(ch);
                ArrayNew += c;
            }

            return ArrayNew;
        }

        public static string stringToArray(string str)
        {
            String ArrayNew = "[";

            foreach (char ch in str.ToCharArray())
            {
                int c = ch;
                ArrayNew += c + ",";
            }

            return ArrayNew.Substring(0, ArrayNew.Length - 1) + "]";
        }
    }
}
