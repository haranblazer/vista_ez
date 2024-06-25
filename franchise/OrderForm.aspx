<%@ Page Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true"
    CodeFile="OrderForm.aspx.cs" Inherits="d2000admin_BillingFrom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
<%--    <script src="js/jquery-1.4.2.js" type="text/javascript"></script>
 <link rel="stylesheet" href="css/jquery.autocomplete.css" type="text/css" />  
 <script type="text/javascript" src="js/jquery.autocomplete.js"></script>--%>
    <script type="text/javascript">
   $.noconflit();
</script>
    <link href="css/BillPrint.css" rel="stylesheet" type="text/css" media="projection, print" />  
    <style>
        .rrr
        {
            display: none;
        }
        .style1
        {
            height: 19px;
        }
        li.ac_even.ac_over {   
    list-style: none;
    color: #fff;
    padding: 2px;
}
 li.ac_even.ac_over:hover
{background:#b52821;
 color:#fff;
    }
li.ac_odd.ac_over:hover
{background:#52821;color:#fff;
    }
.ac_results li {
    margin: 0px;
     background: #C1C1C1b;
    padding: 2px 5px;
    cursor: default;
    display: block;
    /* width: 100%; */
    font: menu;
    font-size: 12px;
    line-height: 16px;
    overflow: hidden;
    color:#000;
}
</style>
  


                                      <script type="text/javascript">
                                          debugger;
                                          Sys.Application.add_load(function () {
                                              $(document).ready(function () {
                                                  var data = document.getElementById("<%=divProduct.ClientID%>").innerHTML.split(",");
                                                  $('#<%=GridView1.ClientID %> tr:gt(0)').not("tr:last").find("td:eq(1)").find("input:text").each(function () {
                                                      $(this).autocomplete(data);
                                                  });
                                                  //$("#txtProductNAme").autocomplete(data);
                                              });
                                          });

                                          function calculate(rowindex, txt) {
                                              //to get textbox value use val()
                                              var qnt = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text").val();
                                              qnt = isNaN(qnt) ? 0 : qnt;
                                              //to get cell value use text()
                                              var mrp = $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val();
                                              mrp = isNaN(mrp) ? 0 : mrp;
                                              var total = mrp * qnt;
                                              //to set into cell use text(value)
                                              $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(5)").text(total);

                                              //fqnt = parseFloat(fqnt) + parseFloat(qnt);
                                              var fqnt = 0;
                                              //tr:gt(0) skips the header and footer row while sum the value
                                              $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").find("td:eq(2)").each(function () {
                                                  var temp = $(this).find("input:text").val().trim();
                                                  fqnt += parseInt((temp == '' || temp == null || isNaN(parseInt(temp))) ? 0 : temp);
                                              });
                                              //set footer control sum() quantity value
                                              $('#<%=GridView1.ClientID%> tr:last').find("td:eq(2)").text(fqnt);

                                              //get footer control total value

                                              var ftotal = 0;
                                              //tr:gt(0) skips the header and footer row while sum the value
                                              $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").find("td:eq(5)").each(function () {
                                                  ftotal += isNaN(parseFloat($(this).text())) ? 0 : parseFloat($(this).text().trim());
                                              });
                                              //set footer control total value
                                              $('#<%=GridView1.ClientID%> tr:last').find("td:eq(5)").text(ftotal.toFixed(2));


                                          }

                                          function productNotExists(rowindex) {
                                              $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text").val('0');
                                              $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val('0');
                                              $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text").val('0');
                                              calculate(rowindex, $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(2)").find("input:text"));
                                          }

                                          function ShowMRP(rowindex, txt) {

                                              var isExists = 0;
                                              if (txt.value == '') {
                                                 // productNotExists(rowindex);
                                              }
                                              else {
                                                  $('#tblMRP tr').each(function () {
                                                      if ($(this).find("td:first").text() == txt.value) {

                                                          //set MRP
                                                          $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(3)").find("input:text").val($(this).find("td:eq(1)").text());
                                                          //set BV Amount
                                                          $('#<%=GridView1.ClientID%> tr:nth-child(' + rowindex + ')').find("td:eq(4)").find("input:text").val($(this).find("td:last").text());
                                                          isExists = 1;
                                                      }
                                                  });
                                                  if (isExists == 0) {
                                                      //user has entered some value for the product but not matched
                                                      productNotExists(rowindex);
                                                      $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("span").text('Product not exists');
                                                  }
                                                  else {
                                                      $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("span").text('');
                                                  }
                                              }
                                              //sum MRP total
                                              var MrpTotal = 0;
                                              var BVTotal = 0;


                                              $('#<%=GridView1.ClientID%> tr:gt(0)').not("tr:last").each(function () {
                                                  var strVal = $(this).find("td:eq(3)").find("input:text").val();
                                                  var strBV = $(this).find("td:eq(4)").find("input:text").val();
                                                  MrpTotal += parseFloat(strVal == '' || strVal == null ? "0" : strVal);
                                                  BVTotal += parseFloat(strBV == '' || strBV == null ? "0" : strBV);
                                                  if ($(this).index() != (rowindex - 1) && txt.value != '' && isExists == 1 && $(this).find("td:eq(1)").find("input:text").val() == txt.value) {
                                                      $('#<%=GridView1.ClientID %> tr:nth-child(' + rowindex + ')').find("td:eq(1)").find("span").text('Already added this product');

                                                  }
                                                  else
                                                      $('#<%=GridView1.ClientID %> tr:nth-child(' + (rowindex + 1) + ')').find("td:eq(1)").find("span").text('');
                                              });
                                              //Round value upto 2 decimal places and set to text box
                                              $('#<%=GridView1.ClientID %> tr:last').find("td:eq(3)").text(MrpTotal.toFixed(2));
                                              $('#<%=GridView1.ClientID %> tr:last').find("td:eq(4)").text(BVTotal.toFixed(2));

                                          }

                
                                        </script>
                                


   <div class="CenterArea">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="upnl" runat="server">
        <ContentTemplate>


            <h1>
               Generate Purchase Order Form</h1>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnl" runat="server">
                <ProgressTemplate>
                    <center>
                        Wait....
                        <br />
                        <img alt="Wait...." style="position: absolute; padding-left: 150px; padding-top: 200px;"
                            src="images/progress.gif" />
                    </center>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <div class="row">
         <div class="form-group">
                                    <label for="MainContent_txtPassword" class="col-md-2 control-label">Delivery Address :</label>
                                    <div class="col-md-3">
                        
                   
                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" runat="server" Height="100px" CssClass="form-control"></asp:TextBox>
                   </div></div>
                   </div>
            <br />
         
            <div class="table-responsive">
                <table class="table table-striped" cellspacing="0" rules="all">
                    <tbody>
                    <tr>
                    <td>
          
                       
                        <div id="divProduct" style="display: none;" runat="server">
                        </div>
                                  
                        <div id="divMRP" style="display: none;" runat="server">
                        </div>
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView Width="100%" ID="GridView1" DataKeyNames="id" CssClass="mygrd" ShowFooter="true"
                            AutoGenerateColumns="False" runat="server" OnRowDeleting="GridView1_RowDeleting"
                            OnRowDataBound="GridView1_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="SrNo.">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button ID="btnNewRow" ValidationGroup="a" OnClick="btnAddMore_Click" runat="server"
                                            CssClass="button" Text="Add More" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" Text='<%#Eval("pname") %>' ID="txtProductNAme" CausesValidation="True"
                                            ValidationGroup="ad"></asp:TextBox>
                                        <span style="color: Red;"></span>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        Total:
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:RegularExpressionValidator ValidationExpression="^[0-9]{1,5}$" ID="RegularExpressionValidator1"
                                            SetFocusOnError="true" Display="Dynamic" ValidationGroup="a" ControlToValidate="txtQuantity"
                                            runat="server" ErrorMessage="Invalid Quantity."></asp:RegularExpressionValidator>
                                        <asp:TextBox ID="txtQuantity" Text='<%#Eval("quantity") %>' Width="50" MaxLength="5"
                                            Style="text-align: right" ValidationGroup="a" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblQtotal" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Price" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtMRP" Text='<%#Eval("MRP") %>' Style="text-align: right" BackColor="Transparent"
                                            Enabled="false" BorderStyle="None" ForeColor="Black" Font-Bold="true" runat="server"></asp:TextBox>
                                
                                
                                
                                
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblMRPtotal" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BV Amout" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtBV" Text='<%#Eval("BV") %>' Style="text-align: right" BackColor="Transparent"
                                            Enabled="false" BorderStyle="None" ForeColor="Black" Font-Bold="true" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblBVtotal" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                    FooterStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%#Eval("total") %>

                                   

                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotal" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" ValidationGroup="a" OnClientClick="return confirm('Are you sure to delete the item.');"
                                            CommandName="Delete" CommandArgument='<%#Container.DisplayIndex%>' runat="server"
                                            ImageUrl="../Admin/Images/Delete.jpg" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td style="margin-left: 88%;">
                    <br />
                        <asp:Button ID="btnGenerateBill" runat="server" CssClass="btn btn-success ladda-button" OnClick="btnGenerateBill_Click"
                            Text="Order Now" ValidationGroup="g" style="margin-left: 92%;" />
                    </td>
                </tr>
                </tbody>
            </table>
            </div>
            
           
        </ContentTemplate>
    </asp:UpdatePanel>
    </div>
</asp:Content>
