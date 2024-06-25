<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TopperUPDOWN.aspx.cs" Inherits="user_downstatus" EnableEventValidation="false" Title="Topper Up Down" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
  

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Downline or Upline Report</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-sm-3 ">
            <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="Enter User ID"></asp:TextBox>
        </div>

        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddlDOWNUP" runat="server" CssClass="form-control">
                <asp:ListItem Value="DOWN">Downline</asp:ListItem>
                <asp:ListItem Value="UP">Upline</asp:ListItem>
            </asp:DropDownList>
            <div class="clearfix">
            </div>
        </div>

        <div class="col-sm-1 col-xs-6">
            <button type="button" title="Search" class="btn btn-success" onclick="BindTable()">Search</button>
        </div>

    </div>




    <%-- <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>--%>
    <div class="clearfix"></div>
    <br />
    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
            <tfoot align="right">
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>

                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </tfoot>
        </table>

        <%--  <asp:GridView ID="GridView1" runat="server" AllowPaging="true" EmptyDataText="No Record Found"
            AutoGenerateColumns="false" OnPageIndexChanging="GridView1_PageIndexChanging"
            DataKeyNames="appmstid" PageSize="500" Width="100%" CellPadding="4" CellSpacing="1" CssClass="table table-striped table-hover mygrd">
            <PagerSettings PageButtonCount="25" /> 
            <RowStyle ForeColor="#333333" />
            <Columns>
                <asp:TemplateField HeaderText="Sr.no">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="UserId" HeaderText="User ID" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" />
                <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" SortExpression="Mobile" />
                <asp:BoundField DataField="ParentName" HeaderText="Parent Name" />
                <asp:BoundField DataField="ParentId" HeaderText="Parent ID" />
                

                <asp:BoundField DataField="Position" HeaderText="Position" />
                <asp:BoundField DataField="TotalLeft" HeaderText="TCC Left" />
                <asp:BoundField DataField="TotalRight" HeaderText="TCC Right" />
                <asp:BoundField DataField="NewLeft" HeaderText="TMC Left" />
                <asp:BoundField DataField="NewRight" HeaderText="TMC Right" />
                <asp:BoundField DataField="Joinfor" HeaderText="Point" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                <asp:TemplateField HeaderText="Extreme Left">
                    <ItemTemplate>
                        <a href="#/" onclick="return GetLeft(<%# Eval("Appmstid")%>);">Left</a>
                       
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Extreme Right">
                    <ItemTemplate>
                        <a href="#/" onclick="return GetRight(<%# Eval("Appmstid")%>);">Right</a> 
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Left" HeaderText="Is Paid">
                    <ItemTemplate>
                        <%# Eval("IsPaid").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                    </ItemTemplate>
                </asp:TemplateField> 

            </Columns>
        </asp:GridView>--%>
    </div>




    <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../Grid_js_css/buttons.dataTables.css" rel="stylesheet" />

    <script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
    <script src="../Grid_js_css/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../Grid_js_css/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/jszip.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/pdfmake.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/vfs_fonts.js" type="text/javascript"></script>
    <script src="../Grid_js_css/buttons.html5.min.js" type="text/javascript"></script>
    <script src="../Grid_js_css/buttons.print.min.js" type="text/javascript"></script>
    <script> var $JDT = $.noConflict(true); </script>

    <script type="text/javascript" charset="utf-8">
        var pageUrl = '<%=ResolveUrl("TopperUPDOWN.aspx")%>';
        //$JDT(function () {
        //    BindTable();
        //});


        function BindTable() {

            var UserId = $('#<%=txtUserId.ClientID%>').val(),
                DOWNUP = $('#<%=ddlDOWNUP.ClientID%>').val();

            if (UserId == "") {
                alert("Please enter userid.");
                return false;
            }

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ UserId: "' + UserId + '", DOWNUP: "' + DOWNUP + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {

                        var Appmstid = data.d[i].Appmstid;
                        let IsPaid = "<span class='dotGrey' title='Not Optin'></span>";
                        if (data.d[i].IsPaid == "1")
                            IsPaid = "<span class='dotGreen' title='Is Optin'></span>";
                        let ExtremeLeft = '<a href="#/" onclick="GetLeft(' + Appmstid + ')" class="btn btn-link">Left</a>';
                        let ExtremeRight = '<a href="#/" onclick="GetRight(' + Appmstid + ')" class="btn btn-link">Right</a>';

                        json.push([i + 1,
                        data.d[i].UserId,
                        data.d[i].UserName,
                        data.d[i].MobileNo,
                        data.d[i].ParentName,
                        data.d[i].ParentId,

                        data.d[i].Position,
                        data.d[i].TotalLeft,
                        data.d[i].TotalRight,
                        data.d[i].NewLeft,
                        data.d[i].NewRight,

                        data.d[i].Joinfor,
                        data.d[i].Status,
                            ExtremeLeft,
                            ExtremeRight,
                            IsPaid,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "#" },

                            { title: "User Id" },
                            { title: "User Name" },
                            { title: "Mobile No." },
                            { title: "Parent Name" },
                            { title: "Parent Id" },

                            { title: "Position" },
                            { title: "TCC Left" },
                            { title: "TCC Right" },
                            { title: "TMC Left" },
                            { title: "TMC Right" },

                            { title: "Point" },
                            { title: "Status" },
                            { title: "Extreme Left" },
                            { title: "Extreme Right" },
                            { title: "Is Paid" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,

                    });


                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        } 
    </script>

      <script type="text/javascript" charset="utf-8">

          function GetLeft(Appmstid) {
              GetUserid(Appmstid, 0);
          }

          function GetRight(Appmstid) {
              GetUserid(Appmstid, 1)
          }

          function GetUserid(Appmstid, Position) {
              $.ajax({
                  type: "POST",
                  url: pageUrl + '/GetExtremeUser',
                  data: '{ Appmstid: "' + Appmstid + '", Position: "' + Position + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (data) {
                      var MSG = "Your Extreme " + (Position == "0" ? "Left " : "Right ");
                      MSG += "User is: " + data.d;
                      alert(MSG);
                  },
                  error: function (response) { 
                      //alert(response.d);
                      return false;
                  }
              });
          }
      </script>


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

</asp:Content>

