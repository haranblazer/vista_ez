<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="MonthlyAchiever.aspx.cs" Inherits="secretadmin_MonthlyAchiever" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function showHide() {
            // var ele = document.getElementById("panlID1");

            //            var control = document.getElementById("panlID1");
            document.getElementById("<%=panlID1.ClientID %>").selectedIndex = 0;
            document.getElementById("<%=panlID1.ClientID %>").style.visibility = "hidden";
            document.getElementById("<%=RequiredFieldValidator2.ClientID %>").style.visibility = "hidden";

            //            control.style.visibility = "hidden";
            //            alert("dfjdskjf");


        }
    </script>
    <style type="text/css">
        tr, td, th
        {
            text-align: center;
            padding: 5px 10px;
            line-height: 30px;
        }
        .funds
        {
            text-align: center;
        }
        .top
        {
            background: #f2f2f2;
            color: #000;
            font-weight: bold;
        }
        .funds tr td
        {
            padding: 15px 75px;
            border-bottom: 3px solid #fff;
            font-weight: bold;
        }
        .funds tr td a
        {
            color: Black;
        }
    </style>
    <div class="container">
        <div class="row">
            <br />
            <div style="padding-top: 10px;">
                <h2 class="head">
                    Add Monthly Achievers</h2>
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-2">
                    Select Month</div>
                <div class="col-sm-4">
                    <asp:DropDownList ID="ddlmonth" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlmonth_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="form-group">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-6">
                    <center>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <a href='MonthlyAchiever.aspx?rk=<%#Eval("tlper") %>'>
                                                <%#Eval("rank") %></a>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:Repeater>
                    </center>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="form-group">
                <div class="col-sm-2">
                    User ID
                </div>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtuserid" runat="server" CssClass="form-control"></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter User ID "
                        SetFocusOnError="true" ForeColor="Red" ControlToValidate="txtuserid" ValidationGroup="c"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="col-sm-6">
                    <asp:Button ID="Button2" runat="server" Text="Show Rank" OnClick="Button2_Click"
                        CssClass="btn btn-success pull-right" ValidationGroup="c" />
                    <asp:Label ID="lblcurrentrank" runat="server" Style="color: Red"></asp:Label>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-sm-2">
                    Rank
                </div>
                <div class="col-sm-4">
                    <asp:DropDownList ID="ddluserrank" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Rank."
                        SetFocusOnError="true" Display="Dynamic" ForeColor="Red" ControlToValidate="ddluserrank"
                        InitialValue="0" ValidationGroup="a"></asp:RequiredFieldValidator>
                </div>
                <div class="clearfix">
                </div>
                <br />
                <div class="col-sm-6">
                    <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-success pull-right"
                        OnClick="Button1_Click" ValidationGroup="a" />
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="table-responsive">
                <asp:GridView ID="grd" runat="server" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                    OnPageIndexChanging="grd_PageIndexChanging" EmptyDataText="No Data Found." Width="100%"
                    CssClass="table table-striped table-hover mygrd" Style="font-weight: bold" OnRowCommand="grd_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="AppMstRegNo" HeaderText="Code" HeaderStyle-CssClass="top" />
                        <asp:BoundField DataField="AppMstFName" HeaderText="Name" HeaderStyle-CssClass="top" />
                        <asp:BoundField DataField="AppMstCity" HeaderText="City" HeaderStyle-CssClass="top" />
                        <asp:BoundField DataField="rank" HeaderText="Level" HeaderStyle-CssClass="top" />
                        <asp:TemplateField HeaderText="Image" HeaderStyle-CssClass="top">
                            <ItemTemplate>
                                <asp:Image ID="img" runat="server" ImageUrl='<%# Eval("imagename","~/user/ProfileImage/{0}") %>'
                                    Style="width: 50px; height: 50px"></asp:Image>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkPaid" runat="server" Text="Edit" CommandArgument='<%# Eval("ID") %>'
                                    CommandName="PAID" Font-Bold="true"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <div id="panlID1" runat="server" visible="false" style="margin-left: 20%; overflow: auto;
        background-color: #fff; border-radius: 5px; -moz-border-radius: 5px; position: absolute;
        width: 300px; padding: 12px; z-index: 5px; top: 0px; border: solid 5px #013a77;">
        <table class="table table-striped table-hover">
            <tr>
                <td colspan="2" align="left" style="font-size: 12px; font-weight: bold;">
                    Rank Detail
                    <hr />
                </td>
            </tr>
            <tr>
                <td>
                    User Id :
                </td>
                <td>
                    <asp:Label ID="lbl_Userid" runat="server" Width="150px" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Current rank
                </td>
                <td>
                    <asp:Label ID="lblusercurrentrank" runat="server" Width="150px" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <%-- <tr>
                <td>
                    User Name :
                </td>
                <td style="color: #3333CC;">
                    <asp:Label ID="lbl_UName" runat="server" Width="150px" Font-Bold="true"></asp:Label>
                </td>
            </tr>--%>
            <%-- <tr>
                <td>
                    Select Date :
                </td>
                <td>
                    <asp:DropDownList ID="ddlmonthupdate" runat="server" Width="220px">
                    </asp:DropDownList>
                </td>
            </tr>--%>
            <tr>
                <td>
                </td>
                <td>
                    <asp:DropDownList ID="ddlupgraderank" runat="server">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Select rank "
                        ControlToValidate="ddlupgraderank" InitialValue="0" ValidationGroup="b"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="RaiseDisputetxt" runat="server" Text="SUBMIT" CssClass="btn" OnClientClick="if (!confirm('Are you sure ?')) return false;"
                        ValidationGroup="b" OnClick="RaiseDisputetxt_Click" />
                    <input type='button' id='hideshow' onclick="return showHide();" value='Skip' />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
</asp:Content>
