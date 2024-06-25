<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="LegWiseLoyalty.aspx.cs" 
    Inherits="secretadmin_LegWiseRoyalty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
        </script>

    <script type="text/javascript">
        $(function () {
            $.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function SetTarget() {
            document.forms[0].target = "_blank";
        }

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }
 
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Cum 2000 Loyalty IDs Report</h4>
   <div class="row">
                   <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
                </div>
                
                <div class="col-sm-2">
                    <asp:TextBox ID="txt_Userid" runat="server" CssClass="form-control" placeholder="Enter UserId."
                        MaxLength="30"></asp:TextBox>
                </div>

                <div class="col-sm-2 control-label" >
                    Loyalty 
                    Value</div>
                <div class="col-sm-1" style="padding: 0px;">
                    <asp:TextBox ID="txt_MinV" runat="server" CssClass="form-control" placeholder="Min Values"
                        onkeypress="return onlyNumbers(event,this);" MaxLength="10"></asp:TextBox>
                </div>
                <div class="col-sm-1" style="padding: 0px;">
                    <asp:TextBox ID="txt_MaxV" runat="server" CssClass="form-control" placeholder="Max Values"
                        onkeypress="return onlyNumbers(event,this);" MaxLength="10"></asp:TextBox>
                </div>
                <div class="col-sm-1">
                     <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-primary" /> 
                </div>
                      <div class="pull-right text-right">
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="20px" />
            </div>
                </div>

         <hr />
             
            <div class="table-responsive">
               
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" PageSize="100" AutoGenerateColumns="False"
                    EmptyDataText="No Record Found." ShowFooter="true" FooterStyle-Font-Bold="true" 
                    OnPageIndexChanging="dglst_PageIndexChanging" OnRowCommand="Grdreport_RowCommand"
                    DataKeyNames="UserId">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate><asp:Label ID="lblUser" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="UserId" DataField="UserId" />
                        <asp:BoundField HeaderText="User Name" DataField="UserName" />
                        <asp:BoundField HeaderText="District" DataField="District" />
                        <asp:BoundField HeaderText="State" DataField="State" />
                        <asp:BoundField HeaderText="Mobile No" DataField="MobileNo" />
                        <asp:TemplateField HeaderText="Jan" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                 <asp:LinkButton ID="link1" runat="server" Text='<%# Eval("Jan")%>' CommandName="Jan" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Feb" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link2" runat="server" Text='<%# Eval("Feb")%>' CommandName="Feb" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mar" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link3" runat="server" Text='<%# Eval("Mar")%>' CommandName="Mar" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'> </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Apr" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link4" runat="server" Text='<%# Eval("Apr")%>' CommandName="Apr" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'> </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="May" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link5" runat="server" Text='<%# Eval("May")%>' CommandName="May" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'> </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Jun" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link6" runat="server" Text='<%# Eval("Jun")%>' CommandName="Jun" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Jul" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link7" runat="server" Text='<%# Eval("Jul")%>' CommandName="Jul" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Aug" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link8" runat="server" Text='<%# Eval("Aug")%>' CommandName="Aug" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sep" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link9" runat="server" Text='<%# Eval("Sep")%>' CommandName="Sep" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Oct" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link10" runat="server" Text='<%# Eval("Oct")%>' CommandName="Oct" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nov" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link11" runat="server" Text='<%# Eval("Nov")%>' CommandName="Nov" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dec" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="link12" runat="server" Text='<%# Eval("Dec")%>' CommandName="Dec" Style="color: blue;" OnClientClick="SetTarget();" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>


                    </Columns>
                </asp:GridView>
            </div>

            <div class="clearfix"></div>
     


        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 100%;">
            <div class="modal-dialog" style="width: 80%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">View Sponsor Report</h4>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table id="tblList" class="table" style="width: 100%; border-collapse: collapse;"></table>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

</asp:Content>

