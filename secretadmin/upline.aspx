<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" CodeFile="upline.aspx.cs" Inherits="admin_upline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    
    <style type="text/css">
    
    body,td,th{
    font-family: Arial;
    font-size: 12px;
    }
    
    
    </style>

    <div align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
      <td><div align="center">
        <table width="900" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
    
   <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 350px; height: 25px">
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Upline Report</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 25px; text-align: center">
                <strong>
                Get Sponsor Details</strong></td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 25px; text-align: center">
                <strong>
                Get Parent Details</strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 25px; text-align: center">
                &nbsp;<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>&nbsp;
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" BackColor="#2881A2" BorderColor="Black" Font-Bold="True" ForeColor="White" ValidationGroup="v" /></td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 25px; text-align: center">
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>&nbsp;
                <asp:Button ID="Button2" runat="server" OnClick="parent_Click" Text="Submit" BackColor="#2881A2" BorderColor="Black" Font-Bold="True" ForeColor="White" ValidationGroup="vv" /></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-left: #000000 1px solid; height: 25px; text-align: left; border-bottom: #000000 1px solid;" colspan="2">
                &nbsp;<asp:Label ID="Label1" runat="server" ForeColor="#C00000"></asp:Label>
                &nbsp;&nbsp;&nbsp;</td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-left: #000000 1px solid;
                height: 25px; text-align: center; border-bottom: #000000 1px solid;">
                <asp:DataGrid ID=dgrid runat=server AllowPaging="True" PageSize="20" OnPageIndexChanged="dgrid_PageIndexChanged" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="700px" >
       <PagerStyle BackColor="#69B5D1" ForeColor="#333333" HorizontalAlign="Center" Mode="NumericPages" />
       <Columns>
        <asp:TemplateColumn HeaderText="Sr.No" ItemStyle-Font-Bold="true">
                       <ItemTemplate >
                         <%#dgrid.PageSize * dgrid.CurrentPageIndex + Container.ItemIndex + 1%>
                       </ItemTemplate>
                    </asp:TemplateColumn>
 
           <asp:BoundColumn DataField="appMstRegno" HeaderText="UserId"></asp:BoundColumn>
            <asp:BoundColumn DataField="AppMstFName" HeaderText="Name"></asp:BoundColumn>
             <asp:BoundColumn DataField="SponsorID" HeaderText="Sponsor ID"></asp:BoundColumn>
            
             
               <asp:BoundColumn DataField="AppmstDOJ" HeaderText="Date Of Joinning"></asp:BoundColumn>
               <asp:BoundColumn DataField="Joinfor" HeaderText="Join For"></asp:BoundColumn>
               <asp:BoundColumn DataField="appmstpaid" HeaderText="Status"></asp:BoundColumn>
       </Columns>
       <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
       <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
       <AlternatingItemStyle BackColor="White" />
       <ItemStyle BackColor="#EDF0FD" ForeColor="#333333" />
      <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
   </asp:DataGrid></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
    </table>
    
            </td>
          </tr>
        </table>
      </div></td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
            Display="None" ErrorMessage="Please Enter User Id!" ValidationGroup="v"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" Display="None"
                ErrorMessage="Please Enter User Id!" ValidationGroup="vv"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                    ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1"
                    Display="None" ErrorMessage="Invalid Input!" ValidationExpression="^[a-zA-Z0-9]*"
                    ValidationGroup="v"></asp:RegularExpressionValidator><asp:RegularExpressionValidator
                        ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2"
                        Display="None" ErrorMessage="Invalid Input!" ValidationExpression="^[a-zA-Z0-9]*"
                        ValidationGroup="vv"></asp:RegularExpressionValidator><asp:ValidationSummary ID="ValidationSummary1"
                            runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="v" />
        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="vv" />
 </asp:Content>