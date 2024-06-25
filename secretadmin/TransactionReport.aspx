<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TransactionReport.aspx.cs" Inherits="Admin_TransactionReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div class="loader"></div>
 

    <link href="css/PagingGridView.css" rel="stylesheet" type="text/css" />

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
            <table id="Table1" width="100%" runat="server" border="0" cellpadding="0" cellspacing="0"
                style="background-color: #f3f3f3; border: 2px solid #f3f3f3">
                <tr id="tr1" runat="server">
                    <td id="td1" runat="server" colspan="2" style="height: 35px">
                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Enter Date" 
                            OnCheckedChanged="CheckBox2_CheckedChanged" />
                    </td>
                    <td  id="td2" runat="server" style="height: 35px">
                        From Date :<asp:TextBox ID="txtFromDate" runat="server" Width="72px"></asp:TextBox>&nbsp;&nbsp;To
                        Date:<asp:TextBox ID="txtToDate" runat="server" Width="72px"></asp:TextBox>&nbsp;&nbsp;
                       
                         <link rel="Stylesheet" type="text/css" href="../datepick/jquery.datepick.css"></link>

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../datepick/jquery.datepick.js"></script>

    <%--end date picker link--%>

    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });   
    </script>

                        <asp:Button ID="Button1" runat="server" Text="Show " CssClass="btn" Width="56px"
                            OnClick="Button1_Click"></asp:Button>
                    </td>


                </tr>
                <tr id="tr2" runat="server">
                    <td id="td3" runat="server" style=" height: 35px" colspan="2">
                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Enter Registration No" 
                            OnCheckedChanged="CheckBox1_CheckedChanged" />
                    </td>
                    <td id="td4" runat="server" colspan="2">
                        <table>
                            <tr>
                                <td>
                                <cc1:AutoCompleteExtender ServiceMethod="SearchCustomers"
    MinimumPrefixLength="2"
    CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
    TargetControlID="txtSearch"
    ID="AutoCompleteExtender1" runat="server" FirstRowSelected = "false">
</cc1:AutoCompleteExtender>

                                    <asp:TextBox ID="txtSearch" runat="server" Width="105px" TabIndex="4" OnTextChanged="txtSearch_TextChanged">
                                    </asp:TextBox>
                                </td>

                                <td>
         <asp:Button ID="Button4" runat="server" 
    onclick="Button4_Click" Text="Search" />
                                    
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="0">Member</asp:ListItem>
                                        <asp:ListItem Value="1">Associate</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPinType" runat="server" AutoPostBack="True" Visible="false"
                                        OnSelectedIndexChanged="ddlPinType_SelectedIndexChanged" Height="23px" Width="93px">
                                        <asp:ListItem Value="0">All</asp:ListItem>
                                        <asp:ListItem Value="1">Registration</asp:ListItem>
                                        <asp:ListItem Value="2">Upgradation</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                                        Width="44px">
                                        <asp:ListItem Value="25">25</asp:ListItem>
                                        <asp:ListItem Value="50">50</asp:ListItem>
                                        <asp:ListItem Value="100">100</asp:ListItem>
                                        <asp:ListItem>All</asp:ListItem>
                                    </asp:DropDownList>
                                </td>

                                
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="tr3" runat="server">
                    <td id="td5" runat="server" colspan="2" style="height: 35px">
                        <asp:CheckBox ID="CheckBox3" runat="server" Text="Select Transaction Type" 
                            OnCheckedChanged="CheckBox3_CheckedChanged" />
                    </td>
                    <td id="td6" runat="server" colspan="2" style="width: 50px; height: 35px">
                        <asp:DropDownList ID="DropDownList1" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="tr4" runat="server">
                    <td id="td7" runat="server" style="height: 35px" colspan="2">
                        <asp:CheckBox ID="CheckBox4" runat="server" Text="Enter Invoice No" 
                            OnCheckedChanged="CheckBox4_CheckedChanged" />
                    </td>
                    <td id="td8" runat="server" style="width: 50px; height: 35px" colspan="2">
                        <asp:TextBox ID="txtinvoiveno" runat="server" OnTextChanged="txtinvoiveno_TextChanged"></asp:TextBox>
                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Search" />
                    </td>
                </tr>
                <tr id="tr5" runat="server">
                    <td id="td9" runat="server" style="height: 35px" colspan="2">
                        <asp:CheckBox ID="CheckBox5" runat="server" Text="Select Product Type" 
                            OnCheckedChanged="CheckBox5_CheckedChanged" />
                    </td>
                    <td id="td10" runat="server" style="width: 50px; height: 35px" colspan="2">
                        <asp:DropDownList ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"
                            AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:GridView AllowPaging="true" EmptyDataText="No Data !" DataKeyNames="AppMstid"
                            AutoGenerateColumns="false" CssClass="mygrd" PageSize="50" OnPageIndexChanging="gvActivePinList_PageIndexChanging"
                            ID="gvActivePinList" runat="server" CellPadding="4" Width="100%" BorderStyle="Solid"
                            BorderWidth="1px" Font-Size="8pt" BorderColor="#336699" GridLines="Horizontal">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:BoundField HeaderText="Pin No" DataField="pinsrno" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />

                                     <asp:BoundField DataField="srno" HeaderText="Invoice ID" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />

                                <asp:BoundField HeaderText="User Id" DataField="AppMstregno" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField HeaderText="Name" DataField="AppMstFName" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField HeaderText="Mobile No." DataField="AppMstMobile" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />
                                <%--<asp:BoundField HeaderText="No Of Pins Alloted" DataField="NoOfPins" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />--%>
                               <%-- <asp:BoundField HeaderText="Pin Type" DataField="pintype" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />--%>

                                <asp:BoundField HeaderText="product" DataField="productname" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="allotmentdate" HeaderText="Allotment Date" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-HorizontalAlign="Left" />

                              <asp:BoundField DataField="usedby" HeaderText="Used By" ItemStyle-HorizontalAlign="Left"
                              HeaderStyle-HorizontalAlign="Left" />

                               <asp:BoundField DataField="activedate" HeaderText="Used Date" ItemStyle-HorizontalAlign="Left"
                              HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="remark" HeaderText="Remark" ItemStyle-HorizontalAlign="Left"
                              HeaderStyle-HorizontalAlign="Left" />
                               
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
       
</asp:Content>
