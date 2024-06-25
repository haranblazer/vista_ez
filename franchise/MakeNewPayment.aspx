<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="MakeNewPayment.aspx.cs" Inherits="admin_MakeNewPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
          
        }); 
    </script>

    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
  <%--  <script src="js/jquery-1.4.2.js" type="text/javascript"></script>--%>
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>

    <script type="text/javascript">          
                $(document).ready(function () {                  
                    var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
                    $('#<%=txtpono.ClientID %>').autocomplete(dataUserID);

                    });
          
            </script>

           
            <h2 class="head"> <i class="fa fa-money" aria-hidden="true"></i> Make Payment </h2> 


     <div class="clearfix"></div><br /><br />
     <div>
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
           PO No.
        </label>
        <div class="col-sm-3 col-xs-9" style="margin-bottom:15px;">
            <asp:TextBox ID="txtpono" runat="server" TabIndex="1" CssClass="form-control"></asp:TextBox>
             <div id="divUserID" style="display: none;" runat="server">
                        </div>
           </div>
    </div>

    <div class="form-group">  
    <div class="col-sm-2 btn1">  <asp:Button ID="Button1" runat="server" Text="Search" CssClass="btn btn-success" onclick="Button1_Click" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter PO Number" ControlToValidate="txtpono" ValidationGroup="a" Display="None"></asp:RequiredFieldValidator> </div>
    </div>
    </div>


    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            User
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:DropDownList ID="ddlbindfrantype" runat="server" CssClass="form-control">
            </asp:DropDownList>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Sorry  You Have no Purchase Type" ControlToValidate="ddlbindfrantype" InitialValue="0" ValidationGroup="a" Display="None"></asp:RequiredFieldValidator>


        </div>
    </div>
    


        <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
          Amount
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtamount" runat="server" TabIndex="10" CssClass="form-control"></asp:TextBox>

           

  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Amount " ControlToValidate="txtamount"  ValidationGroup="a" Display="None"></asp:RequiredFieldValidator>

        </div>
    </div>

     <div class="clearfix">
    </div>
    <br />

    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Mode
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:DropDownList ID="ddlmode" runat="server" TabIndex="9" CssClass="form-control"
                OnSelectedIndexChanged="ddlmode_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Selected="True" Value="0">---Select---</asp:ListItem>
                <asp:ListItem Value="1">Cash Deposit</asp:ListItem>
                <asp:ListItem Value="2">Cash Deposit At Bank</asp:ListItem>
                <asp:ListItem Value="3">NEFT/RTGS</asp:ListItem>
                <asp:ListItem Value="4">Cheque Deposit</asp:ListItem>
                <asp:ListItem Value="5">DD Deposit</asp:ListItem>
            </asp:DropDownList>

  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please select Mode" ControlToValidate="ddlmode" InitialValue="0" ValidationGroup="a" Display="None"></asp:RequiredFieldValidator>


        </div>


    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
            Bank
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:DropDownList ID="ddlbank" runat="server" TabIndex="9" CssClass="form-control">
            </asp:DropDownList>
        </div>
    </div>
  
    <div class="clearfix">
    </div>
    <br />
   <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
         Cheque Number / DD No / Transfer Id.
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtnumber" runat="server" TabIndex="10" CssClass="form-control"></asp:TextBox>

        </div>
    </div>

      <div class="clearfix">
    </div>
    <br />
   <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
        Branch:
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtbranch" runat="server" TabIndex="10" CssClass="form-control"></asp:TextBox>
        </div>
    </div>

       <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
        Payment Date
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtFromDate" runat="server" TabIndex="10" CssClass="form-control"></asp:TextBox>
        </div>
    </div>

 

    <div class="clearfix">
    </div>
    <br />
    <div class="form-group">
        <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
         Remarks
        </label>
        <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtremarks" runat="server" TabIndex="10" CssClass="form-control"></asp:TextBox>
        </div>
    </div>


   

    <div style="clear: both">
    </div>
    <br />
    <div class="form-group">
    <div class="col-sm-2 col-xs-3"> </div>
    <div class="col-sm-8 col-xs-9">
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="a" runat="server"   ShowMessageBox="true" ShowSummary="false"/>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success"
            TabIndex="13" OnClick="btnSubmit_Click"  ValidationGroup="a"/>
    </div>
    </div>
    <div class="clearfix"> </div> <br />
</asp:Content>
