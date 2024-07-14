<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="EventDetail.aspx.cs" Inherits="User_EventDetail" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="assets/css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="assets/js/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function ($) {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>
        <div class="row">
            <div class="col-md-6">                
                    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Event List</h4>
            </div>
            <div class="col-md-6">
                <div class="pull-right ">
                    <div>
                       
                        <%-- <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-word-o me-2"></i>Word</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-excel-o me-2"></i>Excel</a>--%>
                        <%--<a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-pdf-o me-2"></i>PDF</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-print me-2"></i>Print</a>--%>
                    </div>
                </div>
            </div>
            </div>
 <div class="row">
                        <div class="col-sm-1 control-label">
                            From
                        </div>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY"
                                    MaxLength="10" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-1 control-label">
                            To
                        </div>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY"
                                    MaxLength="10" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="clearfix"></div>

                        </div>
                        <div class="col-sm-1 control-label">
                            Type
                        </div>
                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddltype" runat="server" AutoPostBack="true" CssClass="form-control">
                                <asp:ListItem Value="0">All</asp:ListItem>
                                <asp:ListItem Value="1">Event</asp:ListItem>
                                <asp:ListItem Value="2">Business Training</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-1">
                            <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary"
                                OnClick="btnSearchByDate_Click" />
                            <div class="clearfix"></div>

                        </div>
                        <div class="col-sm-2">
                             <button id="imgbtnExcel" runat="server" class="btn btn-primary btn-sm" onserverclick="ibtnExcelExport_Click">
                            <i class="fa fa-file-excel-o me-2"></i>Excel
                        </button>

                        <button id="imgbtnWord" runat="server" class="btn btn-primary btn-sm" onserverclick="ibtnWordExport_Click">
                            <i class="fa fa-file-word-o me-2"></i>Word
                        </button>
                            <asp:DropDownList ID="DdlState" runat="server" style="display: none;" AutoPostBack="true" CssClass="form-control"
                                OnSelectedIndexChanged="DdlState_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-12 text-right">
                            <%-- <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                                OnClick="ibtnExcelExport_Click" />
                            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />--%>
                        </div>
                    </div>
            <div class="clearfix"></div>
        
    <hr />

    <asp:Panel ID="Panel1" runat="server">

        <asp:Label ID="lblMessage" runat="server" CssClass="control-label" Font-Bold="true"></asp:Label>
        <div class="table table-responsive">
            <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-hover" HeaderStyle-BackColor="#fe6a00" HeaderStyle-ForeColor="#ffffff"
                PageSize="50" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Record Found."
                OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true">
                <Columns>
                    <asp:TemplateField HeaderText="Sr No.">
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="appmstregno" HeaderText="UserId" Visible="false" />
                    <asp:BoundField DataField="eventdate" HeaderText="Date" />
                    <asp:BoundField DataField="eventtime" HeaderText="Time" />
                    <asp:BoundField DataField="Location" HeaderText="Venue" />
                    <asp:BoundField DataField="City" HeaderText="City" />
                    <asp:BoundField DataField="State" HeaderText="State" />
                    <asp:BoundField DataField="appmstfname" HeaderText="Leader" />
                    <asp:BoundField DataField="typeofevent" HeaderText="Type Of Event" />
                    <asp:BoundField DataField="entrydate" HeaderText="Entry Date" DataFormatString="{0:dd/MM/yyyy}" Visible="false" />
                </Columns>
            </asp:GridView>
        </div>

    </asp:Panel>

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

</asp:Content>
