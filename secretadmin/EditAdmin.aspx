<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="EditAdmin.aspx.cs" Inherits="admin_CreateAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .spacing {
            padding: 0 0 0 30px;
        }

        .table .tr .td {
            border: none;
        }
    </style>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Allot Permissions To Sub Admin</h4>
    </div>




    <div class="row">
        <div class="col-md-2 control-label"><b>Select Admin:</b> </div>
        <div class="col-md-3">
            <asp:DropDownList ID="ddlAdmin" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlAdmin_SelectedIndexChanged"
                Class="form-control">
            </asp:DropDownList>
        </div>
    </div>

    <div class="clearfix"></div>



    <div class="table-responsive">
        <table style="width: 100%">

            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Dashboard</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_DivDashboard" runat="server"></legend>
                        <asp:CheckBoxList ID="DivDashboard" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Members</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_Divassociates" runat="server"></legend>
                        <asp:CheckBoxList ID="Divassociates" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Payout</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_Divpayout" runat="server"></legend>
                        <asp:CheckBoxList ID="Divpayout" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">KYC</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_DivKYC" runat="server"></legend>
                        <asp:CheckBoxList ID="DivKYC" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>


            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Franchise</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_Divfranchise" runat="server">Franchise</legend>
                        <asp:CheckBoxList ID="Divfranchise" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Reports</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_DivReports" runat="server"></legend>
                        <asp:CheckBoxList ID="DivReports" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>

             <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Month Wise Reports</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_DivMonthWiseReports" runat="server"></legend>
                        <asp:CheckBoxList ID="DivMonthWiseReports" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>




            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Message Box</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_Divmessage" runat="server"></legend>
                        <asp:CheckBoxList ID="Divmessage" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Billing</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_DivEShopping" runat="server"></legend>
                        <asp:CheckBoxList ID="DivEShopping" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Product</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_Ulproduct" runat="server"></legend>
                        <asp:CheckBoxList ID="Ulproduct" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>



            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Wallet</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_Ulwallet" runat="server"></legend>
                        <asp:CheckBoxList ID="Ulwallet" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>


            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Others</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_DivMiscellaneous" runat="server"></legend>
                        <asp:CheckBoxList ID="DivMiscellaneous" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>




            <tr>
                <td>
                    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                        <h4 class="fs-20 font-w600  me-auto">Permissions</h4>
                    </div>

                </td>
            </tr>
            <tr>
                <td class="spacing">
                    <fieldset>
                        <legend id="l_DivAdminPer" runat="server"></legend>
                        <asp:CheckBoxList ID="DivAdminPer" runat="server" class="checkbox">
                        </asp:CheckBoxList>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="Button3" runat="server" Font-Bold="True" OnClick="Button1_Click"
                        Text="Allow Now" UseSubmitBehavior="False" ValidationGroup="CA" Class="btn btn-primary" />
                </td>
            </tr>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ValidationGroup="CA" ShowSummary="False" />
        </table>
    </div>

    <script type="text/javascript">
        $(document).ready(

            function () {

                $('.9').show();
            }
        );
    </script>
</asp:Content>
