<%@ Page Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="admincheckmail.aspx.cs" Inherits="admin_admincheckmail" Title="Mail Inbox : Admin Control" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="javascript" type="text/javascript">
<!--
function check_uncheck(Val)
{
  var ValChecked = Val.checked;
  var ValId = Val.id;
  var frm = document.forms[0];
  // Loop through all elements
  for (i = 0; i < frm.length; i++)
  {
    // Look for Header Template's Checkbox
    //As we have not other control other than checkbox we just check following statement
    if (this != null)
    {
      if (ValId.indexOf('CheckAll') !=  - 1)
      {
        // Check if main checkbox is checked,
        // then select or deselect datagrid checkboxes
        if (ValChecked)
          frm.elements[i].checked = true;
        else
          frm.elements[i].checked = false;
      }
      else if (ValId.indexOf('deleteRec') !=  - 1)
      {
        // Check if any of the checkboxes are not checked, and then uncheck top select all checkbox
        if (frm.elements[i].checked == false)
          frm.elements[1].checked = false;
      }
    } // if
  } // for
} // function

function confirmMsg(frm)
{
  // loop through all elements
  for (i = 0; i < frm.length; i++)
  {
    // Look for our checkboxes only
    if (frm.elements[i].name.indexOf("deleteRec") !=  - 1)
    {
      // If any are checked then confirm alert, otherwise nothing happens
      if (frm.elements[i].checked)
      return confirm('Are you sure you want to delete your selection(s)?')
    }
  }
}
-->
</script>

    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 700px; height: 25px">
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2; text-align: center;">
                <strong><span style="font-size: 16px; color: #ffffff;">Mail Inbox</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px">
            </td>
            <td style="border-right: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; text-align: center; border-top-width: 1px; border-top-color: #000000;" valign="top">
<asp:GridView ID="GridView1" runat="server" DataKeyNames="Name" AutoGenerateColumns="False" DataSourceID="sql"  CellPadding="4" ForeColor="#333333" GridLines="None" Width="700px" BackImageUrl="~/images/5-t1.gif">
            <Columns> <asp:BoundField DataField="userId" HeaderText="UserId" InsertVisible="False"  />
                <asp:BoundField DataField="Name" HeaderText="Name" InsertVisible="False"  />
                <asp:BoundField DataField="Subject" HeaderText="Subject"  />
                               
                <asp:HyperLinkField HeaderText="Message"  Text="View Message" DataNavigateUrlFields="Name" NavigateUrl="admindetailsmail.aspx" DataNavigateUrlFormatString="admindetailsmail.aspx?n={0}" />
                <asp:BoundField DataField="DateTime" HeaderText="Date/Time"  />
                <asp:TemplateField HeaderText="Check">
                    <ItemTemplate>
                        <asp:Label ID="EmpID" Visible="false" Text='<%# DataBinder.Eval (Container.DataItem, "Name") %>' runat="server" />
                        <asp:CheckBox ID="deleteRec" OnClick="return check_uncheck(this);" runat="server" />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <asp:CheckBox ID="CheckAll" Text="All Select" runat="server" OnClick="return check_uncheck(this);"/>
                    </HeaderTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField  Text="Reply" DataNavigateUrlFields="Name" NavigateUrl="adminsendmail.aspx" DataNavigateUrlFormatString="adminsendmail.aspx?n={0}" />
            </Columns>
    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EDF0FD" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />    
    <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" BorderColor="RosyBrown" BorderStyle="Solid" BorderWidth="2px" />
    <AlternatingRowStyle BackColor="White" />
            
        </asp:GridView>
            </td>
            <td style="width: 50px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="width: 700px; height: 35px; text-align: center; border-top-width: 1px; border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px; border-bottom-color: #000000; border-top-color: #000000; border-right-width: 1px; border-right-color: #000000;">
    <asp:Button ID="Button1" runat="server" OnClientClick="return confirmMsg(this.form)" Text="Delete" OnClick="Button1_Click" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="90px" Font-Bold="True" ForeColor="White" />&nbsp;
                <asp:Button ID="Button2" runat="server" BackColor="#2881A2" BorderColor="Black" BorderStyle="Solid"
                    BorderWidth="1px" PostBackUrl="adminSendMail.aspx" Text="Send Mail" Width="90px" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
    </table>
    <br />
<asp:SqlDataSource ID=sql runat=server SelectCommand= "select * from  MailMst " ConnectionString="<%$ConnectionStrings:dsn %>">



</asp:SqlDataSource>

</asp:Content>

