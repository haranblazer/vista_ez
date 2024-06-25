<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AgreementDetails.aspx.cs" Inherits="admin_AgreementDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><center>
        &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
    <table align="center" border="0" bordercolor="black" cellpadding="0" cellspacing="0" style="width: 77%; border-right: #2881a2 thin solid; border-top: #2881a2 thin solid; border-left: #2881a2 thin solid; border-bottom: #2881a2 thin solid;">
        <tr align="center" colspan="2">
            <td align="center"colspan="2" style="text-align: center;background-color: #2881A2; border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;">
                <span><span><span style="font-size: 16px"><span style="font-family: Arial; color: #ffffff;">
                    <strong>Agreement Details</strong></span></span></span></span></td>
        </tr>
        <tr style="color: #000000">
            <td align="center"valign="middle" style="border-left: #000000 1px solid; height: 22px; border-top-width: 1px; border-bottom-width: 1px; border-bottom-color: #000000; border-top-color: #000000; background-color: #EDF0FD; border-right-width: 1px; border-right-color: #000000; text-align: left;" colspan="2">
                <span style="font-size: 10pt; font-family: Verdana"></span> 
                <span style="font-size: 10pt; font-family: Verdana"></span> </td>
        </tr>
        <tr style="font-size: 12pt; color: #000000">
            <td align="center" style="height: 97px; border-top-width: 1px; border-top-color: #000000; border-right-width: 1px; border-right-color: #000000; border-left: #000000 1px solid; border-bottom: #000000 1px solid; background-color: #ffffff; vertical-align: top;" valign="middle" colspan="2">
                <table cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="width: 50%; height: 21px; text-align: left;">
                            <span style="font-size: 10pt; font-family: Arial">Agreement For(Id No):</span></td>
                        <td style="width: 50%; height: 21px; text-align: left; font-size: 12pt; font-family: Times New Roman;">
                            <asp:TextBox ID="txtIdNo" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtIdNo"
                                ErrorMessage="Please Enter Id!" Font-Names="Arial" Font-Size="Small" ForeColor="#C04000">Please Enter Id!</asp:RequiredFieldValidator></td>
                    </tr>
                    <tr style="background-color: #edf0fd; font-size: 12pt; color: #000000; font-family: Times New Roman;">
                        <td style="width: 50%; text-align: left" >
                            <span style="font-size: 10pt; font-family: Arial"><span style="background-color: #edf0fd">
                                Ag</span>reement Number:</span></td>
                        <td style="width: 50%; text-align: left;">
                            <asp:TextBox ID="txtAgreementno" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtAgreementno"
                                ErrorMessage="RequiredFieldValidator" Font-Names="Arial" Font-Size="Small" ForeColor="#C04000">Please Enter Agreement Number!</asp:RequiredFieldValidator></td>
                    </tr>
                    <tr >
                        <td style="width: 50%; text-align: left; height: 26px;">
                            <span style="font-size: 10pt; font-family: Arial">Date Of Agreement:</span></td>
                        <td style="width: 50%; text-align: left; height: 26px;">
                            <asp:TextBox ID="txtDD" runat="server" Width="53px" MaxLength="2"></asp:TextBox>
                            &nbsp;/
                            <asp:TextBox ID="txtMM" runat="server" Width="53px" MaxLength="2"></asp:TextBox>
                            /
                            <asp:TextBox ID="txtYYYY" runat="server" Width="53px" MaxLength="4"></asp:TextBox>
                            &nbsp;<span style="font-size: 9pt; font-family: Arial"><strong>&nbsp; DD/MM/YYYY</strong></span></td>
                    </tr>
                    <tr style="background-color: #edf0fd">
                        <td style="text-align: left; height: 24px;" colspan="2">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDD"
                                ErrorMessage="RequiredFieldValidator" Font-Names="Arial" Font-Size="Small" ForeColor="#C04000">Please Enter Day!</asp:RequiredFieldValidator><asp:RangeValidator
                                    ID="RangeValidator1" runat="server" ControlToValidate="txtDD" ErrorMessage="RangeValidator"
                                    Font-Names="Arial" Font-Size="Small" ForeColor="#C04000" MaximumValue="31" MinimumValue="1"
                                    Type="Integer">Day Should be between 1 & 31 </asp:RangeValidator><asp:RangeValidator
                                        ID="RangeValidator2" runat="server" ControlToValidate="txtMM" ErrorMessage="RangeValidator"
                                        Font-Names="Arial" Font-Size="Small" ForeColor="#C04000" MaximumValue="12" MinimumValue="1"
                                        Type="Integer">Month Should be between 1 & 12 </asp:RangeValidator><asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMM" ErrorMessage="RequiredFieldValidator"
                                            Font-Names="Arial" Font-Size="Small" ForeColor="#C04000">Please Enter Month!</asp:RequiredFieldValidator><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtYYYY"
                                ErrorMessage="RequiredFieldValidator" Font-Names="Arial" Font-Size="Small" ForeColor="#C04000">Please Enter Year!</asp:RequiredFieldValidator><asp:RangeValidator
                                    ID="RangeValidator3" runat="server" ControlToValidate="txtYYYY" ErrorMessage="RangeValidator"
                                    Font-Names="Arial" Font-Size="Small" ForeColor="#C04000" MaximumValue="2015"
                                    MinimumValue="2007" Type="Integer">Year should be before 2015</asp:RangeValidator></td>
                    </tr>
                    <tr style="background-color: #edf0fd">
                        <td style="width: 99px; height: 24px; text-align: left">
                        </td>
                        <td style="width: 100px; height: 24px; text-align: left">
                <asp:Button ID="Button1"  runat="server" OnClick="Button1_Click" Text="Submit" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" /></td>
                    </tr>
                </table>
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                    ForeColor="#C00000"></asp:Label></td>
        </tr>
       
    </table>
        </center>
        <center>
            &nbsp;</center>
    
    </div>
    </form>
</body>
</html>
