<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="LoyaltyCoupon.aspx.cs" Inherits="secretadmin_LoyaltyCoupon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">My Coupon</h4>
   <div class="row">
    <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="From"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="To"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="ddl_Userid" runat="server" CssClass="form-control" placeholder="Enter UserId"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txt_Coupon" runat="server" CssClass="form-control" placeholder="Enter Coupon"></asp:TextBox>
                </div>

                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                        <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                        <asp:ListItem Value="1">Active</asp:ListItem>
                        <%-- <asp:ListItem Value="0">Inactive</asp:ListItem>--%>
                        <asp:ListItem Value="2">Lucky Draw</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-sm-2 col-xs-5">
                    <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                        Search
                    </button>
                </div>
</div>


            <div class="clearfix">
            </div>
            <div class="row">
                <center>
                    Active&nbsp;<span class='dotGrey' style="height: 20px; width: 20PX;"></span> &nbsp;
                  Lucky Draw&nbsp;<span class='dotGreen' style="height: 20px; width: 20PX;"></span>
                </center>
            </div>

            <div class="clearfix">
            </div>
            <hr />
            <div class="table-responsive">
                <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>
            </div>
     

   <%-- <a href="javascript:void(0)" onclick="javascript: UpdateLuckyDraw()"></a>--%>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('.datepicker').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>

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

    <script type="text/javascript">

        var pageUrl = "LoyaltyCoupon.aspx";
        $JDT(function () {
            BindTable();
        });


        function BindTable() {

            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var Userid = $('#<%=ddl_Userid.ClientID%>').val();
            var Coupon = $('#<%=txt_Coupon.ClientID%>').val();
            var Status = $('#<%=ddl_Status.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindInvoice',
                data: '{min: "' + min + '", max: "' + max + '",Userid: "' + Userid + '", Coupon: "' + Coupon
                    + '", Status: "' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        var Cid = data.d[i].Cid;
                        var Stats = "<a href='#/' onclick='UpdateLuckyDraw(" + Cid + ")'> <i class='fa fa-toggle-off' style='font-size:24px; color:red'></i> </a>";
                        if (data.d[i].Isactive == "2")
                            var Stats = "<a href='#/' onclick='UpdateLuckyDraw(" + Cid + ")'> <i class='fa fa-toggle-on' style='font-size:24px; color:green'></i> </a>";

                        //var Stats = data.d[i].Isactive == "2" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>";
                        json.push([i + 1,
                           data.d[i].L_Counpon,
                           data.d[i].RegNo,
                           data.d[i].appmstfname,
                           data.d[i].AppMstState,
                           data.d[i].AppMstCity,
                           data.d[i].AppMstMobile,
                           data.d[i].InvoiceNo,
                           data.d[i].Doe,
                           Stats, 
                            '<input type="text" id="txt_WinningItem' + Cid + '" value="' + data.d[i].WinningItem + '" class="form-control"></input>',
                            '<input type="text" id="txt_Remark' + Cid + '" value="' + data.d[i].Remark + '" class="form-control"></input>',
                            '<input type="text" id="txt_DispatchedDate' + Cid + '" value="' + data.d[i].DispatchedDate + '" class="form-control datepicker"></input>',
                            '<input type="text" id="txt_DispatchRemark' + Cid + '" value="' + data.d[i].DispatchRemark + '" class="form-control"></input>',
                           
                            '<a href="#/" onclick="Save(' + Cid + ')" class="btn btn-success">Submit</a>',
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'print'],
                        data: json,
                        columns: [
                              { title: "SNo." },
                              { title: "Coupon" },
                              { title: "User Id	" },
                              { title: "User Name" },
                              { title: "State" },
                              { title: "District" },
                              { title: "Mobile" },
                              { title: "Invoice No." },
                              { title: "Date" },
                              { title: "Lucky Winner" },
                              { title: "Winning Item" },
                              { title: "Remark" },
                              { title: "Dispatch Date" },
                              { title: "Dispatch Remark" },
                              { title: "Action" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function UpdateLuckyDraw(Cid) {
            
            if (!confirm('Are you sure you want to process？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/UpdateLuckyDraw',
                data: '{Cid: "' + Cid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Details save successfully.!!");
                        BindTable();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }

        function Save(Cid) {
            var WinningItem = $('#txt_WinningItem' + Cid).val();
            var Remark = $('#txt_Remark' + Cid).val();
            var DispatchedDate = $('#txt_DispatchedDate' + Cid).val();
            var DispatchRemark = $('#txt_DispatchRemark' + Cid).val();

            if (!confirm('Are you sure you want to dispatch？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                data: '{Cid: "' + Cid + '",WinningItem: "' + WinningItem + '", Remark: "' + Remark + '", DispatchedDate: "' + DispatchedDate + '", DispatchRemark: "' + DispatchRemark + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Details save successfully.!!");
                        BindTable();
                    } else {
                        alert(data.d);
                        return
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }



        function dateFormate(datevalue) {
            var date_arr = "";
            var newformat = "";
            date_arr = datevalue.split('/');
            if (date_arr.length > 0) {
                newformat = date_arr[1] + '/' + date_arr[0] + '/' + date_arr[2];
            }
            if (datevalue == "") {
                newformat = '';
            }
            return newformat;
        }
    </script>
    <style>
    .datepicker{}
  </style>
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
            background-color: #7B68EE;
            display: inline-block;
            border-radius: 50%;
        }
    </style>


</asp:Content>

