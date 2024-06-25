<%@ Page Language="C#" MasterPageFile="MasterPage.master" 
    ValidateRequest="false" AutoEventWireup="true" CodeFile="AddProductDetails.aspx.cs"
    Inherits="admin_AddProductDetails" Title="Add Product" %>

<%@ Register Assembly="RichTextEditor" Namespace="AjaxControls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<style type="text/css">
    .rr
    {
        display:none !important;
    }
</style>
    <script type="text/javascript">

        function doRteAction() {

            //H1 is the ASP HiddenField Control
            var elemo = document.getElementById("<%=H1.ClientID%>");
            elemo.value = richeditor.toHtmlString();

        }

    </script>
    <script type="text/javascript">

        function doAction() {

            //H1 is the ASP HiddenField Control

            var elem = document.getElementById("<%=H1.ClientID%>");

            elem.value = richeditor.toHtmlString();

        }

    </script>
    <asp:Panel ID="Panel1" runat="server">
        <div id="title" class="b2">
            <h2>
                Add Product</h2>
            <!-- TitleActions -->
            <!-- /TitleActions -->
        </div>
        <%-- <asp:Panel ID="Panel1" runat="server">--%>
        <table style="width: 100%;">
            <tr>
                <td style="width: 15%;">
                    Product Category
                </td>
                <td style="width: 85%;">
                    <asp:DropDownList ID="ddlcategory" runat="server" Width="250px" 
                        onselectedindexchanged="ddlcategory_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <span style="font-size: 10pt; font-family: Arial">Product Name:</span>
                </td>
                <td style="width: 85%;">
                   <%-- <asp:TextBox ID="txtProduct" runat="server" Width="250px"></asp:TextBox>&nbsp;&nbsp;&nbsp;--%>
                    <asp:DropDownList ID="DropDownList1" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Upload Photo :
                </td>
                <td>
                    <asp:FileUpload ID="imgUpload" runat="server" Width="250px" />
                </td>
            </tr>
             <tr>
                <td>
                </td>
                <td>
                    <asp:Image ID="Image1" runat="server"  Width="50px" Height="50px" />   
                </td>
            </tr>
            <tr>

           
                <td>
                    Add Description :
                </td>
                <td>
                    <cc1:RichTextEditor ID="Rte1" runat="server" Theme="Blue" />
                    <asp:HiddenField ID="H1" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="btnInsert" runat="server" OnClick="btnInsert_Click" 
                        OnClientClick="javascript:doRteAction();" Text="Submit" />
                </td>
            </tr>
        </table>
       <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtProduct"
            ErrorMessage="Please enter product name!" Display="None" ValidationGroup="ap"></asp:RequiredFieldValidator>--%>
        <br />
        <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="ap" Width="222px" />
            <table style="width: 100%;">
            <tr>
                <td class="style21" align="left">
                    &nbsp;&nbsp;
                </td>
                <td class="style50" align="left">
                    By Product Name
                </td>
                <td class="style48" align="left">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                </td>
                <td class="style51">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="64px" OnClick="btnSearch_Click"
                        Style="margin-left: 0px" />
                </td>
                <td class="style49">
                    &nbsp;
                </td>
                <td class="style39">
                    <asp:DropDownList ID="ddSearch" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddSearch_SelectedIndexChanged">
                        <asp:ListItem Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">InActive</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style52">
                    <asp:Button ID="btnShow" runat="server" Text="Show All" Width="67px" OnClick="btnShow_Click" />
                </td>
                <td class="style33">
                    Page Size:<asp:DropDownList ID="ddPageSize" runat="server" OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged"
                        Style="margin-left: 0px" Width="44px" AutoPostBack="True">
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                        <asp:ListItem>100</asp:ListItem>
                        <asp:ListItem>All</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style33">
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="23px" Visible="False" />
                </td>
                <td class="style34">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="Images/excel.gif" 
                        OnClick="imgbtnExcel_Click" style="width: 24px" Visible="False" />
                </td>
                <td class="style35">
                    <asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" 
                        OnClick="imgbtnPdf_Click" Visible="False" />
                </td>
            </tr>
        </table><%--DataKeyNames="pid"--%>


         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="pid,ImageUrl"
                        EmptyDataText="record not found." OnRowDataBound="GridView1_RowDataBound"
                        OnRowCommand="GridView1_RowCommand" AllowPaging="True"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        PageSize="5" Width="858px" CssClass="mygrd" 
                       >

       <%-- <asp:GridView ID="GridView1" runat="server"
         AutoGenerateColumns="False" DataKeyNames="pid" 
            EmptyDataText="record not found." 
            OnRowDataBound="GridView1_RowDataBound" 
            OnRowCommand="GridView1_RowCommand"
            AllowPaging="True" 
            OnPageIndexChanging="GridView1_PageIndexChanging" 
            
            PageSize="10"
            CssClass="mygrd">--%>
            <Columns>
                <asp:BoundField HeaderText="S.No" DataField="pid"></asp:BoundField>
                <asp:BoundField HeaderText="Pruduct Category" DataField="CName"></asp:BoundField>
                <asp:BoundField HeaderText="Product Name" DataField="Pnane"></asp:BoundField>
                
                <asp:TemplateField HeaderText="Product Image">
                    <ItemTemplate>
                      <asp:ImageButton ID="imgStatus1" runat="server" Width="120px" Height="75px"  ImageUrl='<%# Eval("ImageUrl","~/ProductImage/{0}") %>' /> 
          
                        <%--<img height="20" width="20" alt='<%#Eval("ImageUrl") %>' src='../ProductImages/<%#Eval("ImageUrl") %>' />--%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField Visible="false" ControlStyle-CssClass="rr" HeaderStyle-CssClass="rr"  HeaderText="Description" DataField="imagedesc"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="imgStatus" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnStatus" CommandArgument='<%#Eval("pid") %>'
                            runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnEdit" Text="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="EditProduct" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
</asp:Content>
