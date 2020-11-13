using System;
using System.Collections.Generic;
using System.Text;

namespace GTech_ViewModel.Reconcile
{
    public class spReconcileTransaction_Request_ViewModel
    {
        public string DateStart { get; set; }
        public string DateEnd { get; set; }
    }

    public class spReconcileTransaction_Response_ViewModel
    {
        public DateTime TransactionDate { get; set; }
        public string TransactionNumber { get; set; }
        public double eCommerceAmount { get; set; }
        public double PaymentGatewayAmount { get; set; }
        public double BankTransferAmount { get; set; }
        public bool isMatched { get; set; }
    }
}
