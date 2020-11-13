using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;

using GTech_ViewModel.Users;
using GTech_CrossCutting.DataAccessHelper;

namespace GTech_DAL.Users
{
    public class UserDAL
    {

        #region POST
        public static bool PostInsertUsers(string connstring, spInsertUser_Request_ViewModel p, out bool OutputFlag, out string OutputMessage)
        {
            DbTransaction DBtran = new DbTransaction(connstring);

            bool result = false;

            try
            {
                OutputFlag = false;
                OutputMessage = "";

                SqlParameterCollection outParameter;
                List<SqlParameter> Parameter = new List<SqlParameter>();

                //in
                Parameter.Add(new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.VarChar, Value = p.UserName });
                Parameter.Add(new SqlParameter() { ParameterName = "@UserPassword", SqlDbType = SqlDbType.VarChar, Value = p.UserPassword });
                Parameter.Add(new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.VarChar, Value = p.Name });

                //out
                Parameter.Add(new SqlParameter() { ParameterName = "@OutputFlag", SqlDbType = SqlDbType.Bit, Direction = ParameterDirection.Output, Size = 50, Value = "" });
                Parameter.Add(new SqlParameter() { ParameterName = "@OutputMessage", SqlDbType = SqlDbType.VarChar, Direction = ParameterDirection.Output, Size = 250, Value = "" });

                DBtran.DbExecute("spInsertUser", Parameter, true, out outParameter);

                result = Convert.ToBoolean(outParameter["@OutputFlag"].Value) == true;

                if (result)
                { 
                    OutputFlag = Convert.ToBoolean(outParameter["@OutputFlag"].Value);
                    OutputMessage = outParameter["@OutputMessage"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                result = false;
                throw new Exception("DAL error : " + ex.Message);
            }

            return result;

        }

        public static List<spSelectUsers_Response_ViewModel> GetSelectUsers(string connstring)
        {
            DbTransaction DBtran = new DbTransaction(connstring);
            List<spSelectUsers_Response_ViewModel> retVal = new List<spSelectUsers_Response_ViewModel>();
            DataTable dt = new DataTable();

            dt = DBtran.DbToDataTable("spSelectUsers",true);

            foreach (DataRow row in dt.Rows)
            {
                retVal.Add(
                    new spSelectUsers_Response_ViewModel
                    {
                        UserName = row["UserName"].ToString(),
                        Name = row["Name"].ToString()
                    });
            }

            return retVal;
        }

        public static bool GetUsersLogin(string connstring, spUsersLogon_Request_ViewModel p, out bool OutputFlag, out string OutputMessage, out string OutputToken)
        {
            DbTransaction DBtran = new DbTransaction(connstring);

            bool result = false;

            try
            {
                OutputFlag = false;
                OutputMessage = "";
                OutputToken = "";

                SqlParameterCollection outParameter;
                List<SqlParameter> Parameter = new List<SqlParameter>();

                //in
                Parameter.Add(new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.VarChar, Value = p.UserName });
                Parameter.Add(new SqlParameter() { ParameterName = "@UserPassword", SqlDbType = SqlDbType.VarChar, Value = p.UserPassword });

                //out
                Parameter.Add(new SqlParameter() { ParameterName = "@OutputFlag", SqlDbType = SqlDbType.Bit, Direction = ParameterDirection.Output, Size = 50, Value = "" });
                Parameter.Add(new SqlParameter() { ParameterName = "@OutputMessage", SqlDbType = SqlDbType.VarChar, Direction = ParameterDirection.Output, Size = 250, Value = "" });
                Parameter.Add(new SqlParameter() { ParameterName = "@OutputToken", SqlDbType = SqlDbType.VarChar, Direction = ParameterDirection.Output, Size = 250, Value = "" });

                DBtran.DbExecute("SpUsersLogon", Parameter, true, out outParameter);

                result = Convert.ToBoolean(outParameter["@OutputFlag"].Value) == true;

                if (result)
                {
                    OutputFlag = Convert.ToBoolean(outParameter["@OutputFlag"].Value);
                    OutputMessage = outParameter["@OutputMessage"].Value.ToString();
                    OutputToken = outParameter["@OutputToken"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                result = false;
                throw new Exception("DAL error : " + ex.Message);
            }

            return result;

        }

        public static bool GetValidateToken(string connstring, spValidateToken_Request_ViewModel p, out bool OutputFlag, out string OutputMessage)
        {
            DbTransaction DBtran = new DbTransaction(connstring);

            bool result = false;

            try
            {
                OutputFlag = false;
                OutputMessage = "";

                SqlParameterCollection outParameter;
                List<SqlParameter> Parameter = new List<SqlParameter>();

                //in
                Parameter.Add(new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.VarChar, Value = p.UserName });
                Parameter.Add(new SqlParameter() { ParameterName = "@UserPassword", SqlDbType = SqlDbType.VarChar, Value = p.UserToken });

                //out
                Parameter.Add(new SqlParameter() { ParameterName = "@OutputFlag", SqlDbType = SqlDbType.Bit, Direction = ParameterDirection.Output, Size = 50, Value = "" });
                Parameter.Add(new SqlParameter() { ParameterName = "@OutputMessage", SqlDbType = SqlDbType.VarChar, Direction = ParameterDirection.Output, Size = 250, Value = "" });


                DBtran.DbExecute("spValidateToken", Parameter, true, out outParameter);

                result = Convert.ToBoolean(outParameter["@OutputFlag"].Value) == true;

                if (result)
                {
                    OutputFlag = Convert.ToBoolean(outParameter["@OutputFlag"].Value);
                    OutputMessage = outParameter["@OutputMessage"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                result = false;
                throw new Exception("DAL error : " + ex.Message);
            }

            return result;

        }
        #endregion
    }
}
