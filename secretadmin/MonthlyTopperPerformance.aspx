<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="MonthlyTopperPerformance.aspx.cs" Inherits="secretadmin_MonthlyTopperPerformance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Monthly Performance</h4>
     <div class="row">
                    <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddl_Month" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
                 <div class="col-sm-2 ">
                    <asp:TextBox ID="txt_user" CssClass="form-control" placeholder="Enter User Id." runat="server">
                    </asp:TextBox>
                </div>
                 <div class="col-sm-2 ">
                    <asp:Button ID="btn_Search" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btn_Search_Click" />
                </div>
                 
               
                <div class="col-sm-2  pull-right">
                    <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                        OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                        <asp:ListItem>100</asp:ListItem>
                        <asp:ListItem>500</asp:ListItem>
                        <asp:ListItem>All</asp:ListItem>
                    </asp:DropDownList>
                </div>
                 <div class="col-sm-1">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
                </div>
                </div>

   


           
              <hr />
          
                 <div class="table-responsive">

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
                    EmptyDataText="Record not found." EmptyDataRowStyle-ForeColor="Red" AllowPaging="True"
                    OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="50" ShowFooter="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Month" DataField="Month"></asp:BoundField>
                        <asp:TemplateField HeaderText="User ID">
                            <ItemTemplate>
                                <%# Eval("[User ID]")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User Name">
                            <ItemTemplate>
                                <%# Eval("[User Name]")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:BoundField HeaderText="Mobile" DataField="Mobile"></asp:BoundField>
                        <asp:BoundField HeaderText="District" DataField="District"></asp:BoundField>
                        <asp:BoundField HeaderText="State" DataField="State"></asp:BoundField>

                        <asp:TemplateField HeaderText="TCC Matching">
                            <ItemTemplate>
                                <%# Eval("[TCC Matching]")%>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Topper Matching Income">
                            <ItemTemplate>
                                <%# Eval("[Topper Matching Income]")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Topper Reward Income">
                            <ItemTemplate>
                                <%# Eval("[Topper Reward Income]")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                         <asp:TemplateField HeaderText="Topper Fund Income">
                            <ItemTemplate>
                                <%# Eval("[Topper Fund Income]")%>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Gross Payout">
                            <ItemTemplate>
                                <%# Eval("[Gross Payout]")%>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div></div>
       
</asp:Content>

