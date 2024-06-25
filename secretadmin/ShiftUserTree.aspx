<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="ShiftUserTree.aspx.cs" Inherits="secretadmin_ShiftUserTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Shift User Tree</h4>

    <div class="row">
                   <div class="col-sm-2">
                    <asp:TextBox ID="txt_Userid" runat="server" onchange="GetUserId(this);" MaxLength="25" CssClass="form-control" placeholder="Enter User Id"></asp:TextBox>
                    <span id="spn_userid"></span>
                </div>
                <div class="col-sm-2">
                    <asp:TextBox ID="txt_SponsorId" runat="server" onchange="GetParentId(this);" MaxLength="25" CssClass="form-control" placeholder="Enter New Sponsor Id."></asp:TextBox>
                    <span id="spn_ParentId"></span>
                </div>

                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_ActionType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="NIGHT">At the night</asp:ListItem>
                        <asp:ListItem Value="IMMEDIATE">Immediate</asp:ListItem>
                    </asp:DropDownList>
                    
                </div>

                <div class="col-md-6">
                    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" OnClientClick="return Validation()" CssClass="btn btn-primary" />
                    <br />
                    <span id="lblmsg" runat="server" style="color: blue;"></span>
                </div>

                      <div class="col-sm-2">
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Select From Date" MaxLength="10"></asp:TextBox>
                    </div>

                    <div class="col-sm-2">
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Select To Date" MaxLength="10"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txt_SearchUserid" runat="server" CssClass="form-control" placeholder="Enter User Id." MaxLength="30"></asp:TextBox>
                    </div>
                 
                    <div class="col-sm-1">
                        <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary"
                            OnClick="btnSearchByDate_Click" />
                    </div>
                    <div class="col-sm-1 pull-right">
                        <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                            OnClick="imgbtnExcel_Click" />
                    </div>
                </div>


    <hr />
  

             
                <div class="table-responsive">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                        Font-Names="Arial" Font-Size="Small" PageSize="50" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging"
                        EmptyDataText="No Record Found." >
                        <Columns>
                            <asp:TemplateField HeaderText="SNo">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:BoundField HeaderText="Date" DataField="Doe" />
                            <asp:BoundField HeaderText="User Id" DataField="UserId" />
                            <asp:BoundField HeaderText="User Name" DataField="UserName" />

                            <asp:BoundField HeaderText="Change Sponsor Id" DataField="ChangeSponsorId" />
                            <asp:BoundField HeaderText="Change Sponsor Name" DataField="ChangeSponsorName" />

                            <asp:BoundField HeaderText="Curr. Sponsor Id" DataField="CurrSponsorId" />
                            <asp:BoundField HeaderText="Curr. Sponsor Name" DataField="CurrSponsorName" />

                        </Columns>
                    </asp:GridView>
                </div>

          

    <script type="text/javascript">

        function Validation() {
            var MSG = "";
            if ($('#<%=txt_Userid.ClientID %>').val() == '') {
                MSG += "\n Please Enter UserId.!!";
            }
            if ($('#<%=txt_SponsorId.ClientID %>').val() == '') {
                MSG += "\n Please Enter New Sponsor Id.!!";
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to Shift User？')) {
                return false;
            }
            $('#<%=Button1.ClientID %>').css('display', 'none');
            $('#<%=lblmsg.ClientID %>').text("Please wait while we process your shift tree.!!");

            return true;
        }

        function GetUserId(Userid) {
            Userid = Userid.value;
            if (Userid != '') {
                $.ajax({
                    type: "POST",
                    url: 'ShiftUserTree.aspx/GetUser',
                    data: '{Userid: "' + Userid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.Error == "") {
                            $('#spn_userid').text('User Name : ' + data.d.UserName);
                            $('#spn_userid').css('color', 'green');
                        }
                        else {
                            $('#spn_userid').text('User id does not exist.!!');
                            $('#spn_userid').css('color', 'red');
                        }
                    },
                    error: function (response) {
                        alert('Server error. Please try again.!!');
                    }
                });
            }
        }

        function GetParentId(Userid) {
            Userid = Userid.value;
            if (Userid != '') {
                $.ajax({
                    type: "POST",
                    url: 'ShiftUserTree.aspx/GetUser',
                    data: '{Userid: "' + Userid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.Error == "") {
                            $('#spn_ParentId').text('User Name : ' + data.d.UserName);
                            $('#spn_ParentId').css('color', 'green');
                        }
                        else {
                            $('#spn_ParentId').text('User id does not exist.!!');
                            $('#spn_ParentId').css('color', 'red');
                        }
                    },
                    error: function (response) {
                        alert('Server error. Please try again.!!');
                    }
                });
            }
        }

    </script>
</asp:Content>
