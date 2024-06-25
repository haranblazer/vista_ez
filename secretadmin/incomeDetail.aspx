<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="incomeDetail.aspx.cs" Inherits="Admin_incomeDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   

   <div style="padding-top:15px;">
        <h2 class="head">
            Income Details :</h2>
        <div class="clearfix"> </div> <br />

        <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
              Enter Id:</label>
            <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="txtuserid" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            </div>
            <div class="clearfix"></div><br />
             <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label">
             </label>
            <div class="col-sm-3 col-xs-9">
              <asp:RadioButtonList ID="rdolist" runat="server" RepeatDirection="Horizontal" CssClass="form-control"
                        onselectedindexchanged="rdolist_SelectedIndexChanged">
                        <asp:ListItem Value="0" Selected="True">Reward</asp:ListItem>
                        <asp:ListItem Value="1">Payout</asp:ListItem>
                    </asp:RadioButtonList>
            </div>
            </div>  
            
             <div class="clearfix"></div><br />

             <div class="form-group">           
            <div class="col-sm-2 col-xs-3"> </div>
            <div class="col-sm-2 col-xs-3">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSubmit_Click" />
                </div>
                </div>
               <div class="clearfix"></div><br />
       <div class="table-responsive">
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <%--<td align="center" style="height: 30px; text-align: left" valign="middle">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/admin/images/excel.gif"
                        OnClick="imgbtnExcel_Click" Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/admin/images/word.jpg"
                        OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
                    <asp:ImageButton ID="imgbtnpdf" Visible="false" runat="server" ImageUrl="~/admin/images/pdf.gif"
                        OnClick="imgbtnpdf_Click" />
                </td>--%>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" style="text-align: center; valign="top">
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:GridView ID="Gridreward" runat="server" AllowPaging="True" CellPadding="4" CssClass="mygrd"
                                Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                                AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                                <footerstyle backcolor="#2881A2" font-bold="True" forecolor="White" />
                                <columns>
                                <asp:TemplateField HeaderText="Sr. NO">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="appmstregno" HeaderText="Reg No." />
                                <asp:BoundField DataField="name" HeaderText="Name" />
                                <asp:BoundField DataField="AppMstDOJ" HeaderText="DOJ" />
                                <asp:BoundField DataField="awardname" HeaderText="Reward" />
                                <asp:BoundField DataField="awardachiveddate" HeaderText="DOA" />
                                <asp:BoundField DataField="tstatus" HeaderText="Mode" />
                                <asp:BoundField DataField="comment" HeaderText="Remarks" />
                            </columns>
                            </asp:GridView>
                        </asp:Panel></ContentTemplate>
                  </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td align="center" style="text-align: center;" valign="top">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" ><ContentTemplate>
                    <asp:Panel ID="Panel2" runat="server">
                        <asp:GridView ID="Gridpayout" runat="server" AllowPaging="True" CellPadding="4" CssClass="mygrd"
                            Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                            AutoGenerateColumns="False" 
                            OnPageIndexChanging="GridView2_PageIndexChanging" 
                            onrowcommand="Gridpayout_RowCommand" DataKeyNames="payoutno,appmstid" >
                            <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sr. NO">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="appmstid" HeaderText="User id" Visible="false" />
                                 <asp:BoundField DataField="payoutno" HeaderText="Payout No" />
                                 <asp:BoundField DataField="payoutdate" HeaderText="PayOut Date" />
                                 <asp:BoundField DataField="mobile" HeaderText="Mobile No" />
                                 <asp:BoundField DataField="panno" HeaderText="PAN No" />
                                <asp:BoundField DataField="totalearning" HeaderText="Total Earning" />
                                <asp:BoundField DataField="tds" HeaderText="TDS" />
                                <asp:BoundField DataField="handlingcharges" HeaderText="Handling Charges" />
                                <asp:BoundField DataField="dispachedAmt" HeaderText="Dispatched Amount" />
                                <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnStatement" CommandName="Statement" Text="Statement" CommandArgument='<%#((GridViewRow)Container).RowIndex %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                    </ContentTemplate>
                  </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        </div>

    </div>
    <div class="clearfix"> </div> <br />
</asp:Content>
