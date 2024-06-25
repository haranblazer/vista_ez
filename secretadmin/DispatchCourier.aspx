<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="DispatchCourier.aspx.cs" Inherits="admin_DispatchCourier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script type="text/javascript">
        $JD(function () {
            var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
            $JD('#<%=txtIdNo.ClientID %>').autocomplete(dataUserID);
        });
    </script>
  
   <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">  Dispatch Courier</h4>					
				</div>
     <div class="col-sm-4">
            <asp:TextBox ID="txtIdNo" runat="server" CssClass="form-control" placeholder="Enter Id No"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="rfvDispatchNo" runat="server" ControlToValidate="txtIdNo"
                ErrorMessage="Please Enter Id!" Font-Names="Arial" Font-Size="Small" ForeColor="#C04000"
                Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
        </div>
   
   
        <div class="col-sm-4">
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control"
                placeholder="Type Your Description"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                ErrorMessage="Please Enter Description!" Font-Names="Arial" Font-Size="Small"
                ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
        </div>
   
 
   
      
        <div class="col-sm-4">
            <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" placeholder="Enter Courier Company Name"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="rfvCourierCompany" runat="server" ControlToValidate="txtCompany"
                ErrorMessage="Please Enter Company Name!" Font-Names="Arial" Font-Size="Small"
                ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
        </div>
    
   
        <div class="col-sm-4">
            <asp:TextBox ID="txtDocketNumber" runat="server" CssClass="form-control" placeholder="Enter Docket Number"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="rfvDocketNo" runat="server" ControlToValidate="txtDocketNumber"
                ErrorMessage="Please Enter Docket Number!" Font-Names="Arial" Font-Size="Small"
                ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
        </div>
   
   
        <div class="col-sm-4">
            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" placeholder="dd/mm/yyyy"
                ToolTip="Date Format Should be dd/mm/yyyy"></asp:TextBox>
        </div>
    
   
   
    
        <div class="col-sm-4">
            <asp:ValidationSummary ID="ValidationCourierForm" runat="server" ValidationGroup="aa"
                ShowMessageBox="true" ShowSummary="false" HeaderText="Correct the following errors..." />
        </div> 
       
        <div class="col-sm-4 ">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Dispatch" CssClass="btn btn-primary"
                ValidationGroup="aa" />
            <div id="divUserID" runat="server" style="display: none;">
            </div>
        </div>

  
</asp:Content>
