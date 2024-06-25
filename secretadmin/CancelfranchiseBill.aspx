<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="CancelfranchiseBill.aspx.cs" Inherits="admin_CancelfranchiseBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <script src="../d2000admin/js/jquery-1.4.2.js" type="text/javascript"></script>
     
    <link rel="Stylesheet" type="text/css" href="../datepick/jquery.datepick.css"></link>
  <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
  <%--  <script type="text/javascript" src="../datepick/jquery.datepick.js"></script>--%>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>


     <%-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>--%>
<script type="text/javascript">
    $("[src*=plus]").live("click", function () {
        $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
        $(this).attr("src", "../admin/images/minus.png");
    });
    $("[src*=minus]").live("click", function () {
        $(this).attr("src", "../admin/images/plus.ico");
        $(this).closest("tr").next().remove();
    });
</script>

    <%--<script>
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(11)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(11)").each(function () {
                        $(this).find('a').css("display", "block");
                        $(this).find('span').css("display", "none");
                    });
                    //show specific span tag
                    $(this).parent().find('span').css("display", "block");
                    $(this).css("display", "none");
                });
            });
        });
 
    </script>--%>
<h2>List Of Stock Transfer</h2>
    <table style="width: 100%">
      
        <tr>
            <td>
                Bill Date From:<asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox>
            </td>
            <td>
                To:
                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                &nbsp; <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                    Text="Submit" />
                Invoice&nbsp;
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                &nbsp;<asp:Button ID="btnSearch" runat="server"  CssClass="btn" Text="Search" 
                    onclick="btnSearch_Click"  />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView AllowPaging="true" ID="GridView1" runat="server"  
                    CssClass="mygrd" AutoGenerateColumns="false"
                    PageSize="50" Width="100%" 
                    OnPageIndexChanging="GridView1_PageIndexChanging" 
                    onrowdatabound="GridView1_RowDataBound">

                    <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Invoice No." DataField="billno" />
                 

                         <asp:BoundField HeaderText="Buyer ID" DataField="Buyerid" />

                    


                         <asp:BoundField HeaderText="SellerID" DataField="Sellerid" />               

                   
                       
                        <asp:BoundField HeaderText="Doe" DataField="canceldate" />


                        <asp:TemplateField>
            <ItemTemplate>
                <img alt = "" style="cursor: pointer" src="images/plus.ico" width="20" />
                <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass = "ChildGrid">
                        <Columns>
                            <asp:BoundField ItemStyle-Width="150px" DataField="productid" HeaderText="Product ID" />
                            <asp:BoundField ItemStyle-Width="150px" DataField="pname" HeaderText="Product Name" />
                            <asp:BoundField ItemStyle-Width="150px" DataField="quantity" HeaderText="Quantity" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </ItemTemplate>
        </asp:TemplateField>
                    
                     

                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>




</asp:Content>

