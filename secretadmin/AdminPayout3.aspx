<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AdminPayout3.aspx.cs" Inherits="admin_AdminPayout3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <h1>
        Payout List</h1>
    <hr />
    <table style="width: 100%">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <div>
                    <table width="100%">
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td colspan="4">
                                            <strong><span></span></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 16px">
                                            <span>From Date :</span>
                                            <asp:Label ID="Label1" runat="server" Text="Label" ForeColor="Black" Width="133px"
                                                Font-Bold="True" Font-Names="Arial" Font-Size="Small"></asp:Label><span> &nbsp; &nbsp;
                                                    &nbsp;&nbsp;<span><span> To Dat</span>e : </span></span>
                                            <asp:Label ID="Label2" runat="server" Text="Label" ForeColor="Black" Width="157px"
                                                Font-Bold="True" Style="text-align: left" Font-Names="Arial" Font-Size="Small"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Font-Names="Arial" Font-Size="Small"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:GridView ID="dgr" runat="server" AutoGenerateColumns="False" CssClass="mygrd"
                                                EmptyDataText="record not found.">
                                                <Columns>
                                                    <asp:BoundField DataField="Appmstid" ReadOnly="True" HeaderText="User ID"></asp:BoundField>
                                                    <asp:BoundField DataField="AppMstFName" ReadOnly="True" HeaderText="Name"></asp:BoundField>
                                                    <%--<asp:BoundField DataField="BinaryAmt" HeaderText="Binary Income"></asp:BoundField>
                                                    <asp:BoundField DataField="Cosponsor" HeaderText="Cosponsor"></asp:BoundField>--%>   
                                                 
                                                <%--<asp:BoundField DataField="FI" HeaderText="FI"></asp:BoundField>
                                                    <asp:BoundField DataField="pb" HeaderText="PB"></asp:BoundField>
                                                    <asp:BoundField DataField="pr" HeaderText="PR"></asp:BoundField>--%>

                                                     <asp:BoundField DataField="pi" HeaderText="PI"></asp:BoundField>
                                                    <asp:BoundField DataField="tf" HeaderText="Mgr"></asp:BoundField>
                                                    <asp:BoundField DataField="cf" HeaderText="Area Mgr"></asp:BoundField>
                                                    <asp:BoundField DataField="hf" HeaderText="Regional Mgr"></asp:BoundField>
                                                    <asp:BoundField DataField="ZM" HeaderText="Zonal Mgr"></asp:BoundField>
                                                    <asp:BoundField DataField="GM" HeaderText="General Mgr"></asp:BoundField>

                                                     <asp:BoundField DataField="MG1" HeaderText="Magic1" ReadOnly="true" />
                                                    <asp:BoundField DataField="MG2" HeaderText="Magic2" ReadOnly="true" />
                                                    <asp:BoundField DataField="MG3" HeaderText="Magic3"></asp:BoundField>
                                                    <asp:BoundField DataField="MG4" HeaderText="Magic4"></asp:BoundField>

                                                  <%--<asp:BoundField DataField="leadershipamt" HeaderText="PI"></asp:BoundField>
                                                    <asp:BoundField DataField="GrowthAmt" HeaderText="PB"></asp:BoundField>
                                                    <asp:BoundField DataField="RoyaltyIncome" HeaderText="PR"></asp:BoundField>
                                                    <asp:BoundField DataField="balanceamt" HeaderText="RB"></asp:BoundField>
                                                    <asp:BoundField DataField="Levelamt" HeaderText="BF"></asp:BoundField>
                                                    <asp:BoundField DataField="depthAmt" HeaderText="TF"></asp:BoundField>
                                                    <asp:BoundField DataField="leadershipbonusAmt" HeaderText="CF"></asp:BoundField>
                                                    <asp:BoundField DataField="directAmt" HeaderText="HF"></asp:BoundField>
                                                    --%>
                                                    <asp:BoundField DataField="totalEarning" HeaderText="Total Earning"></asp:BoundField>

                                                      <asp:BoundField DataField="gbv" HeaderText="GBV"></asp:BoundField>
                                                        <asp:BoundField DataField="pbv" HeaderText="PBV"></asp:BoundField>
                                                <%--    <asp:BoundField DataField="TDS" HeaderText="TDS"></asp:BoundField>
                                                   <asp:BoundField DataField="handlingcharges" HeaderText="Handling charges"></asp:BoundField>
                                                    <asp:BoundField DataField="Dispachedamt" ReadOnly="True" HeaderText="Dispached Amount" />--%>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>

