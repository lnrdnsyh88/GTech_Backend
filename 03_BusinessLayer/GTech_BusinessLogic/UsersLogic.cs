using System;

using GTech_ViewModel.Users;
using GTech_DAL.Users;
using System.Collections.Generic;

namespace GTech_BusinessLogic.Users
{
    public class UsersLogic
    { 
        public static bool PostInsertUsers(string connstring, spInsertUser_Request_ViewModel p, out bool OutputFlag, out string OutputMessage)
        {
            bool result = UserDAL.PostInsertUsers(connstring, p, out OutputFlag, out OutputMessage);
            return result;
        }

        public static List<spSelectUsers_Response_ViewModel> GetSelectUsers(string connstring)
        {
            List<spSelectUsers_Response_ViewModel> result = UserDAL.GetSelectUsers(connstring);
            return result;
        }

        public static bool GetUsersLogin(string connstring, spUsersLogon_Request_ViewModel p, out bool OutputFlag, out string OutputMessage, out string OutputToken)
        {
            bool result = UserDAL.GetUsersLogin(connstring, p, out OutputFlag, out OutputMessage, out OutputToken);
            return result;
        }

        public static bool GetValidateToken(string connstring, spValidateToken_Request_ViewModel p, out bool OutputFlag, out string OutputMessage)
        {
            bool result = UserDAL.GetValidateToken(connstring, p, out OutputFlag, out OutputMessage);
            return result;
        }
    }
}
