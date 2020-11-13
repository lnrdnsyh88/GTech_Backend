using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace GTech_API.Helper
{
    public class ConfigurationHelper
    {
        public static string getConnectionString()
        {
            string ConnectionString = "";

            var builder = new ConfigurationBuilder()
                                   .SetBasePath(Directory.GetCurrentDirectory())
                                   .AddJsonFile("appsettings.json");
            var configuration = builder.Build();

            ConnectionString = configuration["Data:ConnectionString"];

            return ConnectionString;
        }
    }
}
