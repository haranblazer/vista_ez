<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="MonthlyAchievers.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_MonthlyAchievers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Achievers List</h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
       <%-- <div class="col-md-2">--%>
            <asp:DropDownList ID="ddl_SearchType" runat="server" style="display: none;" CssClass="form-control">
                <asp:ListItem Value="TOPPER">TOPPER</asp:ListItem>
                <asp:ListItem Value="GENERATION">GENERATION</asp:ListItem>
            </asp:DropDownList>
        <%--</div>--%>

        <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                required="required"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                required="required"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txt_userid" runat="server" placeholder="Enter UserId"
                MaxLength="25" CssClass="form-control"></asp:TextBox>
        </div>

       <%-- <div class="col-md-2">--%>
            <asp:DropDownList ID="ddl_Rank" runat="server" style="display: none;" CssClass="form-control">
            </asp:DropDownList>
        <%--</div>--%>
        <div class="col-md-2">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="table-responsive">

        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
            <tfoot align="left">
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
                </tr>
            </tfoot>
        </table>
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
        var pageUrl = '<%=ResolveUrl("MonthlyAchievers.aspx")%>';
        $JDT(function () {
            BindTable();
        });

        function BindTable() {
            let min = dateFormate($('#<%=txtFromDate.ClientID%>').val()),
                max = dateFormate($('#<%=txtToDate.ClientID%>').val()),
                SearchType = $('#<%=ddl_SearchType.ClientID%>').val(),
                Userid = $('#<%=txt_userid.ClientID%>').val(),
                RankId = $('#<%=ddl_Rank.ClientID%>').val();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{ min: "' + min + '", max: "' + max + '", SearchType: "' + SearchType + '", Userid: "' + Userid + '", RankId: "' + RankId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {

                        //var id = "'" + data.d[i].id + "'";
                        //let Rank = "";
                        //let DownloadStr = ConcatinateDownload(data.d[i].id, data.d[i].imagename, SearchType, data.d[i].Rank, data.d[i].Month, data.d[i].UserName, data.d[i].State, data.d[i].District);
                         

                        json.push([i + 1,
                        data.d[i].Date,
                        data.d[i].UserId,
                        data.d[i].UserName,
                        data.d[i].Rank,
                        data.d[i].MobileNo,
                        data.d[i].District,
                        data.d[i].State,
                        data.d[i].AchievementType,
                        data.d[i].Achievement,
                        data.d[i].PaidDate,
                        data.d[i].AchivementDays,
                            '<a href="Template_MonthlyAchi.aspx?BackGroundImg=' + data.d[i].BackGroundImg + '&UN=' + data.d[i].UserName + '&State=' + data.d[i].State + '&DIST=' + data.d[i].District + '&Rank=' + SearchType + '&RN=' + data.d[i].Achievement + '&Month=' + data.d[i].Month + '&Img=' + data.d[i].imagename +'"  class="btn btn-primary"  style="padding: 0.175rem 0.687rem !important;" target="_blank"><i class="fa fa-download" aria-hidden="true"></i></a>',
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
                            { title: "Date" },
                            { title: "User Id" },
                            { title: "Use Name" },
                            { title: "Rank" },
                            { title: "Mobile No." },
                            { title: "District" },
                            { title: "State" },
                            { title: "ACHV. Type" },
                            { title: "ACHV." },
                            { title: "Paid up date" },
                            { title: "ACHV. Days" },
                            { title: "<i class='fa fa-download' aria-hidden='true'></i>" },
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
   <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
    <script type="text/javascript"> 
        function downloadimage(id) {
              
            var container = document.getElementById(id);
            html2canvas(container, {
                onrendered: function (canvas) {
                    var link = document.createElement("a");
                    document.body.appendChild(link);
                    link.download = "UserName.jpg";
                    link.href = canvas.toDataURL();
                    link.target = '_blank';
                    link.click();
                }
            }); 
        }

        function ConcatinateDownload(id, Img, Rank, RankName, Month, UserName, State, Distinct) {
            var id = "'" + id + "'";
            let DownloadStr = '';  
            DownloadStr += '<div id=' + id + ' style="width: 720px; margin: auto">';
            DownloadStr += '    <table  cellspacing="0" cellpadding="3" border="0" style="font-family: Verdana; border-collapse: collapse;">';
            DownloadStr += '       <tbody>';
            DownloadStr += '            <tr>';
            DownloadStr += '                <td style="color: Black; background-color: White;">';
            DownloadStr += '                    <table cellspacing="5" cellpadding="3" border="0">';
            DownloadStr += '                        <tbody>';
            DownloadStr += '                            <tr>';
            DownloadStr += '                                <td style="color: Black; background-color: White;">';
            DownloadStr += '                                    <div class="article">';
            DownloadStr += '                                        <div style="background-image: url(images/crown.jpg); background-repeat: no-repeat; height: 1280px; width: 720px;">';
            DownloadStr += '                                            <div style="padding-left: 157px; padding-top: 166px;">';
            DownloadStr += '                                                <table>';
            DownloadStr += '                                                    <tbody>';
            DownloadStr += '                                                        <tr>';
            DownloadStr += '                                                            <td> <img src="images/' + Img + '" style="height: 401px; width: 400px; border-width: 0px;"> </td>';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                    </tbody>';
            DownloadStr += '                                                </table>';
            DownloadStr += '                                            </div>';
            DownloadStr += '                                            <div style="padding-left: 96px; padding-top: 9px;">';
            DownloadStr += '                                                <table>';
            DownloadStr += '                                                    <tbody>';
            DownloadStr += '                                                        <tr>';
            DownloadStr += '                                                            <td colspan="2" style="text-align: center">';
            DownloadStr += '                                                                <span style="font-size: 53px; color: #151412; font-family: sans-serif;">FOR ACHIEVING</span> ';
            DownloadStr += '                                                            </td> ';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                        <tr>';
            DownloadStr += '                                                            <td colspan="2" style="text-align: center"> ';
            DownloadStr += '                                                                <div style="font-size: 55px; color: #02008d; font-weight: bold; font-family: arial; margin-top: -16px;">' + Rank + ' RANK</div>';
            DownloadStr += '                                                            </td> ';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                        <tr> ';
            DownloadStr += '                                                            <td colspan="2" style="text-align: center"> ';
            DownloadStr += '                                                                <p style="font-size: 25px; color: #161511; font-weight: bold; font-family: arial; margin: 0;"></p>';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                        </tr> ';
            DownloadStr += '                                                    </tbody>';
            DownloadStr += '                                                </table>';
            DownloadStr += '                                            </div>';
            DownloadStr += '                                            <div style="padding-left: 42px; padding-top: 55px;">';
            DownloadStr += '                                                <table>';
            DownloadStr += '                                                    <tbody> ';
            DownloadStr += '                                                        <tr>';
            DownloadStr += '                                                            <td colspan="2" style="text-align: center"> ';
            DownloadStr += '                                                                <div style="font-size: 55px; color: #0201f5; font-weight: bold; font-family: arial; margin-top: -16px;">' + RankName + '</div>';
            DownloadStr += '                                                            </td> ';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                        <tr> ';
            DownloadStr += '                                                            <td colspan="2" style="text-align: center"> ';
            DownloadStr += '                                                                <p style="font-size: 25px; color: #161511; font-weight: bold; font-family: arial; margin: 0;"></p>';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                        <tr>';
            DownloadStr += '                                                            <td></td>';
            DownloadStr += '                                                            <td style="text-align: center">';
            DownloadStr += '                                                                <div style="font-size: 39px; color: #161511;"> In The Month of ' + Month + '  </div> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                        </tr> ';
            DownloadStr += '                                                    </tbody>';
            DownloadStr += '                                                </table>';
            DownloadStr += '                                            </div>';
            DownloadStr += '                                            <div style="padding-left: 49px; padding-top: 39px;">';
            DownloadStr += '                                                <table>';
            DownloadStr += '                                                    <tbody>';
            DownloadStr += '                                                        <tr>';
            DownloadStr += '                                                            <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">Name </span> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                             <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;"> : </span> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                            <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">' + UserName + '</span>';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                         <tr>';
            DownloadStr += '                                                            <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">DIST. </span> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                              <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;"> : </span> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                            <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">' + Distinct + '</span> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                        <tr>';
            DownloadStr += '                                                            <td> ';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">STATE </span> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                             <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;"> : </span> ';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                            <td>';
            DownloadStr += '                                                                <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">' + State + '</span>';
            DownloadStr += '                                                            </td>';
            DownloadStr += '                                                        </tr>';
            DownloadStr += '                                                    </tbody>';
            DownloadStr += '                                                </table>';
            DownloadStr += '                                            </div>';
            DownloadStr += '                                        </div>';
            DownloadStr += '                                    </div>';
            DownloadStr += '                                </td> ';
            DownloadStr += '                            </tr>';
            DownloadStr += '                        </tbody>';
            DownloadStr += '                    </table>';
            DownloadStr += '                </td> ';
            DownloadStr += '            </tr>';
            DownloadStr += '        </tbody>';
            DownloadStr += '    </table> ';
            DownloadStr += '    <br>';
            DownloadStr += '</div> ';
            return DownloadStr;
        }

    </script>
     
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=PT+Sans+Narrow&family=PT+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fjalla+One&display=swap" rel="stylesheet">

    <style>
        font-family:'PT Sans', sans-serif; 
        font-family:'Fjalla One', sans-serif;
    </style>--%>
</asp:Content>

