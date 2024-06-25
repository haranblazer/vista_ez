<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="NotApproveDoc.aspx.cs" Inherits="secretadmin_NotApproveDoc"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script type="text/javascript">
        function ConfirmMessage() {

            var msg = confirm("Are you sure want to send a message to this user?");
            if (msg == true) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
    <asp:UpdatePanel ID="upWall" runat="server" ChildrenAsTriggers="true" UpdateMode="conditional">
        <ContentTemplate>
             <h4 class="fs-20 font-w600  me-auto float-left mb-0">Not Approve Docs</h4>
           <div class="row">
                    <label for="MainContent_myForm_txtCcode" class="col-sm-1 control-label">
                    <strong><span>Paging</span></strong>
                </label>
                <div class="col-sm-2">
                    <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                        OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                        <asp:ListItem>100</asp:ListItem>
                        <asp:ListItem>All</asp:ListItem>
                    </asp:DropDownList>
                </div>
               
                <div class="col-sm-3">
                  
                        <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control" placeholder="Search By User Id"></asp:TextBox>
                   
                
                  
                </div>
                <div class="col-sm-2">
                    <button id="btnGo" runat="server" class="btn btn-primary" title="Go" onserverclick="btnGo_Click">
                        <strong>Go</strong> &nbsp;<i class="fa fa-arrow-right" aria-hidden="true"></i>
                    </button>
                </div>
                <div class="col-xs-6 col-sm-3 text-right pull-right">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="26px" />
                </div>
                </div>


          
         
            <div class="clearfix">
            </div>
            <br />
            <div class="table-responsive">
                <asp:Label ID="lblCount" runat="server" Font-Bold="True"></asp:Label>
                <asp:GridView ID="GridNotApproveDoc" runat="server" AutoGenerateColumns="False" AllowPaging="True"
                    EmptyDataText="No Data Found." CssClass="table table-striped table-hover" OnPageIndexChanging="GridNotApproveDoc_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="userid" HeaderText="User ID" />
                        <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                        <asp:BoundField DataField="appmstmobile" HeaderText="Mobile No." />
                        <asp:TemplateField HeaderText="Message Box">
                            <ItemTemplate>
                                <asp:TextBox ID="txtMsg" runat="server" CssClass="form-control" Style="max-width: 240px;
                                    min-width: 180px" TextMode="MultiLine" placeholder="Type Your Message"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnlSend" runat="server" CssClass="btn btn-success" OnClientClick="return ConfirmMessage();"
                                    OnClick="lnlSend_Click"><i class="fa fa-paper-plane" aria-hidden="true"></i>&nbsp;Send</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            </div>
            <div class="clearfix">
            </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
