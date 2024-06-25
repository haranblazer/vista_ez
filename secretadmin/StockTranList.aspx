<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="StockTranList.aspx.cs" Inherits="admin_StockTranList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Franchise Sales Invoice</h4>
     <div class="form-group card-group-row row">
                        <div class="col-md-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                                MaxLength="10"></asp:TextBox>
                        </div>

                        <div class="col-md-2 ">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                                MaxLength="10"></asp:TextBox>

                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_SalesRepId" runat="server" CssClass="form-control" placeholder="Enter Franchise Id"></asp:TextBox>
                        </div>

                        <div class="col-sm-2">
                            <asp:TextBox ID="Txt_InvoiceNo" runat="server" MaxLength="30" CssClass="form-control" placeholder="Enter Invoice No."></asp:TextBox>
                        </div>



                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_Buyerid" runat="server" CssClass="form-control" placeholder="Enter Buyer Id"></asp:TextBox>
                        </div>


                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1" Selected="True">Active</asp:ListItem>
                                <asp:ListItem Value="-1">All </asp:ListItem>
                                <asp:ListItem Value="2">Cancelled</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddl_Del_Status" runat="server" CssClass="form-control">
                                <asp:ListItem Value="-1" Selected="True">All </asp:ListItem>
                                <asp:ListItem Value="1">Delivered</asp:ListItem>
                                <asp:ListItem Value="0">Pending</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-1">
                            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search </button>
                            <%-- <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search"
                                OnClick="btnSearch_Click" />--%>
                        </div>
                        <div class="col-md-2 col-xs-6 text-right pull-right">
                            <%--  <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                Width="25px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-left: 0px" Width="26px" />--%>
                        </div>
                    </div>

    <hr />
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



        <%--  <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-hover"
            AutoGenerateColumns="false" PageSize="100" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging"
            DataKeyNames="invoiceno, srno" OnRowCommand="GridView1_RowCommand" OnRowUpdating="GridView1_RowUpdating"
            OnRowDataBound="GridView1_RowDataBound" OnRowCancelingEdit="GridView1_RowCancelingEdit"
            EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" ShowFooter="true">
            <Columns>
                <asp:TemplateField HeaderText="SrNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <FooterTemplate>Total:</FooterTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="Date" DataField="Date" />
                <asp:HyperLinkField DataNavigateUrlFields="srno_Encript" HeaderText="Invoice No."
                    DataTextField="InvoiceNo" DataNavigateUrlFormatString="../Common/StockTranBill.aspx?id={0}" />

                <asp:TemplateField HeaderText="Packing Slip">
                    <ItemTemplate>
                        <center>
                            <a href="PackingSlip.aspx?id=<%# Eval("invoiceno_Encript")%>">
                                <%# Eval("Pack_Status").ToString() == "1" ? "<span style='color:green;'><i class='fa fa-gift' aria-hidden='true'></i></span>" : "<span style='color:red;'><i class='fa fa-gift' aria-hidden='true'></i></span>"%>
                            </a>
                        </center>
                    </ItemTemplate>
                </asp:TemplateField>

               

                <asp:BoundField HeaderText="Seller ID" DataField="SellerUserId" />
                <asp:BoundField HeaderText="Seller Name" DataField="SellerName" />
                <asp:BoundField HeaderText="Seller District" DataField="SellerDistrict" />
                <asp:BoundField HeaderText="Seller State" DataField="SellerState" />


                <asp:BoundField HeaderText="Buyer Id" DataField="BuyerUserId" />
                <asp:BoundField HeaderText="Buyer Name" DataField="BuyerName" />
                <asp:BoundField HeaderText="Buyer Mobile No" DataField="BuyerMobileNo" />
                <asp:BoundField HeaderText="Buyer District" DataField="BuyerDistrict" />
                <asp:BoundField HeaderText="Buyer State" DataField="BuyerState" />


                <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                <asp:BoundField HeaderText="Billed Qty." DataField="Actual_Qty" />
                <asp:BoundField HeaderText="DP Value" DataField="grossAmt" />

                <asp:BoundField HeaderText="SGST" DataField="SGST" />
                <asp:BoundField HeaderText="CGST" DataField="CGST" />
                <asp:BoundField HeaderText="IGST" DataField="IGST" />
                <asp:BoundField HeaderText="Cess" DataField="Cess" />

                <asp:BoundField HeaderText="DP with Tax" DataField="netAmt" />


                <asp:BoundField HeaderText="Courier Charges" DataField="CourierCharges" />
                <asp:BoundField HeaderText="Discount" DataField="Discount" />

                <asp:BoundField HeaderText="Invoice Value" DataField="Amount" />


                <asp:BoundField HeaderText="FPV" DataField="TotalFPV" />
                <asp:TemplateField HeaderText="RPV">
                    <ItemTemplate>0.00 </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="APV">
                    <ItemTemplate>0.00 </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Billing Type">
                    <ItemTemplate></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Invoice Status">
                    <ItemTemplate>
                        <asp:Label ID="lbl_cancelled" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Dispatch Status">
                    <ItemTemplate>
                        <asp:Label ID="lbl_DelStatus" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="PanNo" DataField="PanNo" />
                <asp:BoundField HeaderText="EWay Bill No" DataField="EwayNo" />
                <asp:BoundField HeaderText="Payment Mode" DataField="PayMode" />

              

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:HiddenField ID="hnd_Del_Status" runat="server" Value='<%#Eval("Del_Status") %>' />
                        <asp:HiddenField ID="hnd_status" runat="server" Value='<%#Eval("status") %>' />

                        <asp:LinkButton ID="lnkbtnCancel" Text="cancel" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CommandName="cancel" runat="server" OnClientClick="return confirm('Are you sure you want to cancel this bill?');" Style="color: blue;" />
                    </ItemTemplate>
                </asp:TemplateField>

               
            </Columns>
        </asp:GridView>--%>
    </div>



    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
                $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            });

        function dateEvent(id) { $JD(id).datepick({ dateFormat: 'dd/mm/yyyy' }); }

    </script>



    <%-- Table Js and css  --%>
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
        var pageUrl = '<%=ResolveUrl("StockTranList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
            var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
            var SalesRepId = $('#<%=txt_SalesRepId.ClientID%>').val();
            var Buyerid = $('#<%=txt_Buyerid.ClientID%>').val();
            var InvoiceNo = $('#<%=Txt_InvoiceNo.ClientID%>').val();
            var Status = $('#<%=ddl_Status.ClientID%>').val();
            var Del_Status = $('#<%=ddl_Del_Status.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{min: "' + min + '", max: "' + max + '", SalesRepId: "' + SalesRepId + '", Buyerid: "' + Buyerid
                    + '", InvoiceNo: "' + InvoiceNo + '", Status: "' + Status + '", Del_Status: "' + Del_Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var T_NoOFProduct = 0, T_grossAmt = 0, T_SGST = 0, T_CGST = 0, T_IGST = 0, T_netAmt = 0, T_TotalFPV = 0;
                    var json = [];
                    var Addevent = [];
                    for (var i = 0; i < data.d.length; i++) {
                        var InvoiceNo = '<a style="color: #727272; font-weight: bold;" href="../Common/StockTranBill.aspx?id=' + data.d[i].srno_Encode + '">' + data.d[i].InvoiceNo + '</a>';
                        var inv = "'" + data.d[i].InvoiceNo + "'";
                        var srno = data.d[i].srno;

                        var Packing = '';
                        if (data.d[i].Pack_Status == '1') {
                            Packing = '<a href="PackingSlip.aspx?id=' + data.d[i].invoiceno_Encript + '"><span style="color:green;"> <i class="fa fa-gift" aria-hidden="true"></i> </span></a>';
                        }
                        else {
                            Packing = '<a href="PackingSlip.aspx?id=' + data.d[i].invoiceno_Encript + '"><span style="color:red;"> <i class="fa fa-gift" aria-hidden="true"></i></span></a>';
                        }


                        var Dispatch = '<center> <a style="color:blue;" href="FranchiseDispatch.aspx?id=' + data.d[i].srno_Encode + '"><i class="fa fa-truck"></i> </a> </center>';
                        var DispatchStatus = "";

                        if (data.d[i].Del_Status == "7") {
                            DispatchStatus = " <span style='color:orange'>Transit</<span>";
                        }
                        else if (data.d[i].Del_Status == "1") {
                            DispatchStatus = " <span style='color:green'>Delivered</<span>";
                        }
                        else if (data.d[i].Del_Status == "0") {
                            DispatchStatus = " <span style='color:red'>Pending</<span>";
                        }

                        var Deliver = "";
                        if (data.d[i].Del_Status == '1') {
                            Deliver = '<a href="#/" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Dispatched</a>';
                        }
                        else {
                            Deliver = '<a href="#/" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Transit</a>';
                        }

                       


                        var Img1Color = "style=color:blue;";
                        if (data.d[i].Slip != "")
                            Img1Color = "style=color:green;";

                        var Img2Color = "style=color:blue;";
                        if (data.d[i].Img2 != "")
                            Img2Color = "style=color:green;";

                        var Upload_lr1 = '<input type="file" id="img_lr1' + srno + '" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr1' + srno + '" title="Upload LR Image 1"> <i class="fa fa-upload"></i> </label> &nbsp;&nbsp;&nbsp;&nbsp; <a href="../images/Slip/' + data.d[i].Slip + '" data-fancybox="gallery" ' + Img1Color + '"> <i class="fa fa-eye" title="View Image 1"></i> </a>';
                        var Upload_lr2 = '<input type="file" id="img_lr2' + srno + '" accept=".png,.jpg,.jpeg,.gif" style="display:none;"> <label for="img_lr2' + srno + '" title="Upload LR Image 2"> <i class="fa fa-upload"></i> </label>  &nbsp;&nbsp;&nbsp;&nbsp; <a href="../images/Slip/' + data.d[i].Img2 + '" data-fancybox="gallery" ' + Img2Color + '"> <i class="fa fa-eye" title="View Image 2"></i> </a>';

                        var SMS = "'SMS'";
                        var WHATSAPP = "'WHATSAPP'";

                        var SMS_BuyerUserId = "'" + data.d[i].BuyerUserId + "'";
                        var SMS_BuyerName = "'" + data.d[i].BuyerName + "'";
                        var SMS_Disp_Date = "'" + data.d[i].DispatchDate + "'";
                        var SMS_Docket = "'" + data.d[i].Tracking + "'";
                        var SMS_Transport = "'" + data.d[i].Transport + "'";
                        var SMS_MobileNo = "'" + data.d[i].BuyerMobileNo + "'";
                        var SMS_IMG_LR1 = "'" + data.d[i].Slip + "'";

                        var Send_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendMsg + '</span> <a href="#/" onclick="SendSms(' + SMS + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')" class="btn btn-success" style="width:20px;" title="Send Message"> <i class="fa fa-send-o"></i> </a>';
                        var Send_Whats_sms = '<span class="dotBlue" title="SMS Count">' + data.d[i].SendWhatsApp + '</span> <a href="#/" onclick="SendSms(' + WHATSAPP + ',' + srno + ',' + SMS_BuyerUserId + ',' + SMS_BuyerName + ',' + inv + ',' + SMS_Disp_Date + ',' + SMS_Docket + ',' + SMS_Transport + ',' + SMS_MobileNo + ',' + SMS_IMG_LR1 + ')" class="btn btn-success" style="width:20px;" title="Send Whats App Message"> <i class="fa fa-whatsapp"></i> </a>';
                        var IS_OPTIN = "<span class='dotGrey' title='Not Optin'></span>";
                        if (data.d[i].IS_OPTIN == "1")
                            var IS_OPTIN = "<span class='dotGreen' title='Is Optin'></span>";

                        var Action = '<input type="button" onclick="Cancel_Invice(' + inv + ')" value="Cancel" class="btn btn-link">';

                        T_NoOFProduct = parseInt(T_NoOFProduct) + parseInt(data.d[i].NoOFProduct);
                        T_grossAmt = parseFloat(T_grossAmt) + parseFloat(data.d[i].grossAmt);
                        T_SGST = parseFloat(T_SGST) + parseFloat(data.d[i].SGST);
                        T_CGST = parseFloat(T_CGST) + parseFloat(data.d[i].CGST);
                        T_IGST = parseFloat(T_IGST) + parseFloat(data.d[i].IGST);
                        T_netAmt = parseFloat(T_netAmt) + parseFloat(data.d[i].netAmt);
                        T_TotalFPV = parseFloat(T_TotalFPV) + parseFloat(data.d[i].TotalFPV);


                        Addevent.push({ id: srno });
                        json.push([
                            i + 1,
                            data.d[i].Date,
                            InvoiceNo,
                            Packing,
                             
                            data.d[i].SellerUserId,
                            data.d[i].SellerName,
                            data.d[i].SellerState,
                            data.d[i].SellerDistrict,
                             
                            data.d[i].BuyerUserId,
                            data.d[i].BuyerName,
                            data.d[i].BuyerDistrict,
                            data.d[i].BuyerState,
                            data.d[i].BuyerMobileNo,

                            '<div style="text-align:center;">' + data.d[i].NoOFProduct + '</div>',
                            '<div style="text-align:right;">' + data.d[i].grossAmt + '</div>',
                            '<div style="text-align:right;">' + data.d[i].SGST + '</div>',
                            '<div style="text-align:right;">' + data.d[i].CGST + '</div>',
                            '<div style="text-align:right;">' + data.d[i].IGST + '</div>',
                            '<div style="text-align:right;">' + data.d[i].netAmt + '</div>',
                            '<div style="text-align:right;">' + data.d[i].TotalFPV + '</div>',

                           
                            data.d[i].status == "2" ? "<span style='color:red'>Cancelled</<span>" : "<span style='color:green'>Submit</<span>",
                            DispatchStatus,
                            data.d[i].ConfirmWith,
                            data.d[i].DurationDays,
                            data.d[i].DeliveryDate,
                            InvoiceNo,
                            '<input type="text" id="txt_DispatchedDate' + srno + '" value="' + data.d[i].DispatchDate + '" onclick="dateEvent("txt_DispatchedDate"' + srno + '");" placeholder="dd/mm/yyyy" class="form-control"></input>',

                            '<input type="text" id="txt_Transport' + srno + '" value="' + data.d[i].Transport + '" class="form-control"></input>',
                            '<input type="text" id="txt_Tracking' + srno + '" value="' + data.d[i].Tracking + '" class="form-control"></input>',
                            '<input type="text" id="txt_EWay' + srno + '" value="' + data.d[i].EwayNo + '" class="form-control"></input>',
                            '<input type="text" id="txt_Boxes' + srno + '" value="' + data.d[i].No_Boxes + '" class="form-control"></input>',
                            '<input type="text" id="txt_Weight' + srno + '" value="' + data.d[i].Weight_KG + '" class="form-control"></input>',
                            '<input type="text" id="txt_Remarks' + srno + '" value="' + data.d[i].Del_Remarks + '" class="form-control"></input>',

                            Upload_lr1,
                            Upload_lr2,
                            Deliver,
                            Send_sms,
                            Send_Whats_sms + ' ' + IS_OPTIN,
                            data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : Action,
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
                            { title: "SNo" },
                            { title: "Date" },
                            { title: "Invoice No." },
                            { title: "Packing" },
                             
                            { title: "Seller ID" },
                            { title: "Seller Name" },
                            { title: "Seller District" },
                            { title: "Seller State" },
                             
                            { title: "Buyer ID" },
                            { title: "Buyer Name" },
                            { title: "Buyer District" },
                            { title: "Buyer State" },
                            { title: "Buyer Mobile No." },

                            { title: "No.Of Prod" },
                            { title: "DP Value" },
                            { title: "SGST" },
                            { title: "CGST" },
                            { title: "IGST" },
                            { title: "DP with Tax" },
                            { title: "FPV" },
                             
                            { title: "Invoice Status" },
                            { title: "Dispatch Status" },
                            { title: "Confirm With" },


                            { title: "Duration days" },
                            { title: "Delivery date" },
                            { title: "Invoice No." },
                            { title: "Dispatch Date" },
                            { title: "Transport" },

                            { title: "Docket No" },
                            { title: "EWay Bill" },
                            { title: "No. Boxes" },
                            { title: "Weight KG" },
                            { title: "Remarks" },

                            { title: "Img LR1" },
                            { title: "Img LR2" },
                            { title: "Deliver" },
                            { title: "SMS" },
                            { title: "Whatsapp" },
                            { title: "Action" },
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) { return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0; };
                            //    // Total over all pages
                            $(api.column(1).footer()).html('Total:');

                            $(api.column(13).footer()).html(T_NoOFProduct);
                            $(api.column(14).footer()).html(T_grossAmt.toFixed(2));
                            $(api.column(15).footer()).html(T_SGST.toFixed(2));
                            $(api.column(16).footer()).html(T_CGST.toFixed(2));
                            $(api.column(17).footer()).html(T_IGST.toFixed(2));
                            $(api.column(18).footer()).html(T_netAmt.toFixed(2));
                            $(api.column(19).footer()).html(T_TotalFPV.toFixed(2));
                        }
                    });

                    $.each(Addevent, function (index, value) {
                        dateEvent("#txt_DispatchedDate" + value.id);
                    });

                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function Cancel_Invice(Invoice) {
            if (!confirm('Are you sure you want to cancel invoice？')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/Cancel_Invoice',
                data: '{Invoice: "' + Invoice + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Invoice Cancelled Successfully");
                        GetBinaryDownline()
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

    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
    <script> var $JJ = $.noConflict(true); </script>
    <script type="text/javascript">



        function Deliver_Invice(Invoice, srno) {
            var Transport = $('#txt_Transport' + srno).val();
            var Tracking = $('#txt_Tracking' + srno).val();
            var EWay = $('#txt_EWay' + srno).val();
            var Remarks = $('#txt_Remarks' + srno).val();
            var Weight = $('#txt_Weight' + srno).val();
            var Boxes = $('#txt_Boxes' + srno).val();

            var DispatchedDate = $('#txt_DispatchedDate' + srno).val();
            if (DispatchedDate != "")
                DispatchedDate = dateFormate(DispatchedDate);


            if (!confirm('Are you sure you want to transit？')) {
                return false;
            }

            var ImgName1 = "";
            var fileUpload1 = $JJ("#img_lr1" + srno).get(0);
            var files1 = fileUpload1.files;
            var data1 = new FormData();

            var random1 = Math.floor(1000000 + Math.random() * 9000000);
            random1 = "s1" + random1;
            for (var i = 0; i < files1.length; i++) {
                var ext = files1[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data1.append(random1 + '.' + ext, files1[i]);
                ImgName1 = random1 + '.' + ext;
            }



            var ImgName2 = "";
            var fileUpload2 = $JJ("#img_lr2" + srno).get(0);
            var files2 = fileUpload2.files;
            var data2 = new FormData();

            var random2 = Math.floor(1000000 + Math.random() * 9000000);
            random2 = "s2" + random2;
            for (var i = 0; i < files2.length; i++) {
                var ext = files2[i].name.split(".");
                ext = ext[ext.length - 1].toLowerCase();

                data2.append(random2 + '.' + ext, files2[i]);
                ImgName2 = random2 + '.' + ext;
            }


            $.ajax({
                type: "POST",
                url: pageUrl + '/Dispatch_Inv',
                data: '{ Invoice: "' + Invoice + '", srno: "' + srno + '", Transport: "' + Transport + '", Tracking: "' + Tracking + '", EWay: "' + EWay + '", Remarks: "' + Remarks
                    + '", Weight: "' + Weight + '", Boxes: "' + Boxes + '", ImgName1: "' + ImgName1 + '", ImgName2: "' + ImgName2 + '", DispatchedDate: "' + DispatchedDate + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Deliver Updated Successfully");

                        if (ImgName1 != "") {
                            var _URL = window.URL || window.webkitURL;
                            $.ajax({
                                url: "../FranchiseHandler.ashx",
                                type: "POST",
                                data: data1,
                                contentType: false,
                                processData: false,
                                success: function (result) { },
                                error: function (err) { }
                            });
                        }

                        if (ImgName2 != "") {
                            var _URL = window.URL || window.webkitURL;
                            $.ajax({
                                url: "../FranchiseHandler.ashx",
                                type: "POST",
                                data: data2,
                                contentType: false,
                                processData: false,
                                success: function (result) { },
                                error: function (err) { }
                            });
                        }

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



        function SendSms(SMSTYPE, srno, UserId, Name, Inv, Date, Docket, Transport, Mobile, Img_Lr1) {
            if (!confirm('Are you sure you want to send message？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: 'StockTranList.aspx/SendSms',
                data: '{SMSTYPE: "' + SMSTYPE + '", srno: "' + srno + '", UserId: "' + UserId + '", Name: "' + Name
                    + '", Inv: "' + Inv + '", Date: "' + Date + '", Docket: "' + Docket + '",Transport: "' + Transport
                    + '", Mobile: "' + Mobile + '", Img_Lr1: "' + Img_Lr1 + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Message Sent Successfully");
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

        .dotBlue {
            height: 20px;
            width: 20px;
            background-color: #96DED1;
            display: inline-block;
            border-radius: 50%;
        }
    </style>


    <%--  <script type="text/javascript">

        var pageUrl = '<%=ResolveUrl("StockTranList.aspx")%>';
        $JDT(function () {

            BindTable();
        });


        function BindTable() {

            var min = dateFormate($('#<%=txtFromDate.ClientID%>').val());
             var max = dateFormate($('#<%=txtToDate.ClientID%>').val());
             var SalesRepId = $('#<%=txt_SalesRepId.ClientID%>').val();
             var Buyerid = $('#<%=txt_Buyerid.ClientID%>').val();
             var InvoiceNo = $('#<%=Txt_InvoiceNo.ClientID%>').val();
             var Status = $('#<%=ddl_Status.ClientID%>').val();
             var Del_Status = $('#<%=ddl_Del_Status.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{min: "' + min + '", max: "' + max + '", SalesRepId: "' + SalesRepId + '", Buyerid: "' + Buyerid
                    + '", InvoiceNo: "' + InvoiceNo + '", Status: "' + Status + '", Del_Status: "' + Del_Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                         
                        var Invoice = '<a href="../Common/StockTranBill.aspx?id=' + data.d[i].srno_Encript + '">' + data.d[i].InvoiceNo + '</a>';
                        var Packing = '';
                        if (data.d[i].Pack_Status == '1') {
                            Packing = '<a href="PackingSlip.aspx?id=' + data.d[i].invoiceno_Encript + '"><span style="color:green;"> <i class="fa fa-gift" aria-hidden="true"></i> </span></a>';
                        }
                        else {
                            Packing = '<a href="PackingSlip.aspx?id=' + data.d[i].invoiceno_Encript + '"><span style="color:red;"> <i class="fa fa-gift" aria-hidden="true"></i></span></a>';
                        }
                        var srno = data.d[i].srno;
                        var Transport = '<span  id="lbl_Transport' + srno + '">' + data.d[i].Transport + '</span>';
                        var Tracking = '<span id="lbl_Tracking' + srno + '">' + data.d[i].Tracking + '</span>';
                        var EWay = '<span id="lbl_EWay' + srno + '">' + data.d[i].EWayBill + '</span>';
                        var Remarks = '<span id="lbl_Remarks' + srno + '">' + data.d[i].Del_Remarks + '</span>';

                        var inv = "'" + data.d[i].InvoiceNo + "'";

                        var Deliver = '';
                        if (data.d[i].Del_Status == '1') {
                            Deliver = '<input type="button" value="Dispatched" class="btn btn-success disabled">';
                        }
                        else {
                            Deliver = '<a href="#/" data-toggle="modal" data-target="#myModal" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-link">Dispatch</a>';
                        }
                        var Action = '<input type="button" onclick="Cancel_Invice(' + inv + ')" value="Cancel" class="btn btn-link">';

             

                        json.push([i + 1,
                            data.d[i].Date,
                            Packing,
                            Invoice,
                            data.d[i].SellerUserId,
                            data.d[i].SellerName,
                            data.d[i].SellerState,
                            data.d[i].SellerDistrict,
                            data.d[i].BuyerUserId,
                            data.d[i].BuyerName,

                            data.d[i].BuyerState, 
                            data.d[i].BuyerDistrict,
                            data.d[i].BuyerMobileNo,
                            data.d[i].NoOFProduct,
                            data.d[i].Actual_Qty,
                            data.d[i].grossAmt,
                            data.d[i].SGST,
                            data.d[i].CGST,
                            data.d[i].IGST,
                            data.d[i].Cess,

                            data.d[i].Amt, 
                            data.d[i].Discount,
                            data.d[i].CourierCharges,
                            data.d[i].NetAmt, 
                            data.d[i].TotalFPV, 
                            data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : "Submit",
                            data.d[i].Del_Status == "0" ? "<span style='color:red'>Pending</span>" : "Delivered",
                            data.d[i].PanNo,
                            EWay,
                            data.d[i].PayMode,

                            Invoice, 
                            data.d[i].DispatchDate,
                            Transport,
                            Tracking, 
                            Remarks,
                            Deliver, 
                            data.d[i].status == "0" ? "<span style='color:red'>Cancelled </span>" : Action,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        buttons: ['copy', 'csv', 'excel'],
                        data: json,
                        columns: [
                            { title: "#" },
                            { title: "<div style='width:80px'>Date</div>" },
                            { title: "Invoice No." },
                            { title: "Packing" },
                            { title: "Seller Id" },
                            { title: "<div style='width:380px'>Seller Name</div>" },
                            { title: "<div style='width:200px'>Seller State</div>" },
                            { title: "Seller District" },
                            { title: "Buyer Id" },
                            { title: "Buyer Name" },

                            { title: "<div style='width:200px'>Buyer State</div>" },
                            { title: "Buyer District" },
                            { title: "Buyer Mobile" },
                            { title: "No	No of Products" },
                            { title: "Billed Qty." },
                            { title: "DP Value" },
                            { title: "SGST" },
                            { title: "CGST" },
                            { title: "IGST" },
                            { title: "Cess" },

                            { title: "DP with Tax" },
                            { title: "Discount" },
                            { title: "Courier Charges" },
                            { title: "Invoice Value" },
                            { title: "FPV" }, 
                            { title: "Invoice Status" },
                            { title: "Dispatch Status" },
                            { title: "PanNo" },
                            { title: "E Way Bill" },
                            { title: "Pay Mode" },

                            { title: "Invoice No." },
                            { title: "Dispatch Date" },
                            { title: "Transport" },
                            { title: "Tracking" }, 
                            { title: "Remarks" },
                            { title: "Deliver" }, 
                            { title: "Action" },

                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 10,
                        //columnDefs: [{ orderable: false, targets: [0, 1] }],
                        "bDestroy": true,
                        "footerCallback": function (row, data, start, end, display) {
                            var api = this.api(), data;

                            // Remove the formatting to get integer data for summation
                            var intVal = function (i) {
                                return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1 : typeof i === 'number' ? i : 0;
                            };

                            // Total over all pages
                            var NoofProducts = api.column(12).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(12).footer()).html(NoofProducts);

                            var BilledQty = api.column(13).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(13).footer()).html(BilledQty);

                            var DPValue = api.column(14).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(14).footer()).html(DPValue.toFixed(2));

                            var SGST = api.column(15).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(15).footer()).html(SGST.toFixed(2));

                            var CGST = api.column(16).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(16).footer()).html(CGST.toFixed(2));

                            var IGST = api.column(17).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(17).footer()).html(IGST.toFixed(2));

                            var Cess = api.column(18).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(18).footer()).html(Cess.toFixed(2));

                            var DPwithTax = api.column(19).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(19).footer()).html(DPwithTax.toFixed(2));

                            var Discount = api.column(20).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(20).footer()).html(Discount.toFixed(2));

                            var CourierCharges = api.column(21).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(21).footer()).html(CourierCharges.toFixed(2));

                            var InvoiceValue = api.column(22).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(22).footer()).html(InvoiceValue.toFixed(2));

                            var TPV = api.column(23).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(23).footer()).html(TPV.toFixed(2));

                            var RPV = api.column(24).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(24).footer()).html(RPV.toFixed(2));

                            var FPV = api.column(25).data().reduce(function (a, b) { return intVal(a) + intVal(b); }, 0);
                            $(api.column(25).footer()).html(FPV.toFixed(2));

                        }
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function Cancel_Invice(Invoice) {
            if (!confirm('Are you sure you want to cancel invoice？')) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: pageUrl + '/Cancel_Invoice',
                data: '{Invoice: "' + Invoice + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Invoice Cancelled Successfully");
                        GetBinaryDownline()
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


        function Deliver_Invice(Invoice, srno) {
            $('#<%=hnd_Inv.ClientID%>').val(Invoice);
            $('#lbl_Invoice').text(Invoice);

            $('#txt_Transport').val($('#lbl_Transport' + srno).text());
            $('#txt_Tracking').val($('#lbl_Tracking' + srno).text());
            $('#txt_EWay').val($('#lbl_EWay' + srno).text());
            $('#txt_Remarks').val($('#lbl_Remarks' + srno).text());
        }


        function Dispatched_Invice() {

            var Invoice = $('#<%=hnd_Inv.ClientID%>').val();
            var Transport = $('#<%=txt_Transport.ClientID%>').val();
            var Tracking = $('#<%=txt_Tracking.ClientID%>').val();
            var EWay = $('#<%=txt_EWay.ClientID%>').val();
            var Remarks = $('#<%=txt_Remarks.ClientID%>').val();
            if (!confirm('Are you sure you want to dispatch？')) {
                return false;
            }
            $.ajax({
                type: "POST",
                url: pageUrl + '/Dispatch_Inv',
                data: '{ Invoice: "' + Invoice + '", Transport: "' + Transport + '", Tracking: "' + Tracking + '", EWay: "' + EWay + '", Remarks: "' + Remarks + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alert("Deliver Updated Successfully");
                        GetBinaryDownline()
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

        function Reser() {
            $('#<%=ddl_RoleWise.ClientID%>').val('');
            $('#<%=DropDownList2.ClientID%>').val(0);
            $('#<%=TxtSponsorId.ClientID%>').val('');
            $('#<%=ddl_Status.ClientID%>').val('-1');
            $('#<%=ddl_paymode.ClientID%>').val('');
            $('#<%=txtcvlimit.ClientID%>').val('0');
            $('#<%=ddlcvtype.ClientID%>').val('0');
        }


        function GetSelectedTextValue(ddlUserType) {
            var selectedValue = ddlUserType.value;
            if (selectedValue != "0" && $("#<%=TxtSponsorId.ClientID%>").val() == "") {
                alert("Enter UserId! "); ddlUserType.value = "0";
                $("#<%=TxtSponsorId.ClientID%>").focus();
            }
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
    </script>--%>
</asp:Content>
