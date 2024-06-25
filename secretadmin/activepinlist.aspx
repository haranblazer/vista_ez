<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="activepinlist.aspx.cs" Inherits="admin_activepinlist" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/PagingGridView.css" rel="stylesheet" type="text/css" />
    <%--start date picker link--%>
    <link rel="Stylesheet" type="text/css" href="../datepick/jquery.datepick.css"></link>

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../datepick/jquery.datepick.js"></script>

    <%--end date picker link--%>

    <script type="text/javascript">
        $(function() {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });   
    </script>

    <div id="title" class="b2">
        <h2>
            Alloted Pin List</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <table style="width: 100%; text-align: left;">
        <tr>
            <td>
                From Date :<asp:TextBox ID="txtFromDate" runat="server" Width="72px"></asp:TextBox>&nbsp;&nbsp;To
                Date:<asp:TextBox ID="txtToDate" runat="server" Width="72px"></asp:TextBox>&nbsp;&nbsp;
                <asp:Button ID="Button1" OnClick="Button1_Click" runat="server" Text="Show " ValidationGroup="Show"
                    CssClass="btn" Width="56px"></asp:Button>
                &nbsp;&nbsp;<span>Pin Type:</span><asp:DropDownList ID="ddlPinType" runat="server"
                    AutoPostBack="True" OnSelectedIndexChanged="ddlPinType_SelectedIndexChanged"
                    Height="23px" Width="93px">
                    <asp:ListItem Value="0">All</asp:ListItem>
                    <asp:ListItem Value="1">Registration</asp:ListItem>
                    <asp:ListItem Value="2">Upgradation</asp:ListItem>
                </asp:DropDownList>
                Search Member:
                <asp:TextBox ID="txtSearch" runat="server" Width="100px"></asp:TextBox>
                &nbsp;<asp:Button ID="btSearch" runat="server" Text="Search" ValidationGroup="s"
                    OnClick="btSearch_Click" CssClass="btn" Width="54px" />
                &nbsp;Page Size:<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" Width="44px">
                    <asp:ListItem Value="25">25</asp:ListItem>
                    <asp:ListItem Value="50">50</asp:ListItem>
                    <asp:ListItem Value="100">100</asp:ListItem>
                    <asp:ListItem>All</asp:ListItem>
                </asp:DropDownList>
                &nbsp;
                <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                    OnClick="ibtnExcelExport_Click" />
                &nbsp;<asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg"
                    OnClick="ibtnWordExport_Click" />
                &nbsp;<asp:ImageButton ID="ibtnPDFExport" runat="server" ImageUrl="images/pdf.gif"
                    OnClick="ibtnPDFExport_Click" />
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <cc1:PagingGridView AllowPaging="true" EmptyDataText="No Pins Alloted !" DataKeyNames="tranid,AppMstid"
                    AutoGenerateColumns="false" CssClass="mygrd" PageSize="50" OnPageIndexChanging="gvActivePinList_PageIndexChanging"
                    ID="gvActivePinList" OnRowEditing="gvActivePinList_RowEditing" runat="server"
                    CellPadding="4" Width="100%" BorderStyle="Solid" BorderWidth="1px" Font-Size="8pt"
                    BorderColor="#336699" GridLines="Horizontal">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="User Id" DataField="AppMstregno" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Name" DataField="AppMstFName" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Mobile No." DataField="AppMstMobile" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />

                             <asp:BoundField HeaderText="Amount" DataField="amount" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="No Of Pins Alloted" DataField="NoOfPins" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                             <asp:BoundField HeaderText="Pin Type" DataField="pintype" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="allotmentdate" HeaderText="Allotment Date" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:CommandField ShowEditButton="True" EditText="Show Pins" />
                    </Columns>
                </cc1:PagingGridView>
            </td>
        </tr>
        <tr>
            <td class="style2">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                    ControlToValidate="txtFromDate" ErrorMessage="Please enter date dd/mm/yy format!"
                    Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" Display="none"
                    ValidationGroup="Show"></asp:RegularExpressionValidator><asp:RegularExpressionValidator
                        ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtToDate"
                        ErrorMessage="Please enter date dd/mm/yy format!" Font-Bold="False" ForeColor="#C00000"
                        ValidationExpression="^[0-9/]*" Display="none" ValidationGroup="Show"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSearch"
                    Display="None" ErrorMessage="Please Enter Member Id!" ForeColor="#C00000" ValidationGroup="s"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtSearch"
                    Display="None" ErrorMessage="Only Alpha Numeric Value Is Allowed!" ForeColor="#C00000"
                    ValidationGroup="s" ValidationExpression="^[a-zA-Z0-9]*"></asp:RegularExpressionValidator>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="s"
                    ShowMessageBox="true" ShowSummary="false" />
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="Show"
                    ShowMessageBox="true" ShowSummary="false" />
            </td>
        </tr>
    </table>

    <script type="text/javascript">
        $(document).ready(

     function() {

         $('.7').show();
     }
    );
    </script>

</asp:Content>
