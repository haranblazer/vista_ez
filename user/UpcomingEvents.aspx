<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="UpcomingEvents.aspx.cs" Inherits="User_UpcomingEvents" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="clearfix"></div>

    <div class="row">
        <div class="col-10">
            <h4 class="fs-20 font-w600  me-auto float-left mb-0">View Upcoming Events</h4>
        </div>
    </div>
    <div class="clearfix"></div>
    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>
    </div>
    <div class="clearfix"></div>

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
        var pageUrl = '<%=ResolveUrl("UpcomingEvents.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
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
                        let Img1 = '', Img2 = '', Img3 = '', Img4 = '', Img5 = '';
                        if (data.d[i].Img1 != "") {
                            Img1 = '<a href="../UploadAdmin/' + data.d[i].Img1 + '" data-fancybox="gallery"> <i class="fa fa-eye" title="View Image"></i> </a>';
                        }
                        if (data.d[i].Img2 != "") {
                            Img2 = '<a href="../UploadAdmin/' + data.d[i].Img2 + '" data-fancybox="gallery"> <i class="fa fa-eye" title="View Image"></i> </a>';
                        }
                        if (data.d[i].Img3 != "") {
                            Img3 = '<a href="../UploadAdmin/' + data.d[i].Img3 + '" data-fancybox="gallery"> <i class="fa fa-eye" title="View Image"></i> </a>';
                        }
                        if (data.d[i].Img4 != "") {
                            Img4 = '<a href="../UploadAdmin/' + data.d[i].Img4 + '" data-fancybox="gallery"> <i class="fa fa-eye" title="View Image"></i> </a>';
                        }
                        if (data.d[i].Img5 != "") {
                            Img5 = '<a href="../UploadAdmin/' + data.d[i].Img5 + '" data-fancybox="gallery"> <i class="fa fa-eye" title="View Image"></i> </a>';
                        }

                        json.push([(i + 1),
                        data.d[i].E_Type,
                        data.d[i].StartDate,
                        data.d[i].EndDate,
                        data.d[i].VenueName,
                        data.d[i].VenueAddress,
                        data.d[i].City,
                        data.d[i].PINCode,
                        data.d[i].District,
                        data.d[i].State,
                        data.d[i].Speakers,
                        data.d[i].Speakers1,
                        data.d[i].Speakers2,
                        data.d[i].FeeCharged,
                            data.d[i].ContactPersonsName,
                            //Img1,
                            //Img2,
                            //Img3,
                            //Img4,
                            //Img5,
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
                            { title: "Event<br> Type" },
                            { title: "Start<br> Date" },
                            { title: "End<br> Date" },
                            { title: "Venue <br> Name" },
                            { title: "Venue <br> Address" },
                            { title: "City" },
                            { title: "PIN <br> Code" },
                            { title: "District" },
                            { title: "State" },
                            { title: "Speaker-1" },
                            { title: "Speaker-2" },
                            { title: "Speaker-3" },
                            { title: "Fee <br> Charged" },
                            { title: "Host Name" },
                            //{ title: "Img1" },
                            //{ title: "Img2" },
                            //{ title: "Img3" },
                            //{ title: "Img4" },
                            //{ title: "Img5" },
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
      <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>

</asp:Content>

