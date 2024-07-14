<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/User/user.master"
    CodeFile="CourierEntries.aspx.cs" Inherits="User_CourierEntries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
                <h4 class="fs-20 font-w600  me-auto">Courier Details</h4>
            </div>
        </div>
        <div class="col-md-6">
            <div class="pull-right ">
                <div>
                    <button id="Button1" runat="server" class="btn btn-primary btn-sm" onserverclick="imgbtnExcel_Click">
                        <i class="fa fa-file-excel-o me-2"></i>Excel
                    </button>

                    <button id="Button3" runat="server" class="btn btn-primary btn-sm" onserverclick="imgbtnWord_Click">
                        <i class="fa fa-file-word-o me-2"></i>Word
                    </button>

                    <%--<a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-pdf-o me-2"></i>PDF</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-print me-2"></i>Print</a>--%>
                </div>
            </div>
        </div>
    </div>



    <div class="col-md-12 text-right">
        <span>
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                Width="25px" /></span><span>
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="26px" />
                </span>
    </div>
    <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
    <div class="clearfix">
    </div>
    <div class="table-responsive">
        <asp:GridView ID="GridView1" runat="server" EmptyDataText="No record found" AutoGenerateColumns="False"
            Style="width: 100%" AllowPaging="True" DataKeyNames="sno" OnPageIndexChanging="GridView1_PageIndexChanging1"
            CssClass="table table-striped table-hover mygrd" PageSize="50" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" Height="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="docketid" HeaderText="Docket Id" />
                <asp:BoundField DataField="description" HeaderText="Description" />
                <asp:BoundField DataField="couriercompany" HeaderText="Courier Company" />
                <asp:BoundField DataField="dispatcheddate" HeaderText="Dispatched Date" />
                <asp:BoundField DataField="receivedstatus" HeaderText="Status" Visible="false" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <h6>
                            <asp:Button ID="Button2" runat="server" Text='<%#Eval("receivedstatus") %>' CommandName="S"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CssClass="btn btn-primary btn-sm" /></h6>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
