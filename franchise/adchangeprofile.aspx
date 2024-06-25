<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="adchangeprofile.aspx.cs" Inherits="admin_adchangeprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>

        $(document).ready(function () {
            var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
            $('#<%=txtRegNo.ClientID %>').autocomplete(dataUserID);
        });
       
    </script>
   <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Profile</h4>					
				</div>
      


    <asp:Panel ID="pnlProfile" runat="server" DefaultButton="Button1"> 

    <div class="form-group card-group-row row">
    <div class="col-md-2"> <strong class="txt"> Please enter id no. </strong> </div>
    <div class="col-md-3"> <asp:TextBox ID="txtRegNo" runat="server" CssClass="form-control"  TabIndex="1"></asp:TextBox> </div>
    </div>
    
    

    <div class="form-group card-group-row row"> 
    <div class="col-md-2">  <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" TabIndex="2" CssClass="btn btn-success" ValidationGroup="s" /> </div>
    <div class="col-md-3"> <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Names="Arial"></asp:Label> </div>
    </div>
    
    <div class="clearfix"> </div> <br />
     
     <div class="table table-responsive">
        <table style="width: 100%">
         
            <tr>
                <td style="vertical-align: top; width: 285px; text-align: center;">
                    &nbsp;&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRegNo"
                        Display="None" ErrorMessage="Please enter user id !" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000" ValidationGroup="s"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtRegNo"
                            ErrorMessage="Only aplha numeric value is allowed !" ValidationExpression="^[A-Za-z0-9]*"
                            Display="None" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ValidationGroup="s"></asp:RegularExpressionValidator><asp:ValidationSummary
                                ID="ValidationSummary1" runat="server" ValidationGroup="s" ShowMessageBox="true"
                                ShowSummary="false" />
                </td>
            </tr>
        </table>
     </div>
    </asp:Panel>
    <div id="divUserID" style="display: none;" runat="server">
    </div>
</asp:Content>
