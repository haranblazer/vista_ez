<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="ScanCode.aspx.cs" Inherits="secretadmin_ScanCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Scan Event Tour </h4>
    <div id="LoaderImg" class="loader-data" style="display: none;">
        <img src="../images/preloader.gif" alt="" style="height: 200px" />
    </div>
    <div class="row">
        <div class="col-sm-4">
            <asp:TextBox ID="txt_ScanCode" runat="server" CssClass="form-control" placeholder="Enter Scan Code." MaxLength="50" 
                onchange="javascript:GetDetails()" onkeypress="return onlyNumbers(event,this);"></asp:TextBox>
        </div>
        <div class="col-sm-1">
            <button type="button" title="Search" class="btn btn-primary" onclick="GetDetails()">Search</button>
        </div>
        <div class="col-sm-2">
            <button type="button" title="Reset" class="btn btn-primary" onclick="Reset()">Reset</button>
        </div>
    </div>
    <div class="clearfix"></div>
    
    <div class="row">
        <div class="col-sm-12">
            <div id="div_msg" runat="server"></div>
        </div>

    </div>
    <div class="clearfix"></div>
    <div id="div_Details" style="display: none;" class="row">


        <div class="row border p-2">
            <div class="col-md-4">
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
                            <asp:Label ID="lbl_IsScaned" runat="server" CssClass="control-label"></asp:Label>
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
                            <asp:TextBox ID="txt_Ramark" runat="server" CssClass="form-control" TextMode="MultiLine" Height="90px"></asp:TextBox>
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
                 
               <%-- <div id="lbl_PanImg" class="mt-2"></div> 
                <div id="lbl_AadharFImg" class="mt-2"></div>--%>

            </div>
             
        </div>

    </div>


    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
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
            $.ajax({
                type: "POST",
                url: pageUrl + '/GetDetails',
                data: '{ScanCode: "' + ScanCode + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
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

                        //if (data.d.PanImage == "") {
                        //    $('#lbl_PanImg').html("<a href='../images/KYC/ProfileImage/noimage.png' data-fancybox='gallery'> <img src='../images/KYC/ProfileImage/noimage.png' width='300px' height='250px'> </a>");
                        //}
                        //else {
                        //    $('#lbl_PanImg').html("<a href='../images/KYC/PanImage/" + data.d.PanImage + "' data-fancybox='gallery'> <img src='../images/KYC/PanImage/" + data.d.PanImage + "' width='300px' height='250px'> </a>");
                        //}

                        //if (data.d.AadharFront == "") {
                        //    $('#lbl_AadharFImg').html("<a href='../images/KYC/ProfileImage/noimage.png' data-fancybox='gallery'> <img src='../images/KYC/ProfileImage/noimage.png' width='300px' height='250px'> </a>");
                        //}
                        //else {
                        //    $('#lbl_AadharFImg').html("<a href='../images/KYC/AadharImage/Front/" + data.d.AadharFront + "' data-fancybox='gallery'> <img src='../images/KYC/AadharImage/Front/" + data.d.AadharFront + "' width='300px' height='250px'> </a>");
                        //}

 
                        if (data.d.IsScaned == "0") {
                            $('#<%=div_msg.ClientID%>').html("<div class='alert alert-success'><strong>Verified!</strong> Your scan code is genuine.!!</div>");

                            $('#<%=lbl_IsScaned.ClientID%>').text("No");
                            $("#btn_Submit").removeAttr('disabled');
                            $("#btn_Submit").attr('enabled', 'enabled');
                        }
                        else if (data.d.IsScaned == "1") {
                            $("#btn_Submit").removeAttr('enabled');
                            $("#btn_Submit").attr('disabled', 'disabled');

                            $('#<%=div_msg.ClientID%>').html("<div class='alert alert-danger'><strong>Error!</strong> Your scan code already used.!!</div>");

                            $('#<%=lbl_IsScaned.ClientID%>').text("Yes");
                            $('#<%=lbl_ScanDate.ClientID%>').text(data.d.Scan_date);
                            $('#<%=txt_Ramark.ClientID%>').val(data.d.Remark);
                            $('#<%=lbl_UpdateBy.ClientID%>').text(data.d.UpdateBy);
                        }
                    }
                    else {
                        $('#<%=div_msg.ClientID%>').html("<div class='alert alert-danger'><strong>Error!</strong> Your invalid scan code. Please try another.!!</div>");
                        $('#<%=lbl_userid.ClientID%>').text("");
                        $('#<%=lbl_userName.ClientID%>').text("");
                        $('#<%=lbl_TourName.ClientID%>').text("");
                        $('#<%=lbl_QualifyDate.ClientID%>').text("");
                        $('#<%=lbl_IsScaned.ClientID%>').text("");
                        $('#<%=lbl_ScanDate.ClientID%>').text("");
                        $('#<%=txt_Ramark.ClientID%>').val("");
                        $('#<%=lbl_UpdateBy.ClientID%>').text("");
                    }

                },
                error: function (result) {
                    $('#LoaderImg').hide();
                    alert(result);
                }
            });
        }



        function Save() {

            if (!confirm('Are you sure you want to submit？')) {
                return false;
            }

            $('#<%=div_msg.ClientID%>').html("");
            let ScanCode = $('#<%=txt_ScanCode.ClientID%>').val().trim();
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
                        $('#<%=div_msg.ClientID%>').html("<div class='alert alert-success'><strong>Success!</strong> Your code scaned successfully.!!</div>");
                        $('#<%=txt_ScanCode.ClientID%>').val('');
                        $('#div_Details').hide();
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
    </style>
</asp:Content>
