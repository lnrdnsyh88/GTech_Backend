using System;

using GTech_DAL.Users;
using System.Collections.Generic;
using GTech_ViewModel.Reconcile;
using GTech_DAL.Reconcile;

namespace GTech_BusinessLogic.Reconcile
{
    public class ReconcileLogic
    {
        public static List<spReconcileTransaction_Response_ViewModel> GetReconcileTransaction(string connstring, spReconcileTransaction_Request_ViewModel p)
        {
            List<spReconcileTransaction_Response_ViewModel> result = ReconcileDAL.GetReconcileTransaction(connstring, p);
            return result;
        }
    }
}
