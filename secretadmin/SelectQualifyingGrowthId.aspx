<%@ Page Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="SelectQualifyingGrowthId.aspx.cs" Inherits="admin_SelectQualifyingGrowthId" Title="Select Growth List : Admin Control Panel" %>
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

    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="width: 700px; height: 25px">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        Style="left: -150px; top: -56px" />
            </td>
            <td style="width: 50px; height: 25px">
    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/printer.gif" OnClick="ImageButton1_Click" ToolTip="Print" />

            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 25px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Select Growth List</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 700px; border-top-color: #000000;
                height: 25px; text-align: center; background-color: #EDF0FD;">
                <strong><span style="font-family: Verdana">Select&nbsp; Elegible User Ids from List</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid; width: 700px; border-top-color: #000000;
                height: 35px; text-align: center; border-bottom: #000000 1px solid; background-color: #EDF0FD;">
                Enter Closing No. :
                <asp:TextBox
                    ID="TextBox1" runat="server" Style="position: relative" Width="103px"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Please Enter Closing No.">**</asp:RequiredFieldValidator><asp:Label ID="Label2" runat="server" Width="138px" Font-Bold="True"></asp:Label></td>
            <td style="width: 50px; height: 34px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 700px; border-top-color: #000000;
                height: 35px; text-align: center">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
            <td style="width: 50px; height: 34px">
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
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-bottom-width: 1px;
                border-bottom-color: #000000; border-left: #000000 1px solid; width: 700px; border-top-color: #000000;
                height: 35px; text-align: center">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Insert Blank Id" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" /><asp:Label ID="Label3" runat="server" Width="58px"></asp:Label></td>
            <td style="width: 50px; height: 34px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid; width: 700px; border-top-color: #000000;
                height: 35px; text-align: center; border-bottom: #000000 1px solid;">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="Red" Width="140px"></asp:Label><br />
                                  <asp:Panel ID="Panel1" runat="server">

                <asp:GridView ID="GridView1" runat="server" DataKeyNames="AppMstRegNo" AutoGenerateColumns="false" CellPadding="1" ForeColor="#333333" GridLines="None" Width="700px"  BorderColor="Transparent" AllowPaging="true" PageSize="1000" OnPageIndexChanging="GridView1_PageIndexChanging1" >
                                                        
                  <Columns>
                  <asp:TemplateField>
                         <ItemTemplate>
                              <asp:Label ID="EmpID" Visible="false" Text='<%# DataBinder.Eval (Container.DataItem, "AppMstRegNo") %>' runat="server" />
                              <asp:CheckBox id="SelectChk"  runat="server" />
                         </ItemTemplate>
                         <HeaderTemplate>
                              <asp:CheckBox ID="CheckAll" Text="Check All" runat="server" OnClick="return check_uncheck(this);"/>
                         </HeaderTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="AppMstRegNo" HeaderText="UserId" />
                  <asp:BoundField DataField="AppMstFName" HeaderText="Name" />
                  <asp:BoundField DataField="closing" HeaderText="Closing No" />
                  <asp:BoundField DataField="Sponsorid" HeaderText="Sponsor Id" />
                  <asp:BoundField DataField="JoinFor" HeaderText="Join For" />
                   
                  
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
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-bottom: #000000 1px solid; height: 35px; background-color: #2881A2;
                text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff">Do Other Task</span></strong></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 34px">
            </td>
            <td style="border-top-width: 1px; border-right: #000000 1px solid; border-left: #000000 1px solid;
                width: 700px; border-top-color: #000000; border-bottom: #000000 1px solid; height: 35px;
                text-align: center">
                <a href="BulkIdSubmission.aspx">Bulk ID Submission</a>&nbsp; l&nbsp; <a href="SearchGrowthList.aspx">
                    Search Closed User Accounts</a>&nbsp; l&nbsp; <a href="DeselectGrowthList.aspx">Deselect
                        User From Growth List</a>&nbsp; l&nbsp; <a href="CalculateGrowthIncome.aspx">Calculate
                            Growth Income</a></td>
            <td style="width: 50px; height: 34px">
            </td>
        </tr>
    </table>
    
</asp:Content>

