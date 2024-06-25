<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="BDM_Franchise.aspx.cs" Inherits="secretadmin_BDM_Franchise" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });


        function ViewBalance(FranchiseId) {
            $.ajax({
                type: "POST",
                url: 'BDM_Franchise.aspx/ViewBalance',
                data: '{FranchiseId: "' + FranchiseId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#' + FranchiseId).text(data.d);
                    //$('#div' + FranchiseId).css('display','none');
                },
                error: function (response) {
                    alert("Server error. Time out.!!");
                }
            });

        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise List</h4>
    <div class="form-group card-group-row row">
                   <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
                </div>
              
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
                </div> 
                    
                <div class="col-sm-2">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search By Id / Name"></asp:TextBox>
                </div>
           
       
                
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddl_State_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Value="">State</asp:ListItem>
                    </asp:DropDownList>
                </div>
               
                <div class="col-sm-2 ">
                    <asp:UpdatePanel ID="UpdateDistrictPanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddl_District" CssClass="form-control" runat="server">
                                <asp:ListItem Value="">District</asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_State" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>


                </div>
                
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_City" runat="server" CssClass="form-control" placeholder="Search By City"></asp:TextBox>
                </div>

            
               
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_PIN" runat="server" CssClass="form-control" placeholder="Search By Pin Code"></asp:TextBox>
                </div>
                
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_Type" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
               
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_IsActive" CssClass="form-control" runat="server">
                        <asp:ListItem Value="-1">All</asp:ListItem>
                        <asp:ListItem Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">InActive</asp:ListItem>
                    </asp:DropDownList>
                </div>

                 
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_PanNo" runat="server" CssClass="form-control" placeholder="Search By Pan No."></asp:TextBox>
                </div>
              
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_GST" runat="server" CssClass="form-control" placeholder="Search By GST"></asp:TextBox>
                </div>

              
                <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_Mob" runat="server" CssClass="form-control" placeholder="Search By Mobile No"></asp:TextBox>

                </div>

                      <div class="col-sm-2 col-xs-3 text-right pull-right">
                    <button id="btnSearch" runat="server" class="btn btn-primary" title="Search" onserverclick="btnSearch_Click">
                       Search
                    </button>
                </div>
<div class="col-sm-1 ">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                Style="margin-left: 0px" Width="23px" />
        </div>

                </div>


   
        
        
    

 
            <div class="row" style="padding-bottom: 10px;">
                 <div class="col-sm-2 col-xs-4 pull-right">
                    <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                        OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                        <asp:ListItem>100</asp:ListItem>
                        <asp:ListItem>500</asp:ListItem>
                        <asp:ListItem>All</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-sm-2 col-xs-5">
                    <asp:Label ID="lblCount" runat="server" Font-Bold="true"></asp:Label>
                </div>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
                    DataKeyNames="FranchiseId,FranchiseName,type,MobileNo" EmptyDataText="Record not found." EmptyDataRowStyle-ForeColor="Red"
                    OnRowCommand="GridView1_RowCommand" AllowPaging="True"
                    OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5" AllowSorting="true" OnSorting="OnSorting">
                    <Columns>

                        <%-- <asp:HyperLinkField DataNavigateUrlFields="FranchiseId" HeaderText="Action" ControlStyle-CssClass="fa fa-edit"
                            ItemStyle-HorizontalAlign="Center" DataNavigateUrlFormatString="../secretadmin/CreateFranchise.aspx?n={0}" />--%>

                        <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="60px" HeaderStyle-Width="80px">
                            <ItemTemplate>
                                <%# Eval("Status").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                                <%--<asp:LinkButton ID="lnkStatus" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='Status'>&nbsp;<%# Eval("Status").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>--%>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Franchise Id" SortExpression="FranchiseId" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Id" runat="server" Text='<%# Eval("FranchiseId")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Franchise Name" SortExpression="FranchiseName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px">
                            <ItemTemplate>
                                 <asp:Label ID="lbl_fName" runat="server" Text='<%# Eval("FranchiseName")%>'></asp:Label>
                               <%-- <asp:LinkButton ID="lbl_TI" runat="server" Text='<%# Eval("FranchiseName")%>' Style="color: blue;" CommandName="login" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Type" DataField="Type" SortExpression="Type" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>

                        <asp:BoundField HeaderText="Contact Person" DataField="ContactPerson" SortExpression="ContactPerson" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="Mobile No." DataField="MobileNo" SortExpression="MobileNo"></asp:BoundField>

                        <asp:BoundField HeaderText="State" DataField="State" SortExpression="State" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="District" DataField="District" SortExpression="District" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="City" DataField="City" SortExpression="City" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="PIN" DataField="PIN" SortExpression="PIN" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="60px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="Address" DataField="Address" SortExpression="Address" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <%-- <asp:BoundField HeaderText="PAN" DataField="PAN" SortExpression="PAN" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="BankName" DataField="BankName" SortExpression="BankName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>

                        <asp:BoundField HeaderText="Account No" DataField="AccountNo" SortExpression="AccountNo" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="IFSC Code" DataField="IFSCCode" SortExpression="IFSCCode" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>--%>
                        <asp:BoundField HeaderText="Registration Date" DataField="RegistrationDate" SortExpression="RegistrationDate" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="Sponsor ID" DataField="SponsorID" SortExpression="SponsorID" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="Sponsor Name" DataField="SponsorName" SortExpression="SponsorName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="Opening Amount" DataField="OpeningAmount" SortExpression="OpeningAmount" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>
                        <asp:BoundField HeaderText="Min Stock Maintenance amount" DataField="MinStkAmt" SortExpression="MinStkAmt" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px"></asp:BoundField>

                        <%-- <asp:TemplateField HeaderText="Regenerate Pwd" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="60px" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnRegenerate" runat="server" Text="Regenerate Pwd" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="RegeneratePwd" OnClientClick="return confirm('Are you sure you want to Regenerate Password.?');" />
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Vendor Authorization" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="150px" HeaderStyle-Width="80px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkIsVendorAuth" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    Enabled='<%#Eval("FranType").ToString()=="2" ? true : false %>'
                                    CssClass='<%#Eval("FranType").ToString()=="2" ? "" : "btn disabled" %>'
                                    CommandName='VendorAuth'>&nbsp;<%# Eval("IsVendorAuth").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Is Return" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="60px" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkIsReturn" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='IsReturn'>&nbsp;<%# Eval("IsReturn").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sample Allow" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="150px" HeaderStyle-Width="80px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkIsSampleAllowed" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='SampleAllowed'>&nbsp;<%# Eval("SampleAllowed").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>

                        <asp:TemplateField HeaderText="franchise Stock" ItemStyle-Wrap="false" ItemStyle-Width="80px" HeaderStyle-Width="80px">
                            <ItemTemplate>
                                <a href="#" data-toggle="modal" data-target="#myModal" onclick='openPopup("<%# Eval("FranchiseId")%>");return false;'>View Details</a>

                                <%-- <asp:LinkButton ID="lnk_StockView" runat="server" Text="View Stock" CommandName="StockView" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"></asp:LinkButton>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DPwithTax Value">
                            <ItemTemplate>
                                <span id="<%# Eval("FranchiseId")%>" onclick='ViewBalance("<%# Eval("FranchiseId")%>");return false;'
                                    style="font-weight: 500;"><a href="/#">View value</a></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
       


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



    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript">

        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }

        function openPopup(franchiseid) {
            $('#tblList').text('');
            $.ajax({
                type: "POST",
                url: 'BDM_Franchise.aspx/GetStock',
                data: '{franchiseid: "' + franchiseid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblList').text('');
                    $('#tblList').empty().append("<thead><tr>");

                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SNo</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Product Code</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Product Name</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Batch No</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Mfg</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Expiry</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Qty</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>DP Rate</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>DP With Tax</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>GST</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>TPV</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>RPV</th>");

                    $('#tblList').append("</tr></thead>");
                    var tbl = '<tbody>';
                    for (var i = 0; i < data.d.length; i++) {
                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td>' + data.d[i].ProductCode + '</td>';
                        tbl += '<td>' + data.d[i].ProductName + '</td>';
                        tbl += '<td>' + data.d[i].BatchNo + '</td>';
                        tbl += '<td>' + data.d[i].Mfg + '</td>';
                        tbl += '<td>' + data.d[i].Expiry + '</td>';
                        tbl += '<td>' + data.d[i].qty + '</td>';
                        tbl += '<td>' + data.d[i].Total_DP + '</td>';
                        tbl += '<td>' + data.d[i].Total_DPWithTax + '</td>';
                        tbl += '<td>' + data.d[i].Tax + '</td>';
                        tbl += '<td>' + data.d[i].TPV + '</td>';
                        tbl += '<td>' + data.d[i].RPV + '</td>';
                        tbl += '</tr>';
                    }
                    tbl += '</tbody>';
                    $('#tblList').append(tbl);
                    if (data.d.length == 0) {
                        $('#tblList').text('Cart is empty.....');
                        return false;
                    }

                    $('#myModal').modal('show');
                },
                error: function (data) {
                    alert("Server error. Time out.!!");
                    return false;
                }
            });
        }
    </script>



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
