using System;

namespace GTech_ViewModel.Users
{
    public class spInsertUser_Request_ViewModel
    {
        public string UserName { get; set; }
        public string UserPassword { get; set; }
        public string Name { get; set; }
        public bool OutputFlag { get; set; }
        public string OutputMessage { get; set; }
    }

    public class spSelectUsers_Response_ViewModel
    {
        public string UserName { get; set; }
        public string Name { get; set; }
    }

    public class spUsersLogon_Request_ViewModel
    {
        public string UserName { get; set; }
        public string UserPassword { get; set; }
        public bool OutputFlag { get; set; }
        public string OutputMessage { get; set; }
        public string OutputToken { get; set; }
    }

    public class spValidateToken_Request_ViewModel
    {
        public string UserName { get; set; }
        public string UserToken { get; set; }
        public bool OutputFlag { get; set; }
        public string OutputMessage { get; set; }
    }
}
