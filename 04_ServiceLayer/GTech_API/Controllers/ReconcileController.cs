using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

using GTech_ViewModel.Reconcile;
using GTech_ViewModel.API;

using GTech_BusinessLogic.Reconcile;
using Newtonsoft.Json;
using System.Net;

using GTech_API.Helper;

namespace GTech_API.Controllers.Reconcile
{
    [ApiController]
    [Route("[controller]")]
    public class ReconcileController : ControllerBase
    {
        [Route("GetReconcileTransaction")]
        [HttpPost]
        public JsonResult GetReconcileTransaction(spReconcileTransaction_Request_ViewModel p)
        {
            string connstring = ConfigurationHelper.getConnectionString();

            HttpResponseMessage retRes = new HttpResponseMessage();
            ApiResponse<List<spReconcileTransaction_Response_ViewModel>> result = new ApiResponse<List<spReconcileTransaction_Response_ViewModel>> { ReturnType = "S" };
            List<spReconcileTransaction_Response_ViewModel> data = new List<spReconcileTransaction_Response_ViewModel>();

            try
            {
                data = ReconcileLogic.GetReconcileTransaction(connstring, p);

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
