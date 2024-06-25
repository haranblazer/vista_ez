<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddMonthlyOffer.aspx.cs" Inherits="secretadmin_AddMonthlyOffer" %>


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

            if ($('#<%=ddl_UserType.ClientID%>').val() == '1') {
                $('#<%=ddl_FranchiseType.ClientID %>').removeAttr("enabled");
                $('#<%=ddl_FranchiseType.ClientID%>').attr("disabled", "disabled");
                $('#<%=ddl_FranchiseType.ClientID%>').val('0');


                $('#<%=ddl_BillType.ClientID %>').removeAttr("disabled");
                $('#<%=ddl_BillType.ClientID%>').attr("enabled", "enabled");
            }
            else {
                $('#<%=ddl_FranchiseType.ClientID %>').removeAttr("disabled");
                $('#<%=ddl_FranchiseType.ClientID%>').attr("enabled", "enabled");

                $('#<%=ddl_BillType.ClientID %>').removeAttr("enabled");
                $('#<%=ddl_BillType.ClientID%>').attr("disabled", "disabled");
                $('#<%=ddl_BillType.ClientID%>').val('0');
            }
            $('#<%=chkIsActive.ClientID%>').is(":checked");
        }
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Create Associate Offer</h4>
    <div class="row">
        <div class="col-md-2">
            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>


        <div class="col-md-1 control-label">
            Condition
        </div>
        <div class="col-md-2 ">
            <asp:TextBox ID="txt_BV_Point" runat="server" CssClass="form-control" MaxLength="7" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>
        <div class="col-md-2 control-label">
            Commission(%)
        </div>
        <div class="col-md-2 ">
            <asp:TextBox ID="txt_Commission" runat="server" CssClass="form-control" MaxLength="10" onkeypress="return onlyNumber(event,this);">0</asp:TextBox>
        </div>



        <div class="col-md-2">
            <asp:DropDownList ID="ddl_UserType" runat="server" style="display: none;" CssClass="form-control" Onchange="ProductVisible();">
                <asp:ListItem Value="1">Associate</asp:ListItem>
                <asp:ListItem Value="2">Franchise</asp:ListItem>
            </asp:DropDownList>
        </div>


        <div class="col-md-2">
            <asp:DropDownList ID="ddl_FranchiseType" runat="server" style="display: none;" CssClass="form-control" Onchange="ProductVisible();">
                <asp:ListItem Value="0">All</asp:ListItem>
                <asp:ListItem Value="5">Top Point</asp:ListItem>
                <asp:ListItem Value="4">Top Circle</asp:ListItem>
                <asp:ListItem Value="3">Depo</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-md-2">
            <asp:DropDownList ID="ddl_BillType" runat="server" style="display: none;" CssClass="form-control">
                <asp:ListItem Value="0">All</asp:ListItem>
                <asp:ListItem Value="1">Topper</asp:ListItem>
                <asp:ListItem Value="3">Generation</asp:ListItem>
            </asp:DropDownList>
        </div>

        <%--<label class="col-md-1">
            Offer
        </label>--%>
        <div class="col-md-3">
            <asp:DropDownList ID="ddl_Inc_Type_Cause" style="display: none;" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Select</asp:ListItem>
               <%-- <asp:ListItem Value="1">Offer Income 1</asp:ListItem>
                <asp:ListItem Value="2">Offer Income 2</asp:ListItem>--%>
            </asp:DropDownList>
        </div>
         
        <div class="col-md-1 control-label"> 
            <asp:CheckBox ID="chkIsActive" runat="server" Height="50px" Width="50px" Text="Active" />

        </div>

        <div class="col-md-3 col-xs-3 text-right">
            <a href="AddMonthlyOffer.aspx" class="btn btn-danger">Reset</a>

            <asp:Button ID="btnSave" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"
                OnClick="btnSave_Click" CssClass="btn btn-primary" />
        </div>
    </div>

    <hr />


    <div class="table-responsive">
        <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="MId"
            CssClass="table mygrd" runat="server" AutoGenerateColumns="False" OnRowEditing="GridView1_RowEditing"
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
                        <asp:HiddenField ID="hnd_Tid" runat="server" Value='<%# Eval("MId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="Start Date" DataField="StartDate" ReadOnly="True" />
                <asp:BoundField HeaderText="Exp Date" DataField="EndDate" ReadOnly="True" />

                <asp:BoundField HeaderText="Condition" DataField="BV_Point" ReadOnly="True" />
                <asp:BoundField HeaderText="Commission(%)" DataField="Commission" ReadOnly="True" />
                <asp:BoundField HeaderText="User Type" DataField="UserType" ReadOnly="True" />
                <asp:BoundField HeaderText="Franchise Type" DataField="FranType" ReadOnly="True" />
                <asp:BoundField HeaderText="Offer On" DataField="BillType" ReadOnly="True" />
                <asp:BoundField HeaderText="Offer Type" DataField="Inc_Type_Cause" ReadOnly="True" />

                <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='ACTIVE_DEACTIVE'>&nbsp;<%# Eval("IsActive").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
    <%-- </div>--%>
    <%--     </div>--%>
    <div class="clearfix">
    </div>
    <br />
    <%--  <script type="text/javascript">
            var GridId = "<%=GridView1.ClientID %>";
            var ScrollHeight = 400;
            window.onload = function () {
                var grid = document.getElementById(GridId);
                var gridWidth = grid.offsetWidth;
                var gridHeight = grid.offsetHeight;
                var headerCellWidths = new Array();
                for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                    headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
                }
                grid.parentNode.appendChild(document.createElement("div"));
                var parentDiv = grid.parentNode;

                var table = document.createElement("table");
                for (i = 0; i < grid.attributes.length; i++) {
                    if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                        table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                    }
                }
                table.style.cssText = grid.style.cssText;
                table.style.width = gridWidth + "px";
                table.appendChild(document.createElement("tbody"));
                table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
                var cells = table.getElementsByTagName("TH");

                var gridRow = grid.getElementsByTagName("TR")[0];
                for (var i = 0; i < cells.length; i++) {
                    var width;
                    if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                        width = headerCellWidths[i];
                    }
                    else {
                        width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                    }
                    cells[i].style.width = parseInt(width) + "px";
                    gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width) + "px";
                }
                parentDiv.removeChild(grid);

                var dummyHeader = document.createElement("div");
                dummyHeader.appendChild(table);
                parentDiv.appendChild(dummyHeader);
                var scrollableDiv = document.createElement("div");
                if (parseInt(gridHeight) > ScrollHeight) {
                    gridWidth = parseInt(gridWidth) + 17;
                }
                scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
                scrollableDiv.appendChild(grid);
                parentDiv.appendChild(scrollableDiv);
            }
        </script>
        <style>
            .table {
                margin-bottom: 0px;
            }

            th {
                border: none;
            }
        </style>--%>
</asp:Content>


