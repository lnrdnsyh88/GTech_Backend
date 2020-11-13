using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;

using GTech_ViewModel.Users;
using GTech_CrossCutting.DataAccessHelper;
using GTech_ViewModel.Reconcile;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace GTech_DAL.Reconcile
{
    public class ReconcileDAL
    {
        #region POST
        public static List<spReconcileTransaction_Response_ViewModel> GetReconcileTransaction(string connstring, spReconcileTransaction_Request_ViewModel p)
        {
            DbTransaction DBtran = new DbTransaction(connstring);

            List<spReconcileTransaction_Response_ViewModel> retVal = new List<spReconcileTransaction_Response_ViewModel>();
            DataTable dt = new DataTable();

            dt = DBtran.DbToDataTable("spReconcileTransaction", new { DateStart = Convert.ToDateTime(p.DateStart), DateEnd = Convert.ToDateTime(p.DateEnd) }, true);

            foreach (DataRow row in dt.Rows)
            {
                retVal.Add(
                    new spReconcileTransaction_Response_ViewModel
                    {
                        TransactionDate = Convert.ToDateTime(row["TransactionDate"].ToString()),
                        TransactionNumber = row["TransactionNumber"].ToString(),
                        eCommerceAmount = Convert.ToDouble(row["eCommerceAmount"].ToString()),
                        PaymentGatewayAmount = Convert.ToDouble(row["PaymentGatewayAmount"].ToString()),
                        BankTransferAmount = Convert.ToDouble(row["BankTransferAmount"].ToString()),
                        isMatched = Convert.ToBoolean(row["isMatched"].ToString() == "1")
                    }
                );
            }

            return retVal;
        }
        #endregion
    }
}
