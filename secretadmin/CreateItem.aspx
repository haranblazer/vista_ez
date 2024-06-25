<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateItem.aspx.cs" Inherits="admin_Pamentmst"
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
    <%-- <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    <%--<link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>--%>

    <%--<link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>
    <script> var $JD = $.noConflict(true); </script>--%>

     <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script> var $J = $.noConflict(true); </script>

    <script type="text/javascript">

        $J(function () {
             
            var Productcode = document.getElementById("<%=divProductcode.ClientID%>").innerHTML.split(","); 
            $J('#<%=txt_product.ClientID%>').autocomplete({ source: Productcode });
        });


        function ShowAddItemOffer() {

            if ($('#<%=divhide.ClientID%>').is(':hidden')) {
                $('#<%=divhide.ClientID%>').show();
            }
            else {
                $('#<%=divhide.ClientID%>').hide();
            }
            return false;
        }


        function ValidationAddItem() {

            var MSG = "";
            if ($('#<%=txtAddItem.ClientID%>').val() == "") {
                MSG += "\n Please Enter Item Offer Name!";
                $('#<%=txtAddItem.ClientID%>').focus();
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            return true;

        }


        function ValidationAddOffer() {
            var MSG = "";
            if ($('#<%=txtqty.ClientID%>').val() == "" || $('#<%=txtqty.ClientID%>').val() == "0") {
                MSG += "\n Please Enter Qty!";
                $('#<%=txtqty.ClientID%>').focus();
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            return true;
        }
    </script>
    <div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="pp"
            HeaderText="Please check the following errors......" ShowMessageBox="True" ShowSummary="False"
            Height="90px" Font-Bold="True" />
    </div>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Create Item</h4>


    <div class="row">


        <div class="col-md-2 control-label">
            Scheme
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control" Enabled="false">
            </asp:DropDownList>
        </div>
        <div class="col-md-1 control-label">
            Item
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddlItem" runat="server" CssClass="form-control">
            </asp:DropDownList>
            <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label>
        </div>
        <div class="col-md-2">
            <asp:LinkButton ID="btAddItemOffer" runat="server" Text=" + Add Item" CssClass="btn btn-primary"
                OnClientClick="javascript:return ShowAddItemOffer();" />
        </div>
         <div class="col-md-2"> </div>
        <div class="col-sm-1 float-right">
            <a href="CreateScheme.aspx" class="btn btn-primary">Back</a>
        </div>

    </div>

    <div id="divhide" style="display: none" runat="server">
        <div class="row">
            <div class="col-md-2 control-label">Item Name</div>
            <div class="col-md-2">
                <asp:TextBox ID="txtAddItem" runat="server" CssClass="form-control" Visible="true"
                    placeholder="Enter Item Name."></asp:TextBox>
            </div>
            <div class="col-md-1">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-primary"
                    Visible="true" OnClientClick="javascript:return ValidationAddItem()" />

            </div>
        </div>
    </div>
    <br />


    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="lbl_Condition" runat="server"></asp:Label>
        </div>
        <div class="col-md-3">
            <asp:Label ID="lbl_Type_Qty" runat="server"></asp:Label>
        </div>
        <div class="col-md-6">
            <asp:Label ID="lbl_date" runat="server"></asp:Label>
        </div>
    </div>



    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Create Offer</h4>


    <div class="row">

        <div class="col-md-4">
            <asp:TextBox ID="txt_product" runat="server" CssClass="form-control" placeholder="Search here....."></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary" />
        </div>

        <div class="col-md-4">
            <a href="CreateScheme.aspx" class="btn btn-info"><i class="fa fa-plus" aria-hidden="true">&nbsp;</i>Create Scheme</a>
        </div>

    </div>
    <div class="clearfix"></div>
    <hr />
    <div class="row">
        <div class="col-md-1 control-label">
            Product
        </div>
        <div class="col-sm-3">
            <asp:DropDownList ID="ddlProduct" runat="server" CssClass="form-control">
            </asp:DropDownList>
            <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label>
        </div>
        <div class="col-md-1 control-label">
            Quantity
        </div>
        <div class="col-md-1">
            <asp:TextBox ID="txtqty" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-1 control-label">
            Rs
        </div>
        <div class="col-md-1">
            <asp:TextBox ID="txtrs" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_Active" runat="server" CssClass="form-control">
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="0">De-active</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnsaveoffer" runat="server" Text="Save" CssClass="btn btn-primary"
                OnClick="btnsaveoffer_Click" OnClientClick="javascript:return ValidationAddOffer()" />
            <asp:Button ID="btn_Reset" runat="server" Text="Reset" OnClick="btn_Reset_Click" CssClass="btn btn-danger" />
            <asp:HiddenField ID="hid_Offerid" runat="server" Value="0" />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="table-responsive">
        <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="offerid"
            CssClass="table table-striped table-hover mygrd" runat="server" AutoGenerateColumns="False"
            AllowPaging="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
            OnRowEditing="GridView1_RowEditing">
            <Columns>
                <asp:TemplateField HeaderText="SNo" ItemStyle-Width="5%">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Item Name" ItemStyle-Width="25%">
                    <ItemTemplate>
                        <asp:HiddenField ID="hnd_offerid" runat="server" Value='<%# Eval("offerid") %>' />
                        <asp:Label ID="lblScheme" runat="server" Text='<%# Eval("itemname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name" ItemStyle-Width="50%">
                    <ItemTemplate>
                        <%# Eval("ProductName") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Rs" HeaderText="Rs" ReadOnly="True" ItemStyle-Width="10%"></asp:BoundField>
                <asp:BoundField HeaderText="Qty" DataField="qty" ReadOnly="True" ItemStyle-Width="10%"></asp:BoundField>
                <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%">
                    <ItemTemplate>
                        <%# Eval("IsActive").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="5%" HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" CommandName="EDIT" Text='Edit' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            runat="server" Style="color: Blue" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div id="divProductcode" style="display: none;" runat="server"></div>
    <div class="clearfix">
    </div>
</asp:Content>
