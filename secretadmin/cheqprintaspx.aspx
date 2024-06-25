<%@ Page Language="C#" MasterPageFile="~/admin/admin.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="cheqprintaspx.aspx.cs" Inherits="admin_cheqprintaspx" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="javascript" type="text/javascript">
// <!CDATA[

function TABLE1_onclick() {

}

// ]]>
</script>

    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px" id="TABLE1" onclick="return TABLE1_onclick()">
        <tr>
            <td>
            </td>
            <td style="vertical-align: middle; width: 800px; text-align: center">
                <span style="font-size: 12pt"><strong>
                    <br />
                    Select Closing:</strong> </span>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="114px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>6</asp:ListItem>
                    <asp:ListItem>7</asp:ListItem>
                    <asp:ListItem>8</asp:ListItem>
                    <asp:ListItem>9</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem Selected="True">Select</asp:ListItem>
                </asp:DropDownList></td>
            <td>
            </td>
        </tr>
        <tr>
            <td style="height: 16px">
            </td>
            <td style="width: 800px; height: 16px; text-align: center;">
                <asp:Label ID="Label1" runat="server" ForeColor="Red" Visible="False"
                    Width="308px"></asp:Label></td>
            <td style="height: 16px">
            </td>
        </tr>
        <tr>
            <td style="height: 121px">
            </td>
            <td style="width: 800px; text-align: center; height: 121px;">
               <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False" AllowPaging="true"  CellPadding="1" Height="106px" Width="498px" ForeColor="#333333" GridLines="None" PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging">
                <Columns>
                   <asp:BoundField HeaderText="Name" DataField="appmstfName" />
                   <asp:BoundField HeaderText="User ID" DataField="appmstid" />
                   <asp:BoundField HeaderText="Closing" DataField="PaymenttranDraftId" />
                   <asp:BoundField HeaderText="Total Amount" DataField="dispachedamt" />
                </Columns>
                   <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                   <RowStyle BackColor="#EFF3FB" />
                   <EditRowStyle BackColor="#2461BF" />
                   <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                   <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                   <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                   <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
            <td style="height: 121px">
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td style="width: 800px; text-align: center;">
                <asp:Button ID="btnprint" runat="server" OnClick="btnprint_Click" Text="Print Cheque"
                    Width="86px" Height="29px" /></td>
            <td>
            </td>
        </tr>
    </table>


</asp:Content>

