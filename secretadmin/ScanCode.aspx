<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="ScanCode.aspx.cs" Inherits="secretadmin_ScanCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Manual Scan </h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-sm-4">
            <%-- This txt_Userid Control can't be remove from here.--%>
            <asp:TextBox ID="txt_Userid" runat="server" Style="display: none;"></asp:TextBox>
            <asp:TextBox ID="txt_ScanCode" runat="server" CssClass="form-control" placeholder="Scan Barcode..." autocomplete="off"></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <a href="javascript:void(0)" class="btn btn-primary" onclick="GetDetails()">Search</a>
        </div>
        <div class="col-sm-2">
            <button type="button" title="Reset" class="btn btn-primary" onclick="Reset()">Reset</button>
        </div>
    </div>
    <div class="clearfix"></div>

    <div class="row">
        <div class="col-sm-12">
            <div id="div_msg" runat="server" style="font-size: large;"></div>
        </div>
    </div>
    <div class="clearfix"></div>
    <div id="div_Details" style="display: none;" class="row">


        <div class="row border p-2">
            <div class="col-md-8">
                <table class="table table-striped table-hover display dataTable nowrap cell-border">
                    <tr>
                        <td>User Id</td>
                        <td>
                            <asp:Label ID="lbl_userid" runat="server" CssClass="control-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>User Name</td>
                        <td>
                            <asp:Label ID="lbl_userName" runat="server" CssClass="control-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Scan Code</td>
                        <td>
                            <asp:Label ID="lbl_ScanCode" runat="server" CssClass="control-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Tour Name</td>
                        <td>
                            <asp:Label ID="lbl_TourName" runat="server" CssClass="control-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Qualify Date </td>
                        <td>
                            <asp:Label ID="lbl_QualifyDate" runat="server" CssClass="control-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Is Scaned </td>
                        <td>
                            <div id="div_IsScaned" runat="server"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>Scan Date</td>
                        <td>
                            <asp:Label ID="lbl_ScanDate" runat="server" CssClass="control-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Update By</td>
                        <td>
                            <asp:Label ID="lbl_UpdateBy" runat="server" CssClass="control-label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Remark</td>
                        <td>
                            <asp:TextBox ID="txt_Ramark" runat="server" CssClass="form-control" TextMode="MultiLine" Height="50px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <button type="button" id="btn_Submit" title="Submit" class="btn btn-primary" onclick="Save()">Submit</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-4">
                <div id="lbl_ProfileImg" class="mt-2"></div>
            </div>
        </div>
    </div>

  <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox-rotate.js" type="text/javascript"></script>
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var pageUrl = '<%=ResolveUrl("ScanCode.aspx")%>';
        $(function () {
            $('#<%=txt_ScanCode.ClientID%>').focus();
        });

        function Reset() {
            $('#<%=div_msg.ClientID%>').html("");
            $('#<%=txt_ScanCode.ClientID%>').val("");
            $('#<%=txt_ScanCode.ClientID%>').focus();
            $('#<%=lbl_ScanCode.ClientID%>').text('');
            $('#div_Details').hide();
        }



        function GetDetails() {

            $('#<%=div_msg.ClientID%>').html("");
            let ScanCode = $('#<%=txt_ScanCode.ClientID%>').val().trim();
            if (ScanCode == "") {
                $('#<%=div_msg.ClientID%>').html("<div class='alert alert-danger'><strong>Error!</strong> Please enter scan code.!!</div>");
                $('#div_Details').hide();
                return false;
            }
            $('#LoaderImg').show();
            $('#<%=lbl_ScanCode.ClientID%>').text('');
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDetails',
                data: '{ScanCode: "' + ScanCode + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#<%=lbl_ScanDate.ClientID%>').text("");
                    $('#<%=txt_Ramark.ClientID%>').val("");
                    $('#<%=lbl_UpdateBy.ClientID%>').text("");

                    $('#<%=txt_ScanCode.ClientID%>').val('');
                    $('#<%=lbl_ScanCode.ClientID%>').text(ScanCode);
                    $('#LoaderImg').hide();
                    if (data.d.Error == "") {
                        $('#div_Details').show(); 

                        $('#<%=lbl_userid.ClientID%>').text(data.d.AppMstRegNo);
                        $('#<%=lbl_userName.ClientID%>').text(data.d.AppMstFName);
                        $('#<%=lbl_TourName.ClientID%>').text(data.d.TourName);
                        $('#<%=lbl_QualifyDate.ClientID%>').text(data.d.Qualify_date);

                        if (data.d.imagename == "") {
                            $('#lbl_ProfileImg').html("<a href='../images/KYC/ProfileImage/noimage.png' data-fancybox='gallery'> <img src='../images/KYC/ProfileImage/noimage.png' width='200px' height='250px'> </a>");
                        }
                        else {
                            $('#lbl_ProfileImg').html("<a href='../images/KYC/ProfileImage/" + data.d.imagename + "' data-fancybox='gallery'> <img src='../images/KYC/ProfileImage/" + data.d.imagename + "' width='200px' height='250px'> </a>");
                        }


                        if (data.d.IsScaned == "0") {
                            $('#<%=div_msg.ClientID%>').html("<div class='alert alert-success'><strong>Verified!</strong> Your " + ScanCode + " scan code is genuine.!!</div>");

                            $('#<%=div_IsScaned.ClientID%>').html("<span class='dotGrey'></span>");
                            $("#btn_Submit").removeAttr('disabled');
                            $("#btn_Submit").attr('enabled', 'enabled');
                        }
                        else if (data.d.IsScaned == "1") {
                            $("#btn_Submit").removeAttr('enabled');
                            $("#btn_Submit").attr('disabled', 'disabled');

                            $('#<%=div_msg.ClientID%>').html("<div class='alert alert-danger'><strong>Error!</strong> This " + ScanCode + " scan code already used.!!</div>");

                            $('#<%=div_IsScaned.ClientID%>').html("<span class='dotGreen'></span>");
                            $('#<%=lbl_ScanDate.ClientID%>').text(data.d.Scan_date);
                            $('#<%=txt_Ramark.ClientID%>').val(data.d.Remark);
                            $('#<%=lbl_UpdateBy.ClientID%>').text(data.d.UpdateBy);
                        }
                        return false;
                    }
                    else {
                        $('#<%=div_msg.ClientID%>').html("<div class='alert alert-danger'><strong>Error!</strong> This " + ScanCode + " invalid scan code. Please try another.!!</div>");
                        $('#<%=lbl_userid.ClientID%>').text("");
                        $('#<%=lbl_userName.ClientID%>').text("");
                        $('#<%=lbl_TourName.ClientID%>').text("");
                        $('#<%=lbl_QualifyDate.ClientID%>').text("");
                        $('#<%=div_IsScaned.ClientID%>').html("");
                        $('#<%=lbl_ScanDate.ClientID%>').text("");
                        $('#<%=txt_Ramark.ClientID%>').val("");
                        $('#<%=lbl_UpdateBy.ClientID%>').text("");
                        $('#<%=lbl_ScanCode.ClientID%>').text("");
                        $('#div_Details').hide();
                        return false;
                    }

                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                    return false;
                }
            });
        }



        function Save() {
            //if (!confirm('Are you sure you want to submit？')) {
            //    return false;
            //}

            $('#<%=div_msg.ClientID%>').html("");
            let ScanCode = $('#<%=lbl_ScanCode.ClientID%>').text();
            $('#LoaderImg').show();
            $.ajax({
                type: "POST",
                url: pageUrl + '/Save',
                data: '{ScanCode: "' + ScanCode + '", Remark: "' + $('#<%=txt_Ramark.ClientID%>').val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#LoaderImg').hide();
                    if (data.d == "1") {

                        $("#btn_Submit").removeAttr('enabled');
                        $("#btn_Submit").attr('disabled', 'disabled');

                        $('#<%=div_IsScaned.ClientID%>').html("<span class='dotGreen'></span>");
                        $('#<%=lbl_ScanDate.ClientID%>').text(new Date().toLocaleDateString('en-us', { day: "numeric", month: "short", year: "numeric"  })  );
                        $('#<%=lbl_UpdateBy.ClientID%>').text("<%=UpdateBy%>");

                         
                        $('#<%=div_msg.ClientID%>').html("<div class='alert alert-success'><strong>Success!</strong> Your " + ScanCode + " code scaned & submitted successfully.!!</div>");
                        
                        $('#<%=txt_ScanCode.ClientID%>').focus();
                    }
                    else {
                        $('#<%=div_msg.ClientID%>').html("<div class='alert alert-danger'><strong>Error!</strong> " + data.d + ".!!</div>");
                    }
                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }


        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;
        }

    </script>

    <style>
        table.dataTable tbody th, table.dataTable tbody td {
            padding: 0.725rem 0.625rem;
            text-align: left;
        }

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
