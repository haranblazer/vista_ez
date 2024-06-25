<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="addbank1.aspx.cs" Inherits="secretadmin_addbank1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        
        .AlphabetPager a, .AlphabetPager span
        {
            font-size: 8pt;
            display: inline-block;
            height: 25px;
            line-height: 25px;
            min-width: 25px;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
            padding: 10 1px 10 1px;
            margin-bottom: 4px;
        }
        
        .AlphabetPager a
        {
            background: linear-gradient(#fbb34b , #fbb34b);
            color: rgb(255, 255, 255);
            border: 1px solid linear-gradient(#fbb34b , #fbb34b);
        }
        
        .AlphabetPager span
        {
            background: linear-gradient(#fbb34b , #fbb34b);
            color: #000;
            border: 1px solid linear-gradient(#fbb34b , #fbb34b);
        }
    </style>
    <script type="text/javascript">
        function ConfirmationBox(username) {
            var result = confirm('Are you sure you want to delete ' + Bankname + ' Details');
            if (result) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
  <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add New Bank</h4>					
				</div>
       
     <asp:Label ID="lblUserId" runat="server" Visible="false"></asp:Label>
   <div class="row">
        <div class="col-sm-4">
            <asp:RequiredFieldValidator ID="rfvBankName" runat="server" ControlToValidate="txtBankName"
                SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Bank Name!"
                ValidationGroup="ra"></asp:RequiredFieldValidator>
            <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" ValidationGroup="ra" placeholder="Enter Bank Name"></asp:TextBox>
            <b>
                <asp:Label ID="mess" runat="server" Style="color: Red"></asp:Label></b>
        </div>
        <div class="col-sm-2">
          <%--  <asp:Button ID="btnsubmit" runat="server" Text="Save" OnClick="btnsubmit_Click" CssClass="btn btn-success"
                ValidationGroup="ra" ></asp:Button>--%>
                <button id="btnsubmit" runat="server" title="Submit" class="btn btn-primary"  ValidationGroup="ra" onserverclick="btnsubmit_Click">
              <i class="fa fa-paper-plane" aria-hidden="true"></i>&nbsp;Submit
                </button>
        </div>
    </div>
    <div class="clearfix"></div>
    <br />
    <asp:Label ID="lbl1" runat="server" Visible="false"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="ra" />
    <div class="clearfix"></div>
    
    <div class="AlphabetPager">
        <asp:Repeater ID="rptAlphabets" runat="server">
            <ItemTemplate>
               <asp:LinkButton ID="LinkButton1" runat="server" Text='<%#Eval("Value")%>' Visible='<%# !Convert.ToBoolean(Eval("Selected"))%>'
                    OnClick="Alphabet_Click"/>
                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Value")%>' Visible='<%# Convert.ToBoolean(Eval("Selected"))%>' />
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="clearfix">
    </div>
    
    <div class="table-responsive">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound"
            CssClass="table table-striped table-hover" EmptyDataText="No Record Found!" DataKeyNames="srno"
            AllowPaging="true" PageSize="20" OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <ItemTemplate>
                        <asp:Label ID="lblserial" Text='<%# Container.DataItemIndex + 1%>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="bankname" HeaderText="Bank Name"></asp:BoundField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkdelete" runat="server" OnClick="lnkdelete_Click" Visible="false">Delete</asp:LinkButton>
                        <i class="fa fa-edit"></i>&nbsp;<asp:LinkButton ID="lnkupdate" runat="server" OnClick="lnkupdate_Click">Edit</asp:LinkButton>
                        <asp:Label ID="lblUserIda" runat="server" Visible="false"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div class="row">
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtBankName"
            MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="1000"
            ServiceMethod="GetCity">
        </ajaxToolkit:AutoCompleteExtender>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
        <asp:Label runat="server" ID="llbid" Visible="false"></asp:Label>
        <div class="clearfix">
        </div>
        
   

     
</asp:Content>
