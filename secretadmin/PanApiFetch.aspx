<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="PanApiFetch.aspx.cs" Inherits="secretadmin_PanApiFetch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Update Pan API Name</h4>
    <div id="LoaderImg" style="width: 100%; text-align: center; position: absolute; z-index: 99999; display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="col-sm-10">
    </div>
    <div class="col-sm-2">
        <a href="PanApiFetch.aspx" class="btn btn-success">Refresh</a>
    </div>

    <hr />

    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
            <tfoot align="center">
                <tr>
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
    </div>


    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>

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
    <script>        var $JDT = $.noConflict(true); </script>
    <asp:HiddenField ID="hnd_responseuserId" runat="server" Value="" />
    <asp:HiddenField ID="hnd_responseId" runat="server" Value="" />
    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("PanApiFetch.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {

            var Login = {
                "url": "https://signzy.tech/api/v2/patrons/login",
                "method": "POST",
                "timeout": 0,
                "headers": { "Content-Type": "application/json", },
                "data": JSON.stringify({ "username": "toptimeconsumer_prod", "password": "N23gbnlN30TQ21HQ5sZB" }),
            };

            $.ajax(Login).done(function (response) {
                $('#<%=hnd_responseuserId.ClientID%>').val(response.userId);
                $('#<%=hnd_responseId.ClientID%>').val(response.id);


                $('#LoaderImg').show();
                $.ajax({
                    type: "POST",
                    url: pageUrl + '/BindTable',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        $('#LoaderImg').hide();
                        var json = [];

                        for (var i = 0; i < data.d.length; i++) {
                            let AppMstid = data.d[i].AppMstid;
                            var panno = "'" + data.d[i].panno + "'";
                            var VerifyUserName = '<snap id="lbl_' + AppMstid + '"></span> ';
                            var VerifyBTN = '<input type="button" id="btn_' + AppMstid + '" value="Verify" onclick="VerifyPAN(' + panno + ',' + AppMstid + ')" class="btn btn-success" /> ';
                            //var Transport = '<input type="text" id="txt_Transport' + srno + '" value="' + data.d[i].Transport + '" class="form-control"></input>';
                            //<a href="javascript:void(0)" onclick="Deliver_Invice(' + inv + ',' + data.d[i].srno + ')" class="btn btn-success">Dispatched</a>
                            json.push([i + 1,
                            data.d[i].AppMstRegNo,
                            data.d[i].AppMstFName,

                                VerifyUserName,
                                VerifyBTN,
                            data.d[i].panno,
                            data.d[i].AppMstState,
                            data.d[i].distt,

                            ]);
                        }

                        $JDT('#tblList').DataTable({
                            dom: 'Blfrtip',
                            scrollY: "1000px",
                            scrollX: true,
                            scrollCollapse: true,
                            buttons: ['copy', 'csv', 'excel'],
                            data: json,
                            columns: [
                                { title: "#" },
                                { title: "User Id" },
                                { title: "User Name" },
                                { title: "Pan API Name" },

                                { title: "Verify" },
                                { title: "Pan No" },
                                { title: "State" },
                                { title: "District" },
                            ],
                            "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                            "pageLength": -1,
                            "bDestroy": true,
                        });
                    },
                    error: function (result) {
                        $('#LoaderImg').hide();
                        alert(result);
                    }
                });




            });
        }


        function VerifyPAN(panno, AppMstid) {
            $('#LoaderImg').show();

            var responseuserId = $('#<%=hnd_responseuserId.ClientID%>').val();
            var Settings = {
                "url": "https://signzy.tech/api/v2/patrons/" + $('#<%=hnd_responseuserId.ClientID%>').val() + "/panv2",
                "method": "POST",
                "headers": { "Content-Type": "application/json", "authorization": $('#<%=hnd_responseId.ClientID%>').val() },
                "data": JSON.stringify({ "task": "fetch", "essentials": { "number": panno } }),
            }

            let PanDetails = "";

            $.ajax(Settings).done(function (PanResponse) {

                console.log("PAN API: " + PanResponse);
                if (PanResponse.result.panStatusCode == "E") {
                    let PanApiName = PanResponse.result.name;

                    PanDetails = "";
                    PanDetails = 'name : ' + PanResponse.result.name
                        + '^ number : ' + PanResponse.result.number
                        + '^ typeOfHolder : ' + PanResponse.result.typeOfHolder
                        + '^ status : ' + PanResponse.result.status
                        + '^ isIndividual : ' + PanResponse.result.isIndividual
                        + '^ isValid : ' + PanResponse.result.isValid
                        + '^ firstName : ' + PanResponse.result.firstName
                        + '^ middleName : ' + PanResponse.result.middleName
                        + '^ lastName : ' + PanResponse.result.lastName
                        + '^ title : ' + PanResponse.result.title
                        + '^ panStatus : ' + PanResponse.result.panStatus
                        + '^ panStatusCode : ' + PanResponse.result.panStatusCode
                        + '^ aadhaarSeedingStatus : ' + PanResponse.result.aadhaarSeedingStatus
                        + '^ aadhaarSeedingStatusCode : ' + PanResponse.result.aadhaarSeedingStatusCode
                        + '^ lastUpdatedOn : ' + PanResponse.result.lastUpdatedOn;

                    $.ajax({
                        type: "POST",
                        url: pageUrl + '/UpdatePanAPIStatus',
                        data: '{PanApiName: "' + PanApiName + '", AppMstid: "' + AppMstid + '", PanDetails: "' + PanDetails + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            $('#lbl_' + AppMstid).text(PanApiName);
                            $('#btn_' + AppMstid).css('color', 'green');
                            $('#btn_' + AppMstid).removeAttr('enabled');
                            $('#btn_' + AppMstid).attr('disabled', 'disabled');
                            $('#btn_' + AppMstid).val('Verified');
                            $('#LoaderImg').hide();
                        },
                        error: function (response) {
                            $('#LoaderImg').hide();
                        }
                    });

                }
            }).fail(function (response) {
                //alert(response.statusText);
                // debugger;
                //console.log("PAN API ERROR: " + response.statusText);
                $('#btn_' + AppMstid).val(response.statusText);
                $('#btn_' + AppMstid).css('color', 'red');
                $('#btn_' + AppMstid).removeAttr('enabled');
                $('#btn_' + AppMstid).attr('disabled', 'disabled');

                $('#LoaderImg').hide();
            });

        }

    </script>
</asp:Content>

