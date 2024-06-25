<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="NextWithdrawalDate.aspx.cs" Inherits="admin_NextWithdrawalDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center"  style="padding-right: 0px; padding-left: 0px; padding-bottom: 0px; margin: 50px 0px 0px; padding-top: 0px;">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>

    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />

    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            $('#<%=txtDOB.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });           
        });
    </script>
    <table style="width:400px; padding:0px;" cellpadding="0px" cellspacing="0px" >
            <tr>
                <td align="center" style="font-weight:bold">
                    <span style="font-size: 11pt; font-family: Arial">
                    Set The Next Withdrawal Date </span>
                </td>
            </tr>
            <tr >
                <td align="center">
                    <asp:TextBox ID="txtDOB" runat="server"></asp:TextBox>
        <br />
                    <br />
        <asp:Label ID="lblError" runat="server" ForeColor="Red" Text=" "></asp:Label>
                </td>
            </tr>
       <tr>
                <td align="center" style="color:#ffffff;font-weight:bold; height: 24px;">
                    <asp:Button CssClass="btn" ID="btnSubmit" runat="server" OnClientClick="return confirm('Are You Sure To Set The Date ?');" Text="Submit" OnClick="btnCalculate_Click" /> </td>
            </tr>
    </table>
    <center>
        &nbsp;
    </center>
        <center>
        &nbsp;</center>
        <center>
            
        </center>
    </div>
    </asp:Content>