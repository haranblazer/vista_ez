<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="Maintainance.aspx.cs" Inherits="secretadmin_Maintainance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div>
    <center>       <span style="font-size: 24pt; color: #3300ff">
            <p class="MsoNormal" style="margin: 0in 0in 10pt 0.5in; text-align: center">
                <span style="font-size: 24pt; color: #0000ff; line-height: 115%; font-family: Calibri">
                    We are performing our periodical payout maintenance activity during this period
                   Billing and Stock Transfer can not be done!</span></p>
        </span>
        <br />
        <br />
        <br />
        
       
            <table cellspacing="0">
            <tr>
                <td style="width: 100px">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/under-maintenance.gif" /></td>
            </tr>
            
        </table>
        </center>
    
    </div>
</asp:Content>

