<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="DispatchCourier.aspx.cs" Inherits="admin_DispatchCourier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
            $('#<%=txtIdNo.ClientID %>').autocomplete(dataUserID);
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Dispatch Courier</h4>					
				</div>

      
         <div class="form-group card-group-row row">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
              *Dispatch To(Id No):
                   </label>
                   <div class="col-sm-3">
                   <asp:TextBox ID="txtIdNo" runat="server"  CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtIdNo"
                                        ErrorMessage="Please Enter Id!" Font-Names="Arial" Font-Size="Small" ForeColor="#C04000"
                                        Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
                   </div>
                   </div>
                   <div class="clearfix"></div>
                   <div class="form-group card-group-row row">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2  control-label">
              *Description:
                   </label>
                   <div class="col-sm-3">
                    <asp:TextBox ID="txtDescription" runat="server" Height="89px" CssClass="form-control" TextMode="MultiLine"
                                       ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDescription"
                                        ErrorMessage="lease Enter Description!" Font-Names="Arial" Font-Size="Small"
                                        ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
                   </div>
                   </div>
                   <div class="clearfix"></div>
                   <div class="form-group card-group-row row">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
              *Courier Company:
                   </label>
                   <div class="col-sm-3">
                    <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCompany"
                                        ErrorMessage="Please Enter Company Name!" Font-Names="Arial" Font-Size="Small"
                                        ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
                   </div>
                   </div>
                   <div class="clearfix"></div>
                    <div class="form-group card-group-row row">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
              *Docket Number:
                   </label>
                   <div class="col-sm-3">
                   <asp:TextBox ID="txtDocketNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDocketNumber"
                                        ErrorMessage="Please Enter Docket Number!" Font-Names="Arial" Font-Size="Small"
                                        ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
                   </div>
                   </div>
                   <div class="clearfix"></div>
                 <div class="form-group card-group-row row">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
              *Date:
                   </label>
                   <div class="col-sm-3">
                   <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                   </div>
                   </div>
                   <div class="clearfix"></div>

                     <div class="form-group card-group-row row">
    
                   <div class="col-sm-2 "> </div>
                   <div class="col-sm-3">
<asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="aa" />
<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Dispatch" CssClass="btn btn-primary ladda-button"
                                        ValidationGroup="aa" />
                                    <div id="divUserID" runat="server" style="display: none;">
                                    </div>
                   </div>
                   </div>
                   <div class="clearfix"></div><br />
      
   
</asp:Content>
