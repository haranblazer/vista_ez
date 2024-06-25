<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="BankApprovedByAdmin.aspx.cs" Inherits="secretadmin_BankApprovedByAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>

    <script type="text/javascript">
       /* function closePopup_Model() { $('#Model_Popup').hide(); }*/

        function openPopup(UserLink, userid, appmstfname, bankname, branch, acountno, ifscode, type, bankdateloaded, bankimage) {
           /* $('#Model_Popup').show();*/

             var row = UserLink.parentNode.parentNode;
            var ch = document.getElementById('<%=ddlSearch.ClientID%>').value;
            $('#lblId').text(appmstfname + "(" + userid + ")");
            $('#lblDob').text(acountno + ", D.O.E: " + bankdateloaded);
            $('#lblPan').text(bankname);
            $('#lblbranch').text(branch);
            $('#lbltype').text(type + ", IFSC Code: " + ifscode);
            
            $('#lblPanImg').html("<a href='" + bankimage + "' data-fancybox='gallery'> <img src='" + bankimage + "' style ='min-height:300px;' width='100%'> </a>");

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
    <h4 class="fs-20 font-w600 me-auto float-left mb-0">Bank Approved By Admin</h4>
    <div class="row">
        <div class="col-sm-2 col-xs-8">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search By User Id"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUserSearch" runat="server" ErrorMessage="Enter User Id."
                ForeColor="Red" Display="Dynamic" ControlToValidate="txtSearch" SetFocusOnError="true"
                ValidationGroup="pp"></asp:RequiredFieldValidator>
        </div>
        <div class="col-sm-1">
            <asp:Button ID="btnUserSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                ValidationGroup="pp" OnClick="btnUserSearch_Click" />
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlSearch" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="OnSelectedIndexChanged">
                    <asp:ListItem Value="2">Pending</asp:ListItem>
                    <asp:ListItem Value="1">Approved</asp:ListItem>
            </asp:DropDownList>
        </div>
        <%--<asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearch_Click" />--%>
        <div class="col-sm-1 col-xs-4">
            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary"
                OnClick="btncheck_Click" />
        </div>
    </div>
    <hr />
    <div class="table-responsive">
        <asp:GridView ID="GridApprovedBankDetails" runat="server" AutoGenerateColumns="False" PageSize="50" AllowPaging="true"
            EmptyDataText="No Data Found." DataKeyNames="appmstid" CssClass="table table-striped table-hover"
            OnPageIndexChanging="GridApprovedBankDetails_PageIndexChanging">
            <Columns>
                <asp:TemplateField Visible="false">
                    <HeaderTemplate>
                        <span id="cbSelectSpan">
                            <input type="checkbox" id="cbSelectAll" onclick="ShowHideDiv(this,2)" />
                            Approve all</span>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <input type="checkbox" name="ChequeSelected" class="cbSelectRoeqw" id="cbSelectRowid" onclick="ShowHideDiv(this,2)" value="<%# Eval("userid") %>"></input>
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
                        <a href="#" class="gridViewToolTip text-blue" onclick='openPopup(this,"<%# Eval("userid")%>","<%# Eval("appmstfname")%>","<%# Eval("bankname")%>","<%# Eval("branch")%>","<%# Eval("acountno")%>","<%# Eval("ifscode")%>","<%# Eval("type")%>","<%# Eval("bankdateloaded")%>","<%# Eval("bankimage","../images/KYC/BankImage/{0}")%>");return false;' data-bs-toggle='modal' data-bs-target='#Model_Popup'>View</a>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="userid" HeaderText="User ID" />--%>
                <asp:HyperLinkField DataNavigateUrlFields="userid" HeaderText="User ID" DataTextField="userid"
                    ControlStyle-ForeColor="Blue" DataNavigateUrlFormatString="Edit_Profile.aspx?n={0}" />
                <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                <asp:BoundField DataField="bankname" HeaderText="Bank Name" />
                <asp:BoundField DataField="branch" HeaderText="Branch" />
                <asp:TemplateField HeaderText="A/C No">
                    <ItemTemplate>
                        <asp:Label ID="lblbankac" runat="server" Text='<%# Eval("acountno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ifscode" HeaderText="IFSC" />
                <asp:BoundField DataField="type" HeaderText="A/C Type" />
                <asp:BoundField DataField="bankdateloaded" HeaderText="D.O.E" />
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("AppMstMobile") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- <asp:TemplateField HeaderText="Bank Image">
                    <ItemTemplate>
                        <a href="<%# Eval("bankimage","../images/KYC/BankImage/{0}") %>" data-fancybox="gallery">
                            <asp:Image ID="bankimage" runat="server" Height="50px"  Width="50px" ImageUrl='<%# Eval("bankimage","../images/KYC/BankImage/{0}") %>'/>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>
    </div>
    <div id="Model_Popup" class="modal fade show" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Bank Documents</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup_Model()"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3 pb-2">User Id</div>
                        <div class="col-sm-9 pb-2">
                            <div id="lblId"></div>
                        </div>
                        <div class="col-sm-3 pb-2">Bank Name</div>
                        <div class="col-sm-9 pb-2">
                            <div id="lblPan"></div>
                        </div>
                        <div class="col-sm-3 pb-2">Branch</div>
                        <div class="col-sm-9">
                            <div id="lblbranch"></div>
                        </div>
                        <div class="col-sm-3 pb-2">A/c No</div>
                        <div class="col-sm-9">
                            <div id="lblDob" style="width: 100%;"></div>
                        </div>
                        <div class="col-sm-3 pb-2">A/c Type</div>
                        <div class="col-sm-9">
                            <div id="lbltype" style="width: 100%;"></div>
                        </div>
                        <div class="col-sm-3 pb-2">Status</div>
                        <div class="col-sm-9">
                            <div id="lblPanStatus" style="width: 100%;"></div>
                        </div>
                        <br />
                        <div class="col-sm-12 pb-2">
                            <div id="rotate">
                               <%--<div id="click-me">Rotate image</div>--%>
                            <div id="lblPanImg" style="width: 100%;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   <%-- <script>
        var rotateDegrees = 0;
        $("#click-me").click(function () {
            rotateDegrees += 90;
            $("#rotate img").css("transform", "rotate(" + rotateDegrees + "deg)");
        });
    </script>--%>
</asp:Content>
