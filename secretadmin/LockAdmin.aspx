<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" EnableEventValidation="false"
    CodeFile="LockAdmin.aspx.cs" Inherits="secureadmin_LockAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Login Access</h4>
    <div class="row">
        <div class="col-sm-2">
            <asp:TextBox ID="txt_Username" runat="server" CssClass="form-control" placeholder="Enter Username."></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txt_Name" runat="server" CssClass="form-control" placeholder="Enter Name."></asp:TextBox>
        </div>

        <div class="col-sm-2">
            <asp:TextBox ID="txt_Mobile" runat="server" CssClass="form-control" placeholder="Enter Mobile No."></asp:TextBox>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddl_UserRole" runat="server" CssClass="form-control">
            </asp:DropDownList>
        </div>
        <div class="col-sm-2">
            <button title="Search" id="btnSearch" runat="server" class="btn btn-primary" onserverclick="btnSearch_Click"
                validationgroup="Show">
                <i class="fa fa-search"></i>Search
            </button>
        </div>

        <div class="col-sm-1">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" />
        </div>
    </div>




    <div class="clearfix"></div>
    <hr />
    <div class="table-responsive">
        <table id="TABLE1" onclick="return TABLE1_onclick()" style="width: 100%;">
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True" EmptyDataText="No Data Found"
                        CssClass="table table-striped table-hover mygrd" PageSize="15" DataKeyNames="username, name, password, mobileno"
                        OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                        OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:BoundField HeaderText="ADMIN ID" DataField="srno" ReadOnly="True"></asp:BoundField>--%>
                            <asp:BoundField DataField="username" HeaderText="LoginId" ReadOnly="True"></asp:BoundField>
                            <asp:BoundField HeaderText="Admin Name" DataField="name" ReadOnly="True"></asp:BoundField>
                            <asp:BoundField DataField="admintype" HeaderText="Admin Type"></asp:BoundField>

                            <asp:BoundField DataField="RoleName" HeaderText="Role Name" ReadOnly="True"></asp:BoundField>
                            <asp:BoundField DataField="PWD" HeaderText="Password" ReadOnly="True"></asp:BoundField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Left" HeaderText="Show Price">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkStatus" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                     CommandName='SHOWPRICE'>&nbsp;<%# Eval("ShowProdPrice").ToString() == "1" ? 
                                     "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : 
                                     "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Send sms">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnSend" Text="Send sms" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                        CommandName="Send" runat="server" OnClientClick="return confirm('Are you sure you want to send sms?');" Style="color: blue;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="mobileno" HeaderText="Mobile" ReadOnly="True"></asp:BoundField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_cancelled" runat="server" Text='<%#Eval("lock") %>'></asp:Label>
                                    <asp:Image ID="imgLock" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="lock" HeaderText="Status" ReadOnly="True"></asp:BoundField>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox CssClass="radios" ID="chk1" runat="server" OnCheckedChanged="checkme"
                                        AutoPostBack="true" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox CssClass="radios" ID="chk2" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
                </td>
            </tr>

        </table>
    </div>
    <div class="col-md-12">
        <asp:Button ID="btnLock" runat="server" CssClass="btn btn-primary" Text="LOCK" OnClick="btnLock_Click" />
        &nbsp;
                    <asp:Button ID="btnUnLock" runat="server" Text="UNLOCK" CssClass="btn btn-primary"
                        OnClick="btnUnLock_Click" />
    </div>
    <div class="clearfix">
    </div>
    <br />

    <script type="text/javascript">
        $(document).ready(

            function () {

                $('.9').show();
            }
        );
    </script>
</asp:Content>
