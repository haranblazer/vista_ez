<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="RankUpgrade.aspx.cs" 
    Inherits="secretadmin_RankUpgrade" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
    <h4 class="fs-20 font-w600  me-auto">Rank Update</h4>
    </div>



   
  <asp:UpdatePanel ID="upnl" runat="server">
            <ContentTemplate>


                    <div class="form-group row">
                        <div class="col-md-2 d-none">
                            <asp:DropDownList ID="ddl_SearchType" runat="server" CssClass="form-control"
                                AutoPostBack="true" OnSelectedIndexChanged="ddl_SearchType_SelectedIndexChanged">
                                <asp:ListItem Value="TOPPER">TOPPER</asp:ListItem>
                                <asp:ListItem Value="GENERATION">GENERATION</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-2">
                            <asp:TextBox ID="txt_userid" runat="server" placeholder="Enter UserId"
                                MaxLength="25" CssClass="form-control" AutoPostBack="true" OnTextChanged="ddl_SearchType_SelectedIndexChanged"></asp:TextBox>
                            <asp:Label ID="lbl_Username" runat="server"></asp:Label>
                        </div>

                        <div class="col-md-2">
                            <asp:DropDownList ID="ddl_Rank" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-1">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary"
                                OnClick="btnSubmit_Click" OnClientClick="return confirm('Are you sure you want to Update？')"/>
                        </div>

                    </div>

                </div>
                <div class="clearfix"></div>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>

