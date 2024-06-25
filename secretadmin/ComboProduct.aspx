<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="ComboProduct.aspx.cs" Inherits="secretadmin_ComboProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        function onlyNumber(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) {
                    return false;
                }
                return true;
            }
            catch (err) {
                alert(err.Description);
            }
        }
    </script>

    <h2 class="head"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Packed Product</h2>


    <div class="panel panel-default">
        <div class="clearfix"></div>
        <br />

        <div class="row">

            <div class="col-md-9">
            </div>
            <div class="col-md-2">
                <a href="ProductList.aspx" class="btn btn-link">Product List</a>
            </div>
            <div class="col-md-1">
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <div id="div_Product" runat="server" style="font-size: medium;"></div>
            </div>

            <div class="col-md-8">
                <asp:Button ID="btn_Search" runat="server" Text="Submit" CssClass="btn btn-success"
                    OnClick="btn_Search_Click" OnClientClick="return confirm('Are you sure you want to Add Combo?')" />
                <br />

                <div id="div_msg" runat="server"></div>

            </div>
            <div class="col-md-1">
            </div>
        </div>


        <div class="clearfix"></div>
        <hr />
        <div class="row">

            <div class="col-md-1"></div>
            <div class="col-md-10">
                <div class="table-responsive">
                    <asp:GridView ID="GridView2" EmptyDataText="Record not found." CssClass="table table-striped table-hover display dataTable nowrap cell-border"
                        runat="server" AutoGenerateColumns="False" AllowPaging="false">
                        <Columns>


                            <%-- <asp:TemplateField HeaderText="#" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Product Code" ItemStyle-Width="15%">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hnd_productid" runat="server" Value='<%# Eval("Productid") %>' />
                                    <%#Eval("ProductCode") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Product Name" ItemStyle-Width="45%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkProd" runat="server" Checked='<%#Eval("IsComboPack").ToString()=="1" ? true : false %>'
                                        Text='<%#Eval("ProductName")%>  ' Enabled='<%#Eval("Locked").ToString()=="0" ? true : false %>'
                                        CssClass='<%#Eval("Locked").ToString()=="0" ? "" : "disabled" %>'
                                        Style="padding: 2px; margin: 2px;"></asp:CheckBox>
                                    <%# Eval("IsComboPack").ToString() == "0" ? "<span class='dotGrey'></span>" : "<span class='dotGreen'></span>"%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQty" runat="server" Text='<%#Eval("Qty") %>' Enabled='<%#Eval("Locked").ToString()=="0" ? true : false %>'
                                        CssClass='<%#Eval("Locked").ToString()=="0" ? "form-control" : " form-control disabled" %>' MaxLength="3"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--  <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <%# Eval("IsComboPack").ToString() == "0" ? "<span class='dotGrey'></span>" : "<span class='dotGreen'></span>"%>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>
                    </asp:GridView>

                </div>
            </div>
            <div class="col-md-1"></div>

        </div>



    </div>
    <div class="clearfix">
    </div>
    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>
</asp:Content>
