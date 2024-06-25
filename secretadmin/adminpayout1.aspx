<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="adminpayout1.aspx.cs" Inherits="admin_adminpayout1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <h2 class="head">
                     <i class="fa fa-list"></i>&nbsp
        Payout List</h2>
    <div class="panel panel-default">
  <div class="col-md-12">
  <div>
  <div class="form-group">
            <div class="col-md-2">
                <strong>From Date : </strong>
            </div>
            <div class="col-md-2">
               <asp:Label ID="Label1" runat="server" Text="Label" ForeColor="Black" Width="133px"
                                                Font-Bold="True" Font-Names="Arial" Font-Size="Small"></asp:Label>    </div>
        </div>
        <div class="form-group">
            <div class="col-md-2">
                <strong>To Date : </strong>
            </div>
            <div class="col-md-2">
             <asp:Label ID="Label2" runat="server" Text="Label" ForeColor="Black" Width="157px"
                                                Font-Bold="True" Style="text-align: left" Font-Names="Arial" Font-Size="Small"></asp:Label>

                                         <asp:Label ID="Label3" runat="server" Font-Names="Arial" Font-Size="Small"></asp:Label>
                                         </div>
                                         </div>
   
                          </div>               
                                    <div class="clearfix"></div>         


    
                                          <div class="table-responsive">
                                            <asp:GridView ID="dgr" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
                                                EmptyDataText="record not found." >
                                                <Columns>
                                                    <asp:BoundField DataField="Appmstid" ReadOnly="True" HeaderText="User ID"></asp:BoundField>
                                                    <asp:BoundField DataField="AppMstFName" ReadOnly="True" HeaderText="Name"></asp:BoundField>
                                                    <asp:BoundField DataField="BinaryAmt" HeaderText="Maximizer Team Bonus"></asp:BoundField>
                                                    <%--<asp:BoundField DataField="Cosponsor" HeaderText="Cosponsor"></asp:BoundField>
                                                     <asp:BoundField DataField="FI" HeaderText="FI"></asp:BoundField>
                                                    <asp:BoundField DataField="leadershipamt" HeaderText="PI"></asp:BoundField>
                                                    <asp:BoundField DataField="GrowthAmt" HeaderText="PB"></asp:BoundField>
                                                    <asp:BoundField DataField="RoyaltyIncome" HeaderText="PR"></asp:BoundField>
                                                    <asp:BoundField DataField="balanceamt" HeaderText="RB"></asp:BoundField>
                                                    <asp:BoundField DataField="Levelamt" HeaderText="BF"></asp:BoundField>
                                                    <asp:BoundField DataField="depthAmt" HeaderText="TF"></asp:BoundField>
                                                    <asp:BoundField DataField="leadershipbonusAmt" HeaderText="CF"></asp:BoundField>
                                                    <asp:BoundField DataField="directAmt" HeaderText="HF"></asp:BoundField>
                                                    --%>
                                                     <asp:BoundField DataField="directincome" HeaderText="Referral Bonus"></asp:BoundField>
                                                    <asp:BoundField DataField="totalEarning" HeaderText="Total Earning"></asp:BoundField>
                                                    <asp:BoundField DataField="TDS" HeaderText="TDS"></asp:BoundField>
                                                  <%--  <asp:BoundField DataField="handlingcharges" HeaderText="Handling charges"></asp:BoundField>--%>
                                                    <asp:BoundField DataField="Dispachedamt" ReadOnly="True" HeaderText="Dispached Amount" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
    </div>
    <div class="clearfix"></div>
    </div>
</asp:Content>
