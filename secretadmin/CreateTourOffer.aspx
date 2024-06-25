<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="CreateTourOffer.aspx.cs" Inherits="secretadmin_CreateTourOffer" %>

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
            $JD('#<%=txtStartDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtExpDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txt_Date.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

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

        function Validation() {
            var MSG = "";
            if ($('#<%=txt_TourName.ClientID%>').val() == "") {
                MSG += "\n Please Enter Tour Name!";
                $('#<%=txt_TourName.ClientID%>').focus();
            }
            if ($('#<%=txtStartDate.ClientID%>').val() == "") {
                MSG += "\n Please Enter Start Date!";
                $('#<%=txtStartDate.ClientID%>').focus();
            }
            if ($('#<%=txtExpDate.ClientID%>').val() == "") {
                MSG += "\n Please Enter Expiry Date!";
                $('#<%=txtExpDate.ClientID%>').focus();
            }
            if (MSG != "") {
                alert(MSG);
                return false;
            }
            return true;
        }


        function ProductVisible() {
          
            $('#<%=ddl_OfferOn.ClientID %>').removeAttr("disabled");
            $('#<%=ddl_OfferOn.ClientID%>').attr("enabled", "enabled");
             
            if ($('#<%=ddl_TourType.ClientID%>').val() == '4') {
                $('#<%=txtCondition.ClientID %>').removeAttr("disabled");
                $('#<%=txtCondition.ClientID%>').attr("enabled", "enabled");
                

                $('#<%=txt_MaxValuesFromSingleLeg.ClientID %>').removeAttr("disabled");
                $('#<%=txt_MaxValuesFromSingleLeg.ClientID%>').attr("enabled", "enabled");
                

                $('#<%=ddl_OfferOn.ClientID%>').val(3);
                $('#<%=ddl_OfferOn.ClientID %>').removeAttr("enabled");
                $('#<%=ddl_OfferOn.ClientID%>').attr("disabled", "disabled");


                $('#<%=txt_Date.ClientID %>').hide();
                $('#<%=txt_Time.ClientID %>').hide();
                $('#<%=txt_Place.ClientID %>').hide();
                $('#<%=txt_Venue.ClientID %>').hide();

                $('#<%=ddl_RankGen.ClientID %>').show(); 
                $('#<%=ddl_RankGenApplicable.ClientID %>').show();
                
                $('#<%=div_GridProduct.ClientID %>').hide();
            }
            else {
                if ($('#<%=ddl_OfferOn.ClientID%>').val() == '1') {
                    $('#<%=txtCondition.ClientID %>').removeAttr("enabled");
                    $('#<%=txtCondition.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtCondition.ClientID%>').val('0');

                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID %>').removeAttr("enabled");
                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID%>').val('0');

                    $('#<%=div_GridProduct.ClientID %>').hide();

                    $('#<%=txt_Date.ClientID %>').hide();
                    $('#<%=txt_Time.ClientID %>').hide();
                    $('#<%=txt_Place.ClientID %>').hide();
                    $('#<%=txt_Venue.ClientID %>').hide();

                    $('#<%=ddl_RankGen.ClientID %>').hide();
                    $('#<%=ddl_RankGen.ClientID%>').val(0);
                    $('#<%=ddl_RankGenApplicable.ClientID %>').hide();
                    $('#<%=ddl_RankGenApplicable.ClientID%>').val(0);

                }
                else if ($('#<%=ddl_OfferOn.ClientID%>').val() == '3') {
                    $('#<%=txtCondition.ClientID %>').removeAttr("disabled");
                    $('#<%=txtCondition.ClientID%>').attr("enabled", "enabled");
                    

                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID %>').removeAttr("disabled");
                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID%>').attr("enabled", "enabled");
                     

                    $('#<%=div_GridProduct.ClientID %>').hide();

                    $('#<%=txt_Date.ClientID %>').hide();
                    $('#<%=txt_Time.ClientID %>').hide();
                    $('#<%=txt_Place.ClientID %>').hide();
                    $('#<%=txt_Venue.ClientID %>').hide();

                    $('#<%=ddl_RankGen.ClientID %>').hide();
                    $('#<%=ddl_RankGen.ClientID%>').val(0);

                    $('#<%=ddl_RankGenApplicable.ClientID %>').hide();
                    $('#<%=ddl_RankGenApplicable.ClientID%>').val(0);

                }
                else if ($('#<%=ddl_OfferOn.ClientID%>').val() == '5' || $('#<%=ddl_OfferOn.ClientID%>').val() == '6') {


                    $('#<%=txtCondition.ClientID %>').removeAttr("enabled");
                    $('#<%=txtCondition.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txtCondition.ClientID%>').val('0');

                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID %>').removeAttr("enabled");
                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID%>').attr("disabled", "disabled");
                    $('#<%=txt_MaxValuesFromSingleLeg.ClientID%>').val('0');

                    $('#<%=div_GridProduct.ClientID %>').show();

                    $('#<%=txt_Date.ClientID %>').show();
                    $('#<%=txt_Time.ClientID %>').show();
                    $('#<%=txt_Place.ClientID %>').show();
                    $('#<%=txt_Venue.ClientID %>').show();

                    $('#<%=ddl_RankGen.ClientID %>').hide();
                    $('#<%=ddl_RankGen.ClientID%>').val(0);
                    $('#<%=ddl_RankGenApplicable.ClientID %>').hide();
                    $('#<%=ddl_RankGenApplicable.ClientID%>').val(0);

                }
            }
             
            $('#<%=chkIsActive.ClientID%>').is(":checked");
        }

    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Create Offer & Tour</h4>
    <div class="form-group card-group-row row">

        <div class="col-sm-2 ">
            <asp:TextBox ID="txt_TourName" runat="server" CssClass="form-control" placeholder="Tour Name"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddl_TourType" runat="server" CssClass="form-control" Onchange="ProductVisible();">
            </asp:DropDownList>
        </div>


        <div class="col-md-2 ">
            <asp:TextBox ID="txt_DisplayName" runat="server" CssClass="form-control" placeholder="Display Name" MaxLength="50"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:CheckBox ID="chkIsActive" runat="server" Height="50px" Width="50px" Text="Active" TextAlign="Left" />
        </div>

    </div>

    <div class="form-group card-group-row row">
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_OfferOn" runat="server" CssClass="form-control" Onchange="ProductVisible();">
                <asp:ListItem Value="3">Generation</asp:ListItem>
                <%--<asp:ListItem Value="1">Topper</asp:ListItem>--%>
                <asp:ListItem Value="5">Generation Product</asp:ListItem>
                <%--<asp:ListItem Value="6">Topper Product</asp:ListItem> --%>
            </asp:DropDownList>
        </div>


        <div class="col-md-1">
            Condition
        </div>
        <div class="col-md-2 ">
            <asp:TextBox ID="txtCondition" runat="server" CssClass="form-control" MaxLength="7" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>
         
        <div class="col-md-1">
            Max. <%=method.PV%>
        </div>
        <div class="col-md-2 ">
            <asp:TextBox ID="txt_MaxValuesFromSingleLeg" runat="server" CssClass="form-control" MaxLength="10" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddl_RankGen" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>

         <div class="col-md-2">
            <asp:DropDownList ID="ddl_RankGenApplicable" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>

    </div>
    <div class="form-group card-group-row row">

        <div class="col-md-2">
            <asp:TextBox ID="txt_Date" runat="server" CssClass="form-control" placeholder="Select Date" MaxLength="50"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_Time" runat="server" CssClass="form-control" placeholder="00:00" MaxLength="50"
                TextMode="Time" format="HH:mm"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:TextBox ID="txt_Place" runat="server" CssClass="form-control" placeholder="Enter Place" MaxLength="50"></asp:TextBox>
        </div>
        <div class="col-md-3">
            <asp:TextBox ID="txt_Venue" runat="server" CssClass="form-control" placeholder="Enter Venue" MaxLength="50"></asp:TextBox>
        </div>

        <div class="col-md-2 pull-right text-right">
            <asp:Button ID="btnSave" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"
                OnClick="btnSave_Click" CssClass="btn btn-primary" /> &nbsp; &nbsp;

            <a href="CreateTourOffer.aspx" class="btn btn-danger">Reset</a>
        </div>
    </div>

    <div class="clearfix"></div>
    <br />
    <div id="div_GridProduct" runat="server" class="form-group" style="width: 100%; height: 280px; overflow: scroll; display: none;">
        <div class="col-md-12 col-xs-12">
            <asp:GridView ID="GridView2" EmptyDataText="Record not found." CssClass="table table-striped table-hover mygrd"
                runat="server" AutoGenerateColumns="False" AllowPaging="false">
                <Columns>
                    <asp:TemplateField HeaderText="Product List" ItemStyle-Width="80%">
                        <ItemTemplate>
                            <asp:HiddenField ID="hnd_productid" runat="server" Value='<%# Eval("Productid") %>' />
                            <asp:CheckBox ID="chkProd" runat="server" Text='<%#Eval("ProductName") %>'
                                CssClass="lbl" Font-Size="Small"></asp:CheckBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Qty" ItemStyle-Width="20%">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQty" runat="server" class="form-control" MaxLength="3" Style="margin: 1px;"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>


    <div class="clearfix"></div>
    <div class="table-responsive">
        <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="Tid"
            CssClass="table table-striped table-hover mygrd" runat="server" AutoGenerateColumns="False" OnRowEditing="GridView1_RowEditing"
            AllowPaging="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField ItemStyle-Width="5%" HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkedit" CommandName="Edit" Text="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" Style="color: Blue" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                        <asp:HiddenField ID="hnd_Tid" runat="server" Value='<%# Eval("Tid") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Tour Name" DataField="TourName" ReadOnly="True" />
                <asp:BoundField HeaderText="Display Name" DataField="DisplayName" ReadOnly="True" />

                <asp:BoundField HeaderText="Condition" DataField="Condition" ReadOnly="True" />
                <asp:BoundField HeaderText="Maximum GPV" DataField="NoOfCount" ReadOnly="True" />
                <asp:BoundField HeaderText="Tour Type" DataField="TourTypeText" ReadOnly="True" />

                <asp:TemplateField HeaderText="DateTime" ItemStyle-Width="5%">
                    <ItemTemplate>
                        <%# Eval("Date") %>  <%# Eval("Time") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="Place" DataField="Place" ReadOnly="True" />
                <asp:BoundField HeaderText="Venue" DataField="Venue" ReadOnly="True" />
                <asp:BoundField HeaderText="Rank" DataField="TLPer" ReadOnly="True" /> 
                 <asp:BoundField HeaderText="APL. Rank" DataField="ApplicableRank" ReadOnly="True" /> 
                <asp:BoundField HeaderText="Offer On" DataField="Pack_RepText" ReadOnly="True" />
                <asp:BoundField HeaderText="Start Date" DataField="StartDate" ReadOnly="True" />
                <asp:BoundField HeaderText="Exp Date" DataField="ExpDate" ReadOnly="True" />

                <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='ACTIVE_DEACTIVE'>&nbsp;<%# Eval("IsActive").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>
    </div>
</asp:Content>


