using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

using GTech_ViewModel.Users;
using GTech_ViewModel.API;

using GTech_BusinessLogic.Users;
using Newtonsoft.Json;
using System.Net;
using Microsoft.Extensions.Configuration;
using System.IO;
using GTech_API.Helper;

namespace GTech_API.Controllers.Users
{
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        [Route("PostInsertUsers")]
        [HttpPost]
        public JsonResult PostInsertUsers(spInsertUser_Request_ViewModel param)
        {
            string connstring = ConfigurationHelper.getConnectionString();

            ApiResponse<spInsertUser_Request_ViewModel> result = new ApiResponse<spInsertUser_Request_ViewModel> { ReturnType = "S" };
            spInsertUser_Request_ViewModel data = new spInsertUser_Request_ViewModel();
            
            try
            {
                bool OutputFlag = false;
                string OutputMessage = "";
                data = param; 

                bool flagApi = UsersLogic.PostInsertUsers(connstring, param, out OutputFlag, out OutputMessage);

                data.OutputFlag = OutputFlag;
                data.OutputMessage = OutputMessage;

                result.SetValue("S", "", null, data);
            }
            catch (Exception ex)
            {
                result.SetValue("E", ex.ToString(), ex);
            }

            return new JsonResult(result);
        }

        [Route("GetSelectUsers")]
        [HttpPost]
        public JsonResult GetSelectUsers()
        {
            string connstring = ConfigurationHelper.getConnectionString();

            ApiResponse<List<spSelectUsers_Response_ViewModel>> result = new ApiResponse<List<spSelectUsers_Response_ViewModel>> { ReturnType = "S" };
            List<spSelectUsers_Response_ViewModel> data = new List<spSelectUsers_Response_ViewModel>();

            try
            {
                data = UsersLogic.GetSelectUsers(connstring);

                result.SetValue("S", "", null, data);
            }
            catch (Exception ex)
            {
                result.SetValue("E", ex.ToString(), ex);
            }

            return new JsonResult(result);

        }

        [Route("GetUsersLogin")]
        [HttpPost]
        public JsonResult GetUsersLogin(spUsersLogon_Request_ViewModel param)
        {
            string connstring = ConfigurationHelper.getConnectionString();

            ApiResponse<spUsersLogon_Request_ViewModel> result = new ApiResponse<spUsersLogon_Request_ViewModel> { ReturnType = "S" };
            spUsersLogon_Request_ViewModel data = new spUsersLogon_Request_ViewModel();

            try
            {
                bool OutputFlag = false;
                string OutputMessage = "";
                string OutputToken = "";
                data = param;

                bool flagApi = UsersLogic.GetUsersLogin(connstring, param, out OutputFlag, out OutputMessage, out OutputToken);

                data.OutputFlag = OutputFlag;
                data.OutputMessage = OutputMessage;
                data.OutputToken = OutputToken;

                result.SetValue("S", "", null, data);
            }
            catch (Exception ex)
            {
                result.SetValue("E", ex.ToString(), ex);
            }

            return new JsonResult(result);
        }

        [Route("GetValidateToken")]
        [HttpPost]
        public JsonResult GetValidateToken(spValidateToken_Request_ViewModel param)
        {
            string connstring = ConfigurationHelper.getConnectionString();

            ApiResponse<spValidateToken_Request_ViewModel> result = new ApiResponse<spValidateToken_Request_ViewModel> { ReturnType = "S" };
            spValidateToken_Request_ViewModel data = new spValidateToken_Request_ViewModel();

            try
            {
                bool OutputFlag = false;
                string OutputMessage = "";
                data = param;

                bool flagApi = UsersLogic.GetValidateToken(connstring, param, out OutputFlag, out OutputMessage);

                data.OutputFlag = OutputFlag;
                data.OutputMessage = OutputMessage;

                result.SetValue("S", "", null, data);
            }
            catch (Exception ex)
            {
                result.SetValue("E", ex.ToString(), ex);
            }

            return new JsonResult(result);
        }
    }
}
