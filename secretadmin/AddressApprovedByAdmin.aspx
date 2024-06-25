<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="AddressApprovedByAdmin.aspx.cs" Inherits="secretadmin_AddressApprovedByAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>


    <script type="text/javascript">

        /*function closePopup_Model() { $('#Model_Popup').hide(); }*/


        function openPopup(UserLink, userid, appmstfname, Aadharno, AppMstState, AppMstCity, AppMstMobile, DocumentdateLoaded, aadharfront, aadharback) {
           /* $('#Model_Popup').show();*/
            var row = UserLink.parentNode.parentNode;
            var ch = document.getElementById('<%=ddlSearch.ClientID%>').value;
             $('#lblId').html(appmstfname + "(" + userid + ")");
             $('#lblPan').html(Aadharno);
             $('#lblbranch').html(AppMstState + ", City: " + AppMstCity);
             $('#lbltype').html(DocumentdateLoaded);
             $('#LblPh').html(AppMstMobile);
             //$('#lblafImg').html('<img id="theImg" src="' + aadharfront + '" style="width:100%;" />');
             // $('#lblabImg').html('<img id="theImg" src="' + aadharback + '" style="width:100%;" />');
            $('#lblafImg').html("<a href='" + aadharfront + "' data-fancybox='gallery'> <img src='" + aadharfront + "' Width='450px' Height='286px'> </a>");
            $('#lblabImg').html("<a href='" + aadharback + "' data-fancybox='gallery'> <img src='" + aadharback + "' Width='450px' Height='286px'> </a>");

             //$('#lblPanImg').html("<a href='" + PANImage + "' data-fancybox='gallery'> <img src='" + PANImage + "' width='100%' height='200px'> </a>");

             var ch = document.getElementById('<%=ddlSearch.ClientID%>').value;
            if (ch == "1") {
                $('#lblPanStatus').html("Approved");
                $('#lblPanStatus').css("color", "green");
            }
            else if (ch == "2") {
                $('#lblPanStatus').html("Pending");
                $('#lblPanStatus').css("color", "blue");
            }
            else {
                $('#lblPanStatus').html("Rejected");
                $('#lblPanStatus').css("color", "red");
            }
        }
    </script>

  <%--  <style>
        .ui-widget-content {
            z-index: 100000 !important;
        }

        #Approve {
            background-color: #315787;
            color: white;
        }

        #Cancel {
            background-color: red;
            color: white;
        }
    </style>
    <script type="text/javascript">
        function ConfirmMsg() {
            var msg = confirm("Are you sure to submit?");
            if (msg == true) {
                return true;
            }
            else {
                return false;
            }
        }


        function openPopup(UserLink, userid, appmstfname, Aadharno, AppMstState, AppMstCity, AppMstMobile, DocumentdateLoaded, aadharfront, aadharback) {

            var row = UserLink.parentNode.parentNode;
            var ch = document.getElementById('<%=ddlSearch.ClientID%>').value;
            $('#lblId').text(appmstfname + "(" + userid + ")");
            $('#lblPan').text(Aadharno);
            $('#lblbranch').text(AppMstState + ", City: " + AppMstCity);
            $('#lbltype').text(DocumentdateLoaded);
            $('#LblPh').text(AppMstMobile);
            $('#lblafImg').html('<img id="theImg" src="' + aadharfront + '" style="width:100%;" />');
            $('#lblabImg').html('<img id="theImg" src="' + aadharback + '" style="width:100%;" />');
            $("#popupdiv").dialog({

                title: "View User Address Details ",
                width: 500,
                height: 500,
                modal: false,
                position: {
                    my: "center top",
                    at: "center top",
                    of: window,
                    collision: "none"
                },
                buttons: [
                    {
                        id: "Approve",
                        text: "Approve!",
                        click: function () {
                            if (ch == "1") {
                                alert("Aadhar Already Approved");
                            }
                            else {
                                $.ajax({
                                    type: "POST",
                                    url: "AddressApprovedByAdmin.aspx/ApproveUserAadhar",
                                    data: '{userid: ' + userid + '}',
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (r) {
                                        debugger;
                                        if (r.d) {
                                            //Remove the row from the GridView.
                                            row.remove();
                                            //If the GridView has no records then display no records message.
                                            if ($("[id*=GridApprovedAddressDetails] td").length == 0) {
                                                $("[id*=GridApprovedAddressDetails] tbody").append("<tr><td colspan = '4' align = 'center'>No records found.</td></tr>")
                                            }
                                            alert("Aadhar Approved Successfully.");
                                            $("#popupdiv").dialog("close");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        id: "Cancel",
                        text: "Reject!",
                        click: function () {
                            $.ajax({
                                type: "POST",
                                url: "AddressApprovedByAdmin.aspx/RejectUserAadhar",
                                data: '{userid: ' + userid + '}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (r) {
                                    debugger;
                                    if (r.d) {
                                        //Remove the row from the GridView.
                                        row.remove();
                                        //If the GridView has no records then display no records message.
                                        if ($("[id*=GridApprovedAddressDetails] td").length == 0) {
                                            $("[id*=GridApprovedAddressDetails] tbody").append("<tr><td colspan = '4' align = 'center'>No records found.</td></tr>")
                                        }
                                        alert("Aadhar Rejected Successfully.");
                                        $("#popupdiv").dialog("close");
                                    }
                                }
                            });
                        }
                    }
                ]
            });

        }



        function ShowHideDiv(chkrejectApproved, tag) {

            if (tag == 1) {
                var colApproved = document.getElementById("cbSelectSpan");
                var ChildcolApproved = document.getElementById("cbSelectRowid");
                colApproved.style.display = chkrejectApproved.checked ? "none" : "block";
                chkrejectApproved.style.display = "block";
                document.getElementById("cbSelectRowid").checked = false;
            }
            else {
                var colApproved = document.getElementById("cbRejectSpan");
                colApproved.style.display = chkrejectApproved.checked ? "none" : "block";
                chkrejectApproved.style.display = "block";
                document.getElementById("cbSelectRowrejectid").checked = false;
            }
        }
    </script>--%>
    <asp:UpdatePanel ID="upWall" runat="server" ChildrenAsTriggers="true" UpdateMode="conditional">
        <ContentTemplate>
            <h4 class="fs-20 font-w600  me-auto float-left mb-0">Address Approved By
                    Admin</h4>
            <div class="row">
                <div class="col-sm-2">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search By User Id"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUserSearch" runat="server" ErrorMessage="Enter User Id."
                        ForeColor="Red" Display="Dynamic" ControlToValidate="txtSearch" SetFocusOnError="true"
                        ValidationGroup="pp"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-1">
                    <asp:Button ID="btnUserSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                        ValidationGroup="pp" OnClick="btnUserSearch_Click" />
                </div>
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddlSearch" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="OnSelectedIndexChanged">
                        <asp:ListItem Value="2">Pending</asp:ListItem>
                        <asp:ListItem Value="1">Approved</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <%--<asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"
                        OnClick="btnSearch_Click" />--%>
                <div class="col-sm-1">
                    <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary"
                        OnClick="btncheck_Click" />
                </div>
            </div>

            <hr />
            <div class="table-responsive">
                <asp:GridView ID="GridApprovedAddressDetails" runat="server" AutoGenerateColumns="False"
                    AllowPaging="true" PageSize="50" EmptyDataText="No Data Found." DataKeyNames="appmstid"
                    CssClass="table table-striped table-hover" OnPageIndexChanging="GridApprovedAddressDetails_PageIndexChanging">

                    <Columns>
                        <asp:TemplateField Visible="false">
                            <HeaderTemplate>
                                <span id="cbSelectSpan" style="display:none;">
                                    <input type="checkbox" id="cbSelectAll" onclick="ShowHideDiv(this,2)" />
                                    Approve all</span>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <input type="checkbox" name="ChequeSelected" class="cbSelectRow" id="cbSelectRowid" onclick="ShowHideDiv(this,2)"  style="display:none;" value="<%# Eval("userid") %>"></input>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <HeaderTemplate>
                                <span id="cbRejectSpan">
                                    <input type="checkbox" id="cbSelectAllrej" onclick="ShowHideDiv(this,1)" />
                                    Reject all</span>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <input type="checkbox" name="ChequeSelectedrej" class="cbSelectRowreject" id="cbSelectRowrejectid" value="<%# Eval("userid") %>" onclick="ShowHideDiv(this,1)"></input>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="View">
                            <ItemTemplate>
                                <a href="#" class="gridViewToolTip text-blue" onclick='openPopup(this,"<%# Eval("userid")%>","<%# Eval("appmstfname")%>","<%# Eval("Aadharno")%>","<%# Eval("AppMstState")%>","<%# Eval("AppMstCity")%>","<%# Eval("AppMstMobile")%>","<%# Eval("DocumentdateLoaded")%>","<%# Eval("aadharfront","../images/KYC/AadharImage/Front/{0}")%>","<%# Eval("aadharback","../images/KYC/AadharImage/Back/{0}")%>");return false;' data-bs-toggle='modal' data-bs-target='#Model_Popup'>View</a>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:HyperLinkField DataNavigateUrlFields="userid" HeaderText="User ID" DataTextField="userid"
                            ControlStyle-ForeColor="Blue" DataNavigateUrlFormatString="Edit_Profile.aspx?n={0}" />

                        <%-- <asp:BoundField DataField="userid" HeaderText="User ID" />--%>
                        <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                        <asp:TemplateField HeaderText="Mobile">
                            <ItemTemplate>
                                <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("AppMstMobile") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AppMstState" HeaderText="State" />
                        <asp:BoundField DataField="AppMstCity" HeaderText="City" />
                        <asp:BoundField DataField="Aadharno" HeaderText="Aadhar No" />
                        <asp:BoundField DataField="DocumentdateLoaded" HeaderText="D.O.E" />
                        <asp:BoundField DataField="AppMstAddress1" HeaderText="Address" />
                        <%-- <asp:TemplateField HeaderText="Aadhar Image">
                          <ItemTemplate>
                               <a href='<%# Eval("aadharfront","../images/KYC/AadharImage/Front/{0}") %>' data-fancybox="gallery">
                                    <asp:Image ID="Aadharfront" runat="server" Width="50px" Height="50px" ImageUrl='<%# Eval("aadharfront","../images/KYC/AadharImage/Front/{0}") %>' />
                                </a>
                                <a href='<%# Eval("aadharback","../images/KYC/AadharImage/Back/{0}") %>' data-fancybox="gallery">
                                    <asp:Image ID="Aadharback" runat="server" Width="50px" Height="50px" ImageUrl='<%# Eval("aadharback","../images/KYC/AadharImage/Back/{0}") %>' />
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                      
                        <%--<asp:TemplateField HeaderText="Address Image">
                            <ItemTemplate>
                                </a><a href='<%# Eval("addressimage","../KYC/AddressImage/{0}") %>' data-fancybox="gallery">
                                    <asp:Image ID="AddressImg" runat="server" Width="50px" Height="50px" ImageUrl='<%# Eval("addressimage","../KYC/AddressImage/{0}") %>' />
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
                <div id="dialog" style="display: none">
                </div>
            </div>
            <%--<div id="popupdiv" title="Basic modal dialog" style="display: none">
                <asp:HiddenField ID="hid_hitext" runat="server" />
                User Id:
                <label id="lblId"></label>
                <br />
                Aadhar No:
                <label id="lblPan"></label>
                <br />
                state:
                <label id="lblbranch"></label>
                <br />
                Mobile No:
                <label id="LblPh"></label>
                <br />
                D.O.E:
                <label id="lbltype"></label>
                <br />
                <label id="lblafImg" style="width: 100%;"></label>
                &nbsp;&nbsp;
                <label id="lblabImg" style="width: 100%;"></label>
                <br />

                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
            </div>--%>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="Model_Popup" class="modal fade show" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Aadhar Documents</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup_Model()"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3 pb-2">User Id </div>
                        <div class="col-sm-9 pb-2">
                            <div id="lblId"></div>
                        </div>
                        <div class="col-sm-3 pb-2">D.O.E</div>
                        <div class="col-sm-9 pb-2">
                            <div id="lbltype"></div>
                        </div>
                        <div class="col-sm-3 pb-2">Mobile No</div>
                        <div class="col-sm-9">
                            <div id="LblPh"></div>
                        </div>
                        <div class="col-sm-3 pb-2">Aadhar No</div>
                        <div class="col-sm-9">
                            <div id="lblPan" style="width: 100%;"></div>
                        </div>
                        <div class="col-sm-3 pb-2">State</div>
                        <div class="col-sm-9">
                            <div id="lblbranch" style="width: 100%;"></div>
                        </div>
                        <div class="col-sm-3 pb-2">Status</div>
                        <div class="col-sm-9">
                            <div id="lblPanStatus" style="width: 100%;"></div>
                        </div>
                        <br />
                        <div class="col-sm-12 pb-2">
                            <div id="lblafImg" style="width: 100%;"></div>
                        </div>
                        <div class="col-sm-12 pb-2">
                            <div id="lblabImg" style="width: 100%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
