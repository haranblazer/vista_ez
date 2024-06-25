<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="true" CodeFile="unpaidtopaid.aspx.cs" Inherits="admin_unpaidtopaid" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title> <style type="text/css">
    
    body,td,th{
    font-family: Arial;
    font-size: 12px;
    }
    
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
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
      else if (ValId.indexOf('SelectChk') !=  - 1)
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
    if (frm.elements[i].name.indexOf("SelectChk") !=  - 1)
    {
      // If any are checked then confirm alert, otherwise nothing happens
      if (frm.elements[i].checked)
      return confirm('Are you sure you want to Close this selection(s) for growth payout?')
    }
  }
}
-->
</script>

    <table border="0" cellpadding="0" align="center"cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 700px; height: 25px">
                &nbsp;</td>
            <td style="width: 50px; height: 25px">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Select Unpaid To paid</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 700px; border-top-color: #000000;
                height: 35px; text-align: center">
                &nbsp;
                <asp:Button ID="Button2" runat="server"  Text="Submit" OnClick="Button2_Click1" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White"/></td>
            <td style="width: 50px; height: 34px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px;">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 700px; border-top-color: #000000; text-align: center">
                <asp:Label ID="Label4" runat="server" Width="369px"></asp:Label>&nbsp;</td>
            <td style="width: 50px;">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid; width: 700px; border-top-color: #000000;
                height: 35px; text-align: center; border-bottom: #000000 1px solid;">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="Red" Width="140px"></asp:Label><br />
                                  <asp:Panel ID="Panel1" runat="server">

                <asp:GridView ID="GridView1" runat="server" DataKeyNames="AppMstRegNo" AutoGenerateColumns="false" CellPadding="1" ForeColor="#333333" GridLines="None" Width="700px"  BorderColor="Transparent" AllowPaging="true" PageSize="25" OnPageIndexChanging="GridView1_PageIndexChanging1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnSelectedIndexChanging="GridView1_SelectedIndexChanging" >
                                                        
                  <Columns>
                  <asp:TemplateField>
                         <ItemTemplate>
                              <asp:Label ID="EmpID" Visible="false" Text='<%# DataBinder.Eval (Container.DataItem, "AppMstRegNo") %>' runat="server" />
                              <asp:DropDownList ID="ddl" Width="50" DataTextField="productname" DataSource='<%# ddlitem()%>' runat="server"></asp:DropDownList>
                         </ItemTemplate>
                         <HeaderTemplate>
                              Select Product
                         </HeaderTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="AppMstRegNo" HeaderText="UserId" />
                  <asp:BoundField DataField="AppMstFName" HeaderText="Name" />
                 
                  <asp:BoundField DataField="SponsorID" HeaderText="Sponsor Id" />
                  <asp:BoundField DataField="ParentId" HeaderText="Parent Id" />
                  <asp:BoundField DataField="JoinFor" HeaderText="Join For" />
                   <asp:ButtonField  Text="Upgrade" ButtonType="Button"/>
                  
                  </Columns>
                  <RowStyle BackColor="#EDF0FD" />
                    <PagerStyle BackColor="#69B5D1" ForeColor="Black" />
                    <HeaderStyle BackColor="#69B5D1" />
                    <AlternatingRowStyle BackColor="White" />
                    
                </asp:GridView>
                </asp:Panel>
            </td>
            <td style="width: 50px; height: 34px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-bottom-width: 1px;
                border-bottom-color: #000000; width: 700px; border-top-color: #000000;
                height: 35px; text-align: center; border-left-width: 1px; border-left-color: #000000; border-right-width: 1px; border-right-color: #000000;">
            </td>
            <td style="width: 50px; height: 34px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-top-color: #000000; border-bottom: #000000 1px solid; height: 35px;
                text-align: center">
               </td>
            <td style="width: 50px; height: 34px">
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
