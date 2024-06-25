<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TopperRewardList.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_TopperRewardList" %>

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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Reward List</h4>
    <div class="row">
                   
                <div class="col-sm-2">
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="From"></asp:TextBox>
                </div>
               
                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy" placeholder="To"></asp:TextBox>
                </div>
              
                <div class="col-sm-2">
                    <asp:TextBox ID="ddl_Userid" runat="server" CssClass="form-control" placeholder="Enter UserId"></asp:TextBox>
                </div>
           
               
                <div class="col-sm-2" style="display:none;">
                    <asp:DropDownList ID="ddl_IsGiven" runat="server" CssClass="form-control">
                        <asp:ListItem Value="-1" Selected="True">All</asp:ListItem>
                        <asp:ListItem Value="1">Given</asp:ListItem>
                        <asp:ListItem Value="0">Not Given</asp:ListItem>
                    </asp:DropDownList>
                </div>

               
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                        <asp:ListItem Selected="True" Value="-1">All Payout</asp:ListItem>
                        <asp:ListItem  Value="1">Dispatch & Release</asp:ListItem>
                        <asp:ListItem Value="0">Hold Payout</asp:ListItem>
                        <asp:ListItem Value="2">Release</asp:ListItem>
                        
                    </asp:DropDownList>
                </div>

              
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddl_RewardRank" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>

                <div class="col-sm-1">
                <button title="Search" id="btnSearch" runat="server" class="btn btn-primary" onserverclick="btnSearch_Click"
                    validationgroup="Show">
                   Search
                </button>
                </div>
                <div class="col-sm-2 pull-right">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="26px" />
                </div>
                </div>
   
   
    <hr />
            <div class="table-responsive">
                <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
                    AutoGenerateColumns="false" DataKeyNames="Srno" PageSize="50"
                    Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" OnRowUpdating="GridView1_RowUpdating"
                    EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" ShowFooter="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Achievement Date">
                            <ItemTemplate>
                                <%#Eval("[Achievement Date]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User Id">
                            <ItemTemplate>
                                <%#Eval("[User Id]") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="User Name">
                            <ItemTemplate>
                                <%#Eval("[User Name]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <%#Eval("Status") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Payout Ref">
                            <ItemTemplate>
                                <%#Eval("[Payout Ref]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Release Amt">
                            <ItemTemplate>
                                <%#Eval("[Release Amt]") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Mobile">
                            <ItemTemplate>
                                <%#Eval("Mobile") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="District">
                            <ItemTemplate>
                                <%#Eval("District") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="State">
                            <ItemTemplate>
                                <%#Eval("State") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PAN">
                            <ItemTemplate>
                                <%#Eval("PAN") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bank">
                            <ItemTemplate>
                                <%#Eval("Bank") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Account No">
                            <ItemTemplate>
                                <%#Eval("[Account No]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="IFSC Code">
                            <ItemTemplate>
                                <%#Eval("[IFSC Code]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Match Count">
                            <ItemTemplate>
                                <%#Eval("[Match Count]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Topper PIN">
                            <ItemTemplate>
                                <%#Eval("[Topper PIN]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Achived Reward Name">
                            <ItemTemplate>
                                <%#Eval("[Achived Reward Name]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Payout Generated">
                            <ItemTemplate>
                                <%#Eval("[Payout Generated]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TDS">
                            <ItemTemplate>
                                <%#Eval("TDS") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PC Charges">
                            <ItemTemplate>
                                <%#Eval("[PC Charges]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Net Payout">
                            <ItemTemplate>
                                <%#Eval("[Net Payut]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dispatch Amount">
                            <ItemTemplate>
                                <%#Eval("[Dispatch Amount]") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Payout Status">
                            <ItemTemplate>
                                <%#Eval("[Payout Status]") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        
     
</asp:Content>


