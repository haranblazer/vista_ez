<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddInventory.aspx.cs" Inherits="admin_AddInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/jquery-1.4.2.js" type="text/javascript"></script>
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />

    <script type="text/javascript">


        $(document).ready(function () {
            var dataUserID = document.getElementById("<%=divProduct.ClientID%>").innerHTML.split(",");
            $('#<%=txtpname.ClientID %>').autocomplete(dataUserID);
        });
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
        function enterNumeric(txt) {
            var sText = txt.value
            validText = sText.substring(0, sText.length - 1)
            var ValidChars = "0123456789";
            var Char;
            for (i = 0; i < sText.length; i++) {
                Char = sText.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    txt.value = validText
                }
            }
        }
        function calculate(qnt) {
            if (qnt.value != "0")
                document.getElementById('<%=txtstock.ClientID%>').value = parseInt(document.getElementById('<%=txtstock.ClientID%>').value) + parseInt(qnt.value);
            else if (qnt.value == "0")
                ShowMRP();
            else
                alert("Please Enter Quantity !")
        }
        function ShowMRP() {
            var isExists = 0;
            var txtid = document.getElementById('<%=txtpname.ClientID%>').value;
            $('#tblMRP tr').each(function () {
                if ($(this).find("td:first").text() == txtid) {
                    document.getElementById('<%=txtstock.ClientID%>').value = (parseFloat($(this).find("td:eq(1)").text()));
                    document.getElementById('<%=txtpCode.ClientID%>').value = (parseFloat($(this).find("td:eq(2)").text()));
                    isExists = 1;
                }
            });
            if (isExists == 0) {
                document.getElementById('<%=txtpname.ClientID%>').value = ''
                document.getElementById('<%=txtstock.ClientID%>').value = ''
                document.getElementById('<%=txtpCode.ClientID%>').value = ''
                document.getElementById('<%=txtstock.ClientID%>').value = ''
                //alert("Product not  exists !");
            }
        }        
    </script>

    <h2>Add Inventor</h2><br />

     <div>
        <label for="MainContent_txtPassword" class="col-sm-2 control-label">
            Product Code<span style="color: #FF0000">*</span></label>
        <div class="col-sm-1">
            <asp:TextBox ID="txtpCode" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
     <div>
        <label for="MainContent_txtPassword" class="col-sm-2 control-label">
             Enter Product name<span style="color: #FF0000">*</span></label>
        <div class="col-sm-3">
             <asp:TextBox ID="txtpname" onblur="ShowMRP()" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
     <div>
        <label for="MainContent_txtPassword" class="col-sm-2 control-label">
               Quantity<span style="color: #FF3300">*</span></label>
        <div class="col-sm-3">
             <asp:TextBox ID="txtqnt" onkeyup="javascript:return enterNumeric(this);" onchange="calculate(this)"
                        runat="server"  CssClass="form-control"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
      <div>
        <label for="MainContent_txtPassword" class="col-sm-2 control-label">
               Availble in stock</label>
        <div class="col-sm-1">
            <asp:TextBox ID="txtstock" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
        </div>
    </div>
    <div class="clearfix">
    </div><br />
    <div>
     
        <div class="col-sm-2">
            <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" CssClass="btn btn-success" />
        </div>
    </div>
        <%----<table >
            <tr>
                <%--<td>
                    Product Code<span style="color: #FF0000">*</span><br />
                    <asp:TextBox ID="txtpCode" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                </td>--%>
               <%-- <td >
                    Enter Product name<span style="color: #FF0000">*</span><br />
                    <asp:TextBox ID="txtpname" onblur="ShowMRP()" runat="server" Width="400px"  CssClass="form-control"></asp:TextBox>
                </td>--%>
                <%--<td>
                    Quantity<span style="color: #FF3300">*</span><br />
                    <asp:TextBox ID="txtqnt" onkeyup="javascript:return enterNumeric(this);" onchange="calculate(this)"
                        runat="server"  CssClass="form-control"></asp:TextBox>
                </td>--%>
                <%--<td>
                    Availble in stock<br />
                    <asp:TextBox ID="txtstock" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                </td>--%>
                </tr>

                <tr>
         
                <%--<td>
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" CssClass="btn btn-success" />
                </td>
            </tr>
        </table>---%>

    <div>
  <%--      <asp:GridView ID="Grdreport" CssClass="mygrd" AutoGenerateColumns="false" 
            runat="server" onrowcommand="Grdreport_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <b>
                            <%#Container.DataItemIndex+1%>
                        </b>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Code">
                    <ItemTemplate>
                        <%#Eval("productid")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <%#Eval("pname")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total In">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbltotin" CommandName="In" OnClientClick = "SetTarget();" CommandArgument='<%# Eval("productid")%>'
                            Text='<%# Eval("In")%>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Out">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbltotout" CommandName="out" OnClientClick = "SetTarget();" CommandArgument='<%# Eval("productid")%>'
                            Text='<%# Eval("out")%>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Avail. In Stock">
                    <ItemTemplate>
                        <%#Eval("qty")%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>--%>
    </div>
    <div id="divProduct" style="display: none;" runat="server">
    </div>
    <div id="divMRP" runat="server" style="display: none;">
    </div>
</asp:Content>
