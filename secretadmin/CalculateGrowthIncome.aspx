<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="CalculateGrowthIncome.aspx.cs" Inherits="admin_CalculateGrowthIncome" Title="Calculate Growth Income : Admin Control" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script language="javascript" type="text/javascript">
  <!--
    function confirmation() 
    {
        return confirm("Calculate Growth Closing")
    }
    function confirmation2() 
    {
        return confirm("Calculate Sponser Growth Closing")
    }
-->
    </script>

    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="width: 600px; height: 25px">
            </td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 600px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <span style="font-size: 16px; color: #ffffff"><strong>Calculate Growth Income</strong></span></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                height: 25px; background-color: #EDF0FD; text-align: center">
                &nbsp;<asp:Label ID="Label1" runat="server" Text="Label" Font-Bold="True" ForeColor="Red" Width="210px"></asp:Label></td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                height: 35px; background-color: #EDF0FD; text-align: center">
                <asp:Button ID="Button1" runat="server" onClick="Button1_Click" Text="Calculate Growth Income" Width="294px"  OnClientClick="return confirmation()" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White"/></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                height: 25px; background-color: #EDF0FD; text-align: center">
                &nbsp;</td>
            <td style="width: 100px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid; width: 600px;
                border-bottom: #000000 1px solid; height: 35px; background-color: #EDF0FD; text-align: center">
                &nbsp;</td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 35px">
            </td>
            <td style="border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px;
                border-bottom-color: #000000; width: 600px; height: 35px; text-align: center;
                border-right-width: 1px; border-right-color: #000000">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/admin/SelectQualifyingGrowthId.aspx">Back</asp:HyperLink></td>
            <td style="width: 100px; height: 35px">
            </td>
        </tr>
    </table>
    <br />
    
</asp:Content>

