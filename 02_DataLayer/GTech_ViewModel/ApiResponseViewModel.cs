using System;
using System.Runtime.Serialization;

namespace GTech_ViewModel.API
{
     public class ApiResponse<T>
    {
        #region "Fields"

        private T _returnData;
        private string _returnMessage;
        private object _returnObject;
        private string _returnType;
        #endregion

        #region "Properties"
        [DataMember()]
        public T ReturnData
        {
            get { return _returnData; }
            set { _returnData = value; }
        }
        [DataMember()]
        public string ReturnMessage
        {
            get { return _returnMessage; }
            set { _returnMessage = value; }
        }
        [DataMember()]
        public object ReturnObject
        {
            get { return _returnObject; }
            set { _returnObject = value; }
        }
        [DataMember()]
        public string ReturnType
        {
            get { return _returnType; }
            set { _returnType = value; }
        }

        #endregion

        #region "Methods"

        public void SetValue(string returnType, string returnMessage, object returnObject = null, T returnData = default(T))
        {
            this.ReturnType = returnType;
            this.ReturnMessage = returnMessage;
            this.ReturnObject = returnObject;
            this.ReturnData = returnData;
        }

        #endregion

    }
}
