<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="TleaderReport.aspx.cs" Inherits="admin_TleaderReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding-top:15px;">
        <h2 class="head">
            Team Leader List</h2>
            
            <div class="clearfix"> </div> <br />
            <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
                          Select Type:
                        </label>
        <div class="col-md-3 col-xs-9">
        <asp:DropDownList ID="ddllist" runat="server" 
            onselectedindexchanged="ddllist_SelectedIndexChanged" AutoPostBack="true" CssClass=" form-control">
        </asp:DropDownList>
        </div>

        </div>
        <div class="clearfix"> </div> <br />

        <div class="table-responsive">
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                    EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False"
                    OnPageIndexChanging="dglst_PageIndexChanging">
                    <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %></ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>

                        <asp:BoundField DataField="appmstregno" HeaderText="User ID" />
                        <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                        <asp:BoundField DataField="appmstmobile" HeaderText="Mobile" />
                        <asp:BoundField DataField="AppMstState" HeaderText="State" />
                        <asp:BoundField DataField="AppMstCity" HeaderText="City" />
                        <asp:BoundField DataField="appmstrank" HeaderText="Rank" />
                        <asp:BoundField DataField="Tlper" HeaderText="%" />
                        <asp:BoundField DataField="pbvamt" HeaderText="PPV" />
                        <asp:BoundField DataField="gbvamt" HeaderText="PBV" />
                        <asp:BoundField DataField="oldgbv" HeaderText="TPV" />
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </div>

    </div>
     <div class="clearfix"> </div> <br />
</asp:Content>
