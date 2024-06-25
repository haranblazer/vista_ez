<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateScheme.aspx.cs" Inherits="admin_Pamentmst"
    MasterPageFile="MasterPage.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .dotGreen {
            height: 25px;
            width: 25px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 25px;
            width: 25px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>

    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>


    <script type="text/javascript">


        $JD(function () {

               <%-- var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
                $JD('#<%=txt_product.ClientID%>').autocomplete(Productcode);--%>

                $JD('#<%=txtStartDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
                $JD('#<%=txtExpDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

                ProductVisible();
            });


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


        function ProductVisible() {
            $('#<%=ddl_OfferOn.ClientID %>').removeAttr("disabled");
                $('#<%=ddl_OfferOn.ClientID %>').attr("enabled", "enabled");
                $('#<%=ddl_OfferOn.ClientID%>').val(0);

                if ($('#<%=ddlOfferType.ClientID%>').val() == '3') {
                    $('#<%=productdiv.ClientID%>').show();
                    $('#<%=txtCondition.ClientID %>').removeAttr("enabled");
                    $('#<%=txtItemQty.ClientID %>').removeAttr("enabled");
                    $('#<%=txt_MonthlyCondition.ClientID %>').removeAttr("enabled");
                    $('#<%=txt_Monthlyoffer.ClientID %>').removeAttr("enabled");

                    $('#<%=txt_MonthlyCondition.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txt_Monthlyoffer.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtCondition.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtItemQty.ClientID%>').attr("disabled", "disabled");
                }
                else if ($('#<%=ddlOfferType.ClientID%>').val() == '4') {
                    $('#<%=ddl_OfferOn.ClientID %>').removeAttr("enabled");
                    $('#<%=ddl_OfferOn.ClientID %>').attr("disabled", "disabled");
                    $('#<%=ddl_OfferOn.ClientID%>').val(3);

                    $('#<%=productdiv.ClientID%>').hide();
                    $('#<%=txtCondition.ClientID %>').removeAttr("disabled");
                    $('#<%=txtItemQty.ClientID %>').removeAttr("enabled");
                    $('#<%=txt_MonthlyCondition.ClientID %>').removeAttr("disabled");
                    $('#<%=txt_Monthlyoffer.ClientID %>').removeAttr("disabled");

                    $('#<%=txt_MonthlyCondition.ClientID%>').attr("enabled", "enabled");
                    $('#<%=txt_Monthlyoffer.ClientID%>').attr("enabled", "enabled");
                    $('#<%=txtCondition.ClientID%>').attr("enabled", "enabled");
                    $('#<%=txtItemQty.ClientID%>').attr("disabled", "disabled");
                }
                else {
                    $('#<%=productdiv.ClientID%>').hide();
                    $('#<%=txtCondition.ClientID %>').removeAttr("disabled");
                    $('#<%=txtItemQty.ClientID %>').removeAttr("disabled");
                    $('#<%=txt_MonthlyCondition.ClientID %>').removeAttr("disabled");
                    $('#<%=txt_Monthlyoffer.ClientID %>').removeAttr("disabled");

                    $('#<%=txt_MonthlyCondition.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txt_Monthlyoffer.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtCondition.ClientID%>').attr("enabled", "enabled");
                    $('#<%=txtItemQty.ClientID%>').attr("enabled", "enabled");
                }
                $('#<%=chkIsActive.ClientID%>').is(":checked");
        }


        function Validation() {
            var MSG = "";
            if ($('#<%=txtScheme.ClientID%>').val() == "") {
                    MSG += "\n Please Enter Scheme Name!";
                    $('#<%=txtScheme.ClientID%>').focus();
                }

                if ($('#<%=txtStartDate.ClientID%>').val() == "") {
                    MSG += "\n Please Enter Start Date!";
                    $('#<%=txtStartDate.ClientID%>').focus();
                }

                if ($('#<%=txtExpDate.ClientID%>').val() == "") {
                    MSG += "\n Please Enter Expiry Date!";
                    $('#<%=txtExpDate.ClientID%>').focus();
                }
                if ($('#<%=ddlOfferType.ClientID%>').val() != '3' && $('#<%=ddlOfferType.ClientID%>').val() != '4') {
                    if ($('#<%=txtItemQty.ClientID%>').val() == "" || $('#<%=txtItemQty.ClientID%>').val() == "0") {
                        MSG += "\n Please Enter Item Qty!";
                        $('#<%=txtItemQty.ClientID%>').focus();
                }
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            return true;
        }
    </script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script> var $J = $.noConflict(true); </script>

    <script type="text/javascript">

        $J(function () {
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(",");
                $J('#<%=txt_product.ClientID%>').autocomplete({ source: Productcode });
            });
    </script>
    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="pp"
            HeaderText="Please check the following errors......" ShowMessageBox="True" ShowSummary="False"
            Height="90px" Font-Bold="True" />
    </div>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Create Product Offer</h4>
    <div class="row">
        <div class="col-md-6">
            <div class="row">
        <div class="col-md-4 control-label">
            Scheme
        </div>
        <div class="col-sm-8 ">
            <asp:TextBox ID="txtScheme" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:Label ID="lblsno" runat="server" Text="0" Visible="false"></asp:Label>
        </div>
        <div class="col-md-4  control-label">
            Offer Type
        </div>
        <div class="col-md-8 ">
            <asp:DropDownList ID="ddlOfferType" runat="server" CssClass="form-control" Onchange="ProductVisible();">
            </asp:DropDownList>
        </div>
        <div class="col-md-4 control-label">
            Start Date
        </div>
        <div class="col-md-8">
            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-4 control-label">
            Exp. Date
        </div>
        <div class="col-md-8">
            <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-4 control-label">
            Scheme Selection
        </div>
        <div class="col-md-8 ">
            <asp:TextBox ID="txtItemQty" runat="server" CssClass="form-control" MaxLength="5" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>
        <%--<div class="col-sm-4 control-label">
            Offer On
        </div>
        <div class="col-md-8">--%>
            <asp:DropDownList ID="ddl_OfferOn" runat="server" style="display: none;" CssClass="form-control">
                <asp:ListItem Value="0">All</asp:ListItem>
                <asp:ListItem Value="1">Topper</asp:ListItem>
                <asp:ListItem Value="3">Generation</asp:ListItem>
            </asp:DropDownList>
        <%--</div>--%>
        <div class="col-md-4 control-label">
            No Of Months Condition
        </div>
        <div class="col-md-8 ">
            <asp:TextBox ID="txt_MonthlyCondition" runat="server" CssClass="form-control" MaxLength="10" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>
        <div class="col-sm-4 control-label">
            Monthly Offer
        </div>
        <div class="col-md-8">
            <asp:TextBox ID="txt_Monthlyoffer" runat="server" CssClass="form-control" MaxLength="10" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>
        <div class="col-md-4 control-label">
            <asp:Label ID="lblCondition" runat="server" Text="Scheme Condition"></asp:Label>
        </div>
        <div class="col-md-8">
            <asp:TextBox ID="txtCondition" runat="server" CssClass="form-control" MaxLength="7" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>

       <div class="col-md-4 control-label">
            Max Amount Limit
        </div>
        <div class="col-md-8">
            <asp:TextBox ID="txt_MaxAmt" runat="server" CssClass="form-control" MaxLength="7" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>


        <div class="col-md-4 control-label">
            Active
        </div>
        <div class="col-md-4 control-label">

            <asp:CheckBox ID="chkIsActive" runat="server" Height="50px" Width="50px" Checked="true" />
            <span class="checkmark"></span>

        </div>
        <div class="col-md-4 text-right">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="javascript:return Validation()"
                OnClick="btnSave_Click" CssClass="btn btn-primary" />
        </div>

                </div>
            </div>

        <div class="col-md-6">
            <div id="productdiv" runat="server">

        <div class="row" >

            <div class="col-sm-8">
                <asp:TextBox ID="txt_product" runat="server" CssClass="form-control" placeholder="Search here....."></asp:TextBox>
            </div>

            <div class="col-md-4">
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary" />
            </div>
        </div>
        <div class="clearfix"></div>

        <div class="form-group" style="width: 100%; height: 368px; overflow: scroll;">
            <div class="col-md-12 col-xs-12">
                <asp:GridView ID="GridView2" EmptyDataText="Record not found." CssClass="table table-striped table-hover mygrd"
                    runat="server" AutoGenerateColumns="False" AllowPaging="false">
                    <Columns>
                        <asp:TemplateField HeaderText="Product List" ItemStyle-Width="80%" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:HiddenField ID="hnd_productid" runat="server" Value='<%# Eval("Productid") %>' />
                                <asp:CheckBox ID="chkProd" runat="server" Text='<%#Eval("ProductName") %>'
                                    CssClass="lbl" Font-Size="Small"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty" ItemStyle-Width="20%">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQty" runat="server" class="form-control  m-auto" MaxLength="3" Style="margin: 1px;"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

        </div>
   </div>








    <hr />

    

    <div class="clearfix"></div>


    <div class="row">
        <div class="col-md-2  control-label">Search</div>

        <div class="col-md-4">
            <asp:DropDownList ID="ddl_Active" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddl_Active_SelectedIndexChanged">
                <asp:ListItem Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1" Selected="True">Active</asp:ListItem>
                <asp:ListItem Value="0">InActive</asp:ListItem>
            </asp:DropDownList>
        </div>

    </div>
    <div class="clearfix"></div>


    <div class="table-responsive">
        <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="sid"
            CssClass="table table-striped table-hover mygrd" runat="server" AutoGenerateColumns="False"
            AllowPaging="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
            OnRowEditing="GridView1_RowEditing" OnRowDataBound="GridView1_RowDataBound">
            <Columns>
                <asp:TemplateField ItemStyle-Width="5%" HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkedit" CommandName="Edit" Text="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" Style="color: Blue" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Scheme" ItemStyle-Width="15%">
                    <ItemTemplate>
                        <asp:HiddenField ID="hnd_productid" runat="server" Value='<%# Eval("sid") %>' />
                        <asp:HiddenField ID="hnd_OfferTypeVal" runat="server" Value='<%# Eval("OfferTypeVal") %>' />
                        <asp:Label ID="lblScheme" runat="server" Text='<%# Eval("Scheme") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Condition" ItemStyle-Width="20%">
                    <ItemTemplate>
                        <asp:Label ID="lblCondition" runat="server" Text='<%# Eval("Condition") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:BoundField DataField="MaxAmount" HeaderText="Max Amount Limit" ReadOnly="True"   />

                <asp:TemplateField HeaderText="Offer" ItemStyle-Width="25%">
                    <ItemTemplate>
                        <asp:Label ID="lblOffer" runat="server" Text='<%# Eval("Offer") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Item_qty" HeaderText="Selection" ReadOnly="True"   />
                <asp:BoundField DataField="OfferOn" HeaderText="Offer on" ReadOnly="True" />

                <asp:BoundField DataField="offertype" HeaderText="Offer Type" ReadOnly="True"  />
                <asp:BoundField HeaderText="Start Date" DataField="StartDate" ReadOnly="True"  />
                <asp:BoundField HeaderText="Exp. Date" DataField="ExpDate" ReadOnly="True"   />

                <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%">
                    <ItemTemplate>
                        <%-- <%# Eval("IsActive").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>--%>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='ACTIVE_DEACTIVE'>&nbsp;<%# Eval("IsActive").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>

                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:HyperLinkField HeaderText="Create" ControlStyle-Width="30px" DataNavigateUrlFields="sid"
                        Text="Add Offer" DataNavigateUrlFormatString="CreateItem.aspx?sid={0}" />--%>

                <asp:TemplateField ItemStyle-Width="5%" HeaderText="Create">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkOffer" CommandName="Offer" Text="Add Offer" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" Style="color: Blue" />
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>
    </div>
    <div class="clearfix">
    </div>
    <br />
    </div>
    <div class="clearfix">
    </div>
    <br />



    <div id="divProductcode" style="display: none;" runat="server"></div>
    <div class="clearfix">
    </div>

</asp:Content>
