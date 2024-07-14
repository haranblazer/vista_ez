<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="AddUserEvent.aspx.cs" Inherits="User_AddUserEvent" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="clearfix"></div>

    <div class="row">
        <div class="col-10">
            <h4 class="fs-20 font-w600  me-auto float-left mb-0">Add Events</h4>
        </div>
        <div class="col-2 pull-right">
            <button type="button" title="Search" class="btn btn-primary" onclick="ShowModel()">Add Event</button>
        </div>
    </div>
    <div class="clearfix"></div>

    <div class="row">
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_Active" runat="server" CssClass="form-control">
                <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
                <asp:ListItem Value="1">Active</asp:ListItem>
                <asp:ListItem Value="2">Reject</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="BindTable()">Search</button>
        </div>
    </div>
    <div class="clearfix"></div>




    <hr />
    <div class="table-responsive">
        <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
        </table>
    </div>
    <div class="clearfix"></div>
    <asp:HiddenField ID="hnd_Id" runat="server" Value="" />


    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txt_StartDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txt_EndDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
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
        var pageUrl = '<%=ResolveUrl("AddUserEvent.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() {
            $('#LoaderImg').show();
            let Active = $('#<%=ddl_Active.ClientID %>').val();
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                data: '{Active: "' + Active + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    var json = [];
                    for (var i = 0; i < data.d.length; i++) {
                        let Status1 = '', Edit = '', Status2 = '', EditImg = '';
                        let Img1 = '', Img2 = '', Img3 = '', Img4 = '', Img5 = '';
                        if (data.d[i].Status1 == "1") {
                            Status1 = "<span class='dotGreen'></span>";
                        }
                        else if (data.d[i].Status1 == "2") {
                            Status1 = "<span class='dotRed'></span>";
                        }
                        else {
                            Status1 = "<span class='dotBlue'></span>";
                        }


                        if (data.d[i].Status2 == "1") {
                            Status2 = "<span class='dotGreen'></span>";
                        }
                        else if (data.d[i].Status2 == "2") {
                            Status2 = "<span class='dotRed'></span>";
                        }
                        else {
                            Status2 = "<span class='dotBlue'></span>";
                        }

                        if (data.d[i].Status1 == "0" && <%=Userid%> == data.d[i].SessionUserId) {
                            Edit = '<a href="javascript:void(0)"> <span style="font-size:12pt; color:Blue" onclick="Update(' + data.d[i].Eid + ',' + data.d[i].Status1 + ');"> <i class="fa fa-pencil" aria-hidden="true"></i> </span> </a>';
                        }

                        if (data.d[i].Status2 == "0" && <%=Userid%> == data.d[i].SessionUserId) {
                            EditImg = '<a href="EventImg.aspx?Eid=' + data.d[i].Eid + '"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>';
                        }

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
                            Edit,
                            Status1,
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
                        data.d[i].Remark,
                            Img1,
                            Img2,
                            Img3,
                            Img4,
                            Img5,
                        Status2 + " &nbsp;&nbsp; " + EditImg,
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
                            { title: "Edit" },
                            { title: "STS" },
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
                            { title: "Remark" },
                            { title: "Img1" },
                            { title: "Img2" },
                            { title: "Img3" },
                            { title: "Img4" },
                            { title: "Img5" },
                            { title: "Img Status" },
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


        function ShowModel() {
            $('#Popup_Event').show();
            ResetControl();
        }


        function Popup_Close() {
            $('#Popup_Event').hide();
            ResetControl();
        }


        function ResetControl() {
            $('#<%=hnd_Id.ClientID %>').val('');
            $('#<%=ddl_E_Type.ClientID %>').val('');
            $('#<%=txt_StartDate.ClientID %>').val('');
            $('#<%=txt_EndDate.ClientID %>').val('');
            $('#<%=txt_VenueName.ClientID %>').val('');
            $('#<%=txt_VenueAddress.ClientID %>').val('');
            $('#<%=txt_City.ClientID %>').val('');
            $('#<%=txt_PINCode.ClientID %>').val('');
            $('#<%=ddl_District.ClientID %>').val('');
            $('#<%=ddl_State.ClientID %>').val('');
            $('#<%=txt_Speakers.ClientID %>').val('');
            $('#<%=txt_Speakers2.ClientID %>').val('');
            $('#<%=txt_Speakers1.ClientID %>').val('');
            $('#<%=txt_FeeCharged.ClientID %>').val('');
            $('#<%=txt_ContactPersonsName.ClientID %>').val('');
        }


        function Save() {

            var MSG = "";
            let Eid = $('#<%=hnd_Id.ClientID %>').val();
            let E_Type = $('#<%=ddl_E_Type.ClientID %>').val();
            let StartDate = dateFormate($('#<%=txt_StartDate.ClientID %>').val());
            let EndDate = dateFormate($('#<%=txt_EndDate.ClientID %>').val());

            StartDate = StartDate + ' ' + $('#<%=ddl_StartHH.ClientID %>').val() + ':' + $('#<%=ddl_StartMM.ClientID %>').val() + ":00";
            EndDate = EndDate + ' ' + $('#<%=ddl_EndHH.ClientID %>').val() + ':' + $('#<%=ddl_EndMM.ClientID %>').val() + ":00";

            let VenueName = $('#<%=txt_VenueName.ClientID %>').val();
            let VenueAddress = $('#<%=txt_VenueAddress.ClientID %>').val();
            let City = $('#<%=txt_City.ClientID %>').val();
            let PINCode = $('#<%=txt_PINCode.ClientID %>').val();
            let District = $('#<%=ddl_District.ClientID%> option:selected').text();
            let State = $('#<%=ddl_State.ClientID%> option:selected').text();
            let Speakers = $('#<%=txt_Speakers.ClientID %>').val();
            let Speakers1 = $('#<%=txt_Speakers1.ClientID %>').val();
            let Speakers2 = $('#<%=txt_Speakers2.ClientID %>').val();

            let FeeCharged = $('#<%=txt_FeeCharged.ClientID %>').val();
            let ContactPersonsName = $('#<%=txt_ContactPersonsName.ClientID %>').val();
            let ContactPersonsMobile = "";


            if (E_Type == "") {
                MSG += "\n Please select event type.!!";
            }
            if (StartDate == '') {
                MSG += "\n Please select start date.!!";
            }
            if (EndDate == '') {
                MSG += "\n Please select end date.!!";
            }
            if (VenueName == '') {
                MSG += "\n Please enter venue name.!!";
            }
            if (VenueAddress == '') {
                MSG += "\n Please enter venue address.!!";
            }
            if (City == '') {
                MSG += "\n Please enter city.!!";
            }
            if (PINCode == '') {
                MSG += "\n Please enter PIN code.!!";
            }
            if (District == '') {
                MSG += "\n Please select district.!!";
            }
            if (State == '') {
                MSG += "\n Please select state.!!";
            }
            if (Speakers == '') {
                MSG += "\n Please enter at least one speaker.!!";
            }
            if (ContactPersonsName == '') {
                MSG += "\n Please enter contact persons name.!!";
            }
            if (MSG != "") {
                alert(MSG);
                return false;
            }


            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                contentType: "application/json; charset=utf-8",
                data: '{Eid: "' + Eid + '", E_Type: "' + E_Type + '", StartDate: "' + StartDate + '", EndDate: "' + EndDate
                    + '", VenueName: "' + VenueName + '", VenueAddress: "' + VenueAddress + '", City: "' + City + '", PINCode: "' + PINCode
                    + '", District: "' + District + '", State: "' + State + '", Speakers: "' + Speakers + '", Speakers1: "' + Speakers1
                    + '", Speakers2: "' + Speakers2 + '", FeeCharged: "' + FeeCharged
                    + '", ContactPersonsName: "' + ContactPersonsName + '", ContactPersonsMobile: "' + ContactPersonsMobile + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == '1') {
                        $('#Popup_Event').hide();
                        ResetControl();
                        BindTable();
                    }
                    else { alert(data.d); }
                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function Update(Eid, Status1) {

            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDetail',
                contentType: "application/json; charset=utf-8",
                data: '{Eid: "' + Eid + '"}',
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    $('#Popup_Event').show();


                    $('#<%=hnd_Id.ClientID %>').val(data.d[0].Eid);
                    $('#<%=ddl_E_Type.ClientID %>').val(data.d[0].E_Type);
                    $('#<%=txt_StartDate.ClientID %>').val(data.d[0].StartDate);
                    $('#<%=ddl_StartHH.ClientID %>').val(data.d[0].S_HOUR);
                    $('#<%=ddl_StartMM.ClientID %>').val(data.d[0].S_MINUTE);

                    $('#<%=txt_EndDate.ClientID %>').val(data.d[0].EndDate);
                    $('#<%=ddl_EndHH.ClientID %>').val(data.d[0].E_HOUR);
                    $('#<%=ddl_EndMM.ClientID %>').val(data.d[0].E_MINUTE);

                    $('#<%=txt_VenueName.ClientID %>').val(data.d[0].VenueName);
                    $('#<%=txt_VenueAddress.ClientID %>').val(data.d[0].VenueAddress);
                    $('#<%=txt_City.ClientID %>').val(data.d[0].City);
                    $('#<%=txt_PINCode.ClientID %>').val(data.d[0].PINCode);
                    $('#<%=ddl_District.ClientID %>').val(data.d[0].District);
                    $('#<%=ddl_State.ClientID %>').val(data.d[0].State);
                    $('#<%=txt_Speakers.ClientID %>').val(data.d[0].Speakers);
                    $('#<%=txt_Speakers1.ClientID %>').val(data.d[0].Speakers1);
                    $('#<%=txt_Speakers2.ClientID %>').val(data.d[0].Speakers2);

                    $('#<%=txt_FeeCharged.ClientID %>').val(data.d[0].FeeCharged);
                    $('#<%=txt_ContactPersonsName.ClientID %>').val(data.d[0].ContactPersonsName);

                    GetDistrict(data.d[0].District);

                },
                error: function (response) { $('#LoaderImg').hide(); }
            });
        }


        function GetDistrict(District) {
            $('#<%=ddl_District.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDistrict',
                data: "{'StateId':'" + $("#<%=ddl_State.ClientID%>").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=ddl_District.ClientID %>").empty().append($("<option></option>").val(0).html('Select District'));
                    PopulateControl(response.d, $("#<%=ddl_District.ClientID%>"));
                    if (District != '') {
                        $("#<%=ddl_District.ClientID%>").val(District);
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }


        function PopulateControl(list, control) {
            if (list.length > 0) {
                control.removeAttr("disabled");
                $.each(list, function () { control.append($("<option></option>").val(this['Value']).html(this['Text'])); });
            }
            else { control.empty().append('<option selected="selected" value="">Not available<option>'); }
        }


        function dateFormate(datevalue) {
            var date_arr = "";
            var newformat = "";
            date_arr = datevalue.split('/');
            if (date_arr.length > 0) { newformat = date_arr[1] + '/' + date_arr[0] + '/' + date_arr[2]; }
            if (datevalue == "") { newformat = ''; }
            return newformat;
        }

    </script>



    <div id="Popup_Event" class="modal fade show" tabindex="-1" style="padding-right: 17px; background: #000000ab; overflow-y: scroll;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content" style="overflow-y: scroll; max-height: 767px;">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;Schedule an Event</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="Popup_Close()"></button>
                </div>

                <div class="modal-body">
                    <div class="row mt-2">
                        <div class="col-md-12 row">
                            <div class="col-sm-2 control-label">Type of Event <span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="ddl_E_Type" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">Select Event</asp:ListItem>
                                    <asp:ListItem Value="FOP">FOP</asp:ListItem>
                                    <%--<asp:ListItem Value="TOP">TOP</asp:ListItem>--%>
                                    <asp:ListItem Value="Seminar">Seminar</asp:ListItem>
                                    <asp:ListItem Value="Residential programme">Residential programme</asp:ListItem>
                                    <asp:ListItem Value="Anniversary Celebration">Anniversary Celebration</asp:ListItem>
                                    <asp:ListItem Value="LDP">LDP</asp:ListItem>
                                     <asp:ListItem Value="Pre Anniversary Programme">Pre Anniversary Programme</asp:ListItem>

                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-2 control-label"></div>
                            <div class="col-sm-4"></div>

                            <div class="col-sm-2 control-label">Event Start Date<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_StartDate" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-2 control-label">Event StartTime</div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddl_StartHH" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="00" Selected="True">00</asp:ListItem>
                                    <asp:ListItem Value="01">01</asp:ListItem>
                                    <asp:ListItem Value="02">02</asp:ListItem>
                                    <asp:ListItem Value="03">03</asp:ListItem>
                                    <asp:ListItem Value="04">04</asp:ListItem>
                                    <asp:ListItem Value="05">05</asp:ListItem>
                                    <asp:ListItem Value="06">06</asp:ListItem>
                                    <asp:ListItem Value="07">07</asp:ListItem>
                                    <asp:ListItem Value="08">08</asp:ListItem>
                                    <asp:ListItem Value="09">09</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="11">11</asp:ListItem>
                                    <asp:ListItem Value="12">12</asp:ListItem>
                                    <asp:ListItem Value="13">13</asp:ListItem>
                                    <asp:ListItem Value="14">14</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="16">16</asp:ListItem>
                                    <asp:ListItem Value="17">17</asp:ListItem>
                                    <asp:ListItem Value="18">18</asp:ListItem>
                                    <asp:ListItem Value="19">19</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="21">21</asp:ListItem>
                                    <asp:ListItem Value="22">22</asp:ListItem>
                                    <asp:ListItem Value="23">23</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddl_StartMM" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="00" Selected="True">00</asp:ListItem>
                                    <asp:ListItem Value="01">01</asp:ListItem>
                                    <asp:ListItem Value="02">02</asp:ListItem>
                                    <asp:ListItem Value="03">03</asp:ListItem>
                                    <asp:ListItem Value="04">04</asp:ListItem>
                                    <asp:ListItem Value="05">05</asp:ListItem>
                                    <asp:ListItem Value="06">06</asp:ListItem>
                                    <asp:ListItem Value="07">07</asp:ListItem>
                                    <asp:ListItem Value="08">08</asp:ListItem>
                                    <asp:ListItem Value="09">09</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="11">11</asp:ListItem>
                                    <asp:ListItem Value="12">12</asp:ListItem>
                                    <asp:ListItem Value="13">13</asp:ListItem>
                                    <asp:ListItem Value="14">14</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="16">16</asp:ListItem>
                                    <asp:ListItem Value="17">17</asp:ListItem>
                                    <asp:ListItem Value="18">18</asp:ListItem>
                                    <asp:ListItem Value="19">19</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="21">21</asp:ListItem>
                                    <asp:ListItem Value="22">22</asp:ListItem>
                                    <asp:ListItem Value="23">23</asp:ListItem>
                                    <asp:ListItem Value="24">24</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="26">26</asp:ListItem>
                                    <asp:ListItem Value="27">27</asp:ListItem>
                                    <asp:ListItem Value="28">28</asp:ListItem>
                                    <asp:ListItem Value="29">29</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="31">31</asp:ListItem>
                                    <asp:ListItem Value="32">32</asp:ListItem>
                                    <asp:ListItem Value="33">33</asp:ListItem>
                                    <asp:ListItem Value="34">34</asp:ListItem>
                                    <asp:ListItem Value="35">35</asp:ListItem>
                                    <asp:ListItem Value="36">36</asp:ListItem>
                                    <asp:ListItem Value="37">37</asp:ListItem>
                                    <asp:ListItem Value="38">38</asp:ListItem>
                                    <asp:ListItem Value="39">39</asp:ListItem>
                                    <asp:ListItem Value="40">40</asp:ListItem>
                                    <asp:ListItem Value="41">41</asp:ListItem>
                                    <asp:ListItem Value="42">42</asp:ListItem>
                                    <asp:ListItem Value="43">43</asp:ListItem>
                                    <asp:ListItem Value="44">44</asp:ListItem>
                                    <asp:ListItem Value="45">45</asp:ListItem>
                                    <asp:ListItem Value="46">46</asp:ListItem>
                                    <asp:ListItem Value="47">47</asp:ListItem>
                                    <asp:ListItem Value="48">48</asp:ListItem>
                                    <asp:ListItem Value="49">49</asp:ListItem>
                                    <asp:ListItem Value="50">50</asp:ListItem>
                                    <asp:ListItem Value="51">51</asp:ListItem>
                                    <asp:ListItem Value="52">52</asp:ListItem>
                                    <asp:ListItem Value="53">53</asp:ListItem>
                                    <asp:ListItem Value="54">54</asp:ListItem>
                                    <asp:ListItem Value="55">55</asp:ListItem>
                                    <asp:ListItem Value="56">56</asp:ListItem>
                                    <asp:ListItem Value="57">57</asp:ListItem>
                                    <asp:ListItem Value="58">58</asp:ListItem>
                                    <asp:ListItem Value="59">59</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-2 control-label">Event End Date<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_EndDate" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label">Event End Time</div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddl_EndHH" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="00" Selected="True">00</asp:ListItem>
                                    <asp:ListItem Value="01">01</asp:ListItem>
                                    <asp:ListItem Value="02">02</asp:ListItem>
                                    <asp:ListItem Value="03">03</asp:ListItem>
                                    <asp:ListItem Value="04">04</asp:ListItem>
                                    <asp:ListItem Value="05">05</asp:ListItem>
                                    <asp:ListItem Value="06">06</asp:ListItem>
                                    <asp:ListItem Value="07">07</asp:ListItem>
                                    <asp:ListItem Value="08">08</asp:ListItem>
                                    <asp:ListItem Value="09">09</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="11">11</asp:ListItem>
                                    <asp:ListItem Value="12">12</asp:ListItem>
                                    <asp:ListItem Value="13">13</asp:ListItem>
                                    <asp:ListItem Value="14">14</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="16">16</asp:ListItem>
                                    <asp:ListItem Value="17">17</asp:ListItem>
                                    <asp:ListItem Value="18">18</asp:ListItem>
                                    <asp:ListItem Value="19">19</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="21">21</asp:ListItem>
                                    <asp:ListItem Value="22">22</asp:ListItem>
                                    <asp:ListItem Value="23">23</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddl_EndMM" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="00" Selected="True">00</asp:ListItem>
                                    <asp:ListItem Value="01">01</asp:ListItem>
                                    <asp:ListItem Value="02">02</asp:ListItem>
                                    <asp:ListItem Value="03">03</asp:ListItem>
                                    <asp:ListItem Value="04">04</asp:ListItem>
                                    <asp:ListItem Value="05">05</asp:ListItem>
                                    <asp:ListItem Value="06">06</asp:ListItem>
                                    <asp:ListItem Value="07">07</asp:ListItem>
                                    <asp:ListItem Value="08">08</asp:ListItem>
                                    <asp:ListItem Value="09">09</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="11">11</asp:ListItem>
                                    <asp:ListItem Value="12">12</asp:ListItem>
                                    <asp:ListItem Value="13">13</asp:ListItem>
                                    <asp:ListItem Value="14">14</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="16">16</asp:ListItem>
                                    <asp:ListItem Value="17">17</asp:ListItem>
                                    <asp:ListItem Value="18">18</asp:ListItem>
                                    <asp:ListItem Value="19">19</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="21">21</asp:ListItem>
                                    <asp:ListItem Value="22">22</asp:ListItem>
                                    <asp:ListItem Value="23">23</asp:ListItem>
                                    <asp:ListItem Value="24">24</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="26">26</asp:ListItem>
                                    <asp:ListItem Value="27">27</asp:ListItem>
                                    <asp:ListItem Value="28">28</asp:ListItem>
                                    <asp:ListItem Value="29">29</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="31">31</asp:ListItem>
                                    <asp:ListItem Value="32">32</asp:ListItem>
                                    <asp:ListItem Value="33">33</asp:ListItem>
                                    <asp:ListItem Value="34">34</asp:ListItem>
                                    <asp:ListItem Value="35">35</asp:ListItem>
                                    <asp:ListItem Value="36">36</asp:ListItem>
                                    <asp:ListItem Value="37">37</asp:ListItem>
                                    <asp:ListItem Value="38">38</asp:ListItem>
                                    <asp:ListItem Value="39">39</asp:ListItem>
                                    <asp:ListItem Value="40">40</asp:ListItem>
                                    <asp:ListItem Value="41">41</asp:ListItem>
                                    <asp:ListItem Value="42">42</asp:ListItem>
                                    <asp:ListItem Value="43">43</asp:ListItem>
                                    <asp:ListItem Value="44">44</asp:ListItem>
                                    <asp:ListItem Value="45">45</asp:ListItem>
                                    <asp:ListItem Value="46">46</asp:ListItem>
                                    <asp:ListItem Value="47">47</asp:ListItem>
                                    <asp:ListItem Value="48">48</asp:ListItem>
                                    <asp:ListItem Value="49">49</asp:ListItem>
                                    <asp:ListItem Value="50">50</asp:ListItem>
                                    <asp:ListItem Value="51">51</asp:ListItem>
                                    <asp:ListItem Value="52">52</asp:ListItem>
                                    <asp:ListItem Value="53">53</asp:ListItem>
                                    <asp:ListItem Value="54">54</asp:ListItem>
                                    <asp:ListItem Value="55">55</asp:ListItem>
                                    <asp:ListItem Value="56">56</asp:ListItem>
                                    <asp:ListItem Value="57">57</asp:ListItem>
                                    <asp:ListItem Value="58">58</asp:ListItem>
                                    <asp:ListItem Value="59">59</asp:ListItem>
                                </asp:DropDownList>
                            </div>


                            <div class="col-sm-2 control-label">Venue Name<span style="color: Red">*</span> </div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_VenueName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label">Venue Address<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_VenueAddress" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                            </div>



                            <div class="col-sm-2 control-label">State<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="ddl_State" runat="server" CssClass="form-control" onchange="GetDistrict('');">
                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-2 control-label">District<span style="color: Red">*</span> </div>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="ddl_District" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-2 control-label">City<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_City" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label">PIN Code<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_PINCode" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label">Speaker-1<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_Speakers" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label">Speaker-2</div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_Speakers1" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label">Speaker-3</div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_Speakers2" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>


                            <div class="col-sm-2 label-control ">Fee Charged</div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_FeeCharged" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label">Contact Persons Name<span style="color: Red">*</span></div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txt_ContactPersonsName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-2 control-label"></div>
                            <div class="col-sm-4">
                                <input type="button" class="btn btn-primary" onclick="Save()" value="Submit" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>


    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
            color: white;
            padding: 1px;
            text-align: center;
        }

        .dotBlue {
            height: 20px;
            width: 20px;
            background-color: blue;
            display: inline-block;
            border-radius: 50%;
            color: white;
            padding: 1px;
            text-align: center;
        }

        .dotRed {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
            color: white;
            padding: 1px;
            text-align: center;
        }

        .datepick-popup {
            z-index: 9999;
        }
    </style>
</asp:Content>

