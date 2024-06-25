<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="BVwithSponsor.aspx.cs" Inherits="secretadmin_BVwithSponsor" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--  <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            // $.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });



        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }

        function openPopup(userid) {

            $('#tblList').text('Please wait while the system is processing your request.!!');
            var FromDate = $('#<%=txtFromDate.ClientID%>').val(),
             ToDate = $('#<%=txtToDate.ClientID%>').val(),
             Sponsor = $('#<%=txt_Sponsor.ClientID%>').val(),
              SelfRPV = $('#<%=txt_SelfRPV.ClientID%>').val(),
             GPV_RPV_Type = $('#<%=ddl_D_GPV_RPV.ClientID%>').val(),
             D_GPV_RPV = $('#<%=txt_D_GPV_RPV.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: 'BVwithSponsor.aspx/GetSponsorData',
                data: '{FromDate: "' + FromDate + '", ToDate: "' + ToDate + '", Sponsor: "' + Sponsor + '", SelfRPV: "' + SelfRPV + '", GPV_RPV_Type: "' + GPV_RPV_Type + '", D_GPV_RPV: "' + D_GPV_RPV + '", userid: "' + userid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#tblList').text('');
                    $('#tblList').empty().append("<thead><tr>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SNo</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>UserId</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>User Name</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Genaration Rank</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Mobile</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>SponsporId</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Sponsor Name</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>RPV</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>Downline GPV</th>");
                    $('#tblList').append("<th style='border-bottom: 1px dotted #d3d3d3; background-color:#f3f4f8;'>No Of Sponsor</th>");
                    $('#tblList').append("</tr></thead>");
                    var tbl = '<tbody>';
                    for (var i = 0; i < data.d.length; i++) {
                        tbl += '<tr style="border-bottom: 1px dotted #d3d3d3;">';
                        tbl += '<td>' + (i + 1) + '</td>';
                        tbl += '<td>' + data.d[i].UserId + '</td>';
                        tbl += '<td>' + data.d[i].UserName + '</td>';
                        tbl += '<td>' + data.d[i].RankName + '</td>';
                        tbl += '<td>' + data.d[i].Mobile + '</td>';
                        tbl += '<td>' + data.d[i].SponsporId + '</td>';
                        tbl += '<td>' + data.d[i].SponsorName + '</td>';
                        tbl += '<td>' + data.d[i].RPV + '</td>';
                        tbl += '<td>' + data.d[i].GPV + '</td>';
                        tbl += '<td>' + data.d[i].NoOfSponsor + '</td>';
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

    <div>
        <h2 class="head">
            <i class="fa fa-list" aria-hidden="true"></i>&nbsp;GPV With Sponsor Report
            <div class="pull-right text-right">
                        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                            Width="20px" />
                    </div>
        </h2>
        <div class="panel panel-default">
          
                <br />
                <div class="form-group">

                    <div class="col-sm-2">
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
                    </div>
                    <label class="col-sm-1 control-label" style="padding:0px;">Self RPV</label>
                    <div class="col-sm-1" style="padding:0px;">
                        <asp:TextBox ID="txt_SelfRPV" runat="server" CssClass="form-control" placeholder="Enter Self RPV"
                            onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
                    </div>

                    <label class="col-sm-1 control-label">No Of Sponsor</label>
                    <div class="col-sm-1" style="padding:0px;">
                        <asp:TextBox ID="txt_Sponsor" runat="server" CssClass="form-control" placeholder="Enter No Of Sponsor"
                            onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_D_GPV_RPV" runat="server" CssClass="form-control">
                            <asp:ListItem Value="GPV">Downline GPV>=</asp:ListItem>
                            <asp:ListItem Value="RPV">Downline RPV>=</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                     <div class="col-sm-1" style=" padding: 0;">
                        <asp:TextBox ID="txt_D_GPV_RPV" runat="server" CssClass="form-control" placeholder="Enter RPV/GPV"
                            onkeypress="return onlyNumbers(event,this);" MaxLength="10">0</asp:TextBox>
                    </div>
                    
                    <div class="col-sm-1">
                        <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" CssClass="btn btn-success" />
                    </div>
                     
                </div>
           

               
                <div class="clearfix"></div>
            

                <div class="table-responsive">
                    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                        Font-Names="Arial" Font-Size="Small" PageSize="50" AutoGenerateColumns="False"
                        EmptyDataText="No Record Found." ShowFooter="true" OnPageIndexChanging="dglst_PageIndexChanging"
                        OnRowDataBound="dglst_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--  <asp:BoundField HeaderText="UserId" DataField="UserId" />--%>
                            <%--  <asp:TemplateField HeaderText="UserId" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a href="#" data-toggle="modal" data-target="#myModal" onclick='openPopup("<%# Eval("userid")%>");return false;'>  View </a>
                                  <br />  <asp:Label ID="lblUser" runat="server"> <%# Eval("UserId")%> </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="View" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a href="#" data-toggle="modal" data-target="#myModal" onclick='openPopup("<%# Eval("userid")%>");return false;'>View Details</a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField HeaderText="UserId" DataField="UserId" />
                            <asp:BoundField HeaderText="User Name" DataField="UserName" />
                            <asp:BoundField HeaderText="Genaration Rank" DataField="RankName" />
                            <asp:BoundField HeaderText="Mobile" DataField="Mobile" />
                            <asp:BoundField HeaderText="SponsporId" DataField="SponsporId" />
                            <asp:BoundField HeaderText="Sponsor Name" DataField="SponsorName" />
                            <asp:BoundField HeaderText="RPV" DataField="RPV" />
                            <asp:BoundField HeaderText="Downline GPV" DataField="GPV" />
                            <asp:BoundField HeaderText="No Of Sponsor" DataField="NoOfSponsor" />
                        </Columns>
                    </asp:GridView>
                </div>
           
            <div class="clearfix"></div>
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
</asp:Content>

