<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AddLoyaltyMaster.aspx.cs" Inherits="secretadmin_AddLoyaltyMaster" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Create Consistency Offer</h4>
    <div class="row">
         <div class="col-md-9"></div>
         <div class="col-md-3">
            <a href="AddRoyality.aspx" class="btn btn-link pull-right">Consistency Offer List</a>
        </div>
        <div class="clear"></div>

         <div class="col-md-2 control-label">
           Enter Consistency Name
        </div>
        <div class="col-md-2">
            <asp:TextBox ID="txt_LoyaltyName" runat="server" CssClass="form-control disabled"></asp:TextBox>
        </div>

        <div class="col-md-2 control-label">
           Consistency Type
        </div>
        <div class="col-md-2">
            <asp:DropDownList ID="ddl_LoyalityType" runat="server" CssClass="form-control disabled">
                <asp:ListItem Value="1">Consistency 1</asp:ListItem>
                <asp:ListItem Value="2">Consistency 2</asp:ListItem>
                <asp:ListItem Value="3">Consistency 3</asp:ListItem>
                <asp:ListItem Value="4">Consistency 4</asp:ListItem>
                <asp:ListItem Value="5">Consistency 5</asp:ListItem>
            </asp:DropDownList>
        </div>

         
        <div class="col-md-2">
            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        
        <div class="col-md-2">
            <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div> 
        <div class="clear"></div>

        <div class="col-md-2 control-label">
            Min Inv val(Rs) >=
        </div>
        <div class="col-md-2 "> 
            <asp:TextBox ID="txt_BV_Point" runat="server" CssClass="form-control" MaxLength="7" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>
         <div class="col-md-2 control-label">
            Max Inv val(Rs) <=
        </div>
         <div class="col-md-2 ">
            <asp:TextBox ID="txt_Max_BV_Point" runat="server" CssClass="form-control disabled" MaxLength="7" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>

        <div class="col-md-2 control-label">
            Max Consistency in month
        </div>
        <div class="col-md-2 ">
            <asp:TextBox ID="txt_Loyalty" runat="server" CssClass="form-control" MaxLength="10" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>
        <div class="clear"></div>

        <div class="col-md-2 control-label">
            Consistency Offer
        </div>
        <div class="col-md-2 ">
            <asp:TextBox ID="txt_LoyaltyOffer" runat="server" CssClass="form-control" MaxLength="10" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>


        <div class="col-md-1 control-label">
            Active
        </div>
        <div class="col-md-1 control-label"> 
            <asp:CheckBox ID="chkIsActive" runat="server" Height="50px" Width="50px" /> 
        </div>
          

        <div class="col-md-3 col-xs-3 text-right">
            <asp:Button ID="btnSave" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"
                OnClick="btnSave_Click" CssClass="btn btn-primary" />
        </div>
         

    </div>


   <%--    <hr />

    <div class="table-responsive">


     <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="MId"
            CssClass="table mygrd" runat="server" AutoGenerateColumns="False" OnRowEditing="GridView1_RowEditing"
            AllowPaging="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
            <Columns> 
                <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                        <asp:HiddenField ID="hnd_Tid" runat="server" Value='<%# Eval("MId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="MId" HeaderText="Action" ControlStyle-CssClass="fa fa-edit"
                    ItemStyle-HorizontalAlign="Center" DataNavigateUrlFormatString="~/secretadmin/AddLoyaltyMaster.aspx?Mid={0}" />


                <asp:BoundField HeaderText="Start Date" DataField="StartDate" ReadOnly="True" />
                <asp:BoundField HeaderText="Exp Date" DataField="EndDate" ReadOnly="True" />
                <asp:BoundField HeaderText="Invoice value(Rs)" DataField="BV_Point" ReadOnly="True" />
                <asp:BoundField HeaderText="Max Loyalty in month" DataField="MaxRoyalty" ReadOnly="True" />
                <asp:BoundField HeaderText="Loyalty Offer" DataField="RoyaltyType" ReadOnly="True" />
                <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='ACTIVE_DEACTIVE'>&nbsp;<%# Eval("IsActive").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </div>--%>


      
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>

    <script type="text/javascript">       
        $JD(function () {
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


        function Validation() {
            var MSG = "";
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
            $('#<%=chkIsActive.ClientID%>').is(":checked");
        }
    </script>



</asp:Content>


