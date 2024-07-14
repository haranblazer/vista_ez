<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="Reward.aspx.cs" Inherits="User_Reward" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                       <%-- <li class="breadcrumb-item"><a href="#">Schedule</a></li>--%>
                                        <li class="breadcrumb-item active" aria-current="page">Reward</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Reward</h1>
                            </div>
                           <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div>

                    <div class="container-fluid page__container">                 
         <div class="panel card card-body">
        <div class="panel panel-default">  
          
            <div class="panel-body">
        <div class="table-responsive">
            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table class="table table-bordered" style="font-size: 14px;">
                        <thead style="font-size: 16px;">
                            <th>
                                S.No
                            </th>
                               <th>
                                Reward Rank
                            </th>
                             <th>
                                Rewards
                            </th>
                              <th>
                                Status
                            </th>
                              <th>
                                Date
                            </th>
                                <th>
                                Status Delivered
                            </th>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                         <asp:Label ID="lblsrno" runat="server" Text='<%# Container.ItemIndex + 1 %>'></asp:Label>
                        </td>
                         <td>
                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("rewardrank") %>'></asp:Label>
                        </td>
                        <td>
                        <asp:Label ID="lblaward" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                        </td>
                        <td>
                          <asp:Label ID="lblstatus" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                        </td>
                        <td>
                             <asp:Label ID="lbldoe" runat="server" Text='<%#Eval("doe") %>'></asp:Label>
                        </td>
                        <td>
                        <asp:Label ID="lblgiven" runat="server" Text='<%#Eval("IsGiven") %>'></asp:Label>
                        </td>
                    </tr>
                  <%--  <tr>
                        <td>
                            1.
                        </td>
                        <td>
                            <img src="img/classroom.png" />
                            &nbsp; Personality Development Training
                        </td>
                        <td>
                            5,000 BV
                        </td>
                        <td>
                            5,000 BV
                        </td>
                        <td>
                            <asp:Label ID="lblr1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            2.
                        </td>
                        <td>
                            <img src="img/leadership.png" />
                            &nbsp; LeaderShip Development Training
                        </td>
                        <td>
                            10,000 BV
                        </td>
                        <td>
                            10,000 BV
                        </td>
                        <td>
                            <asp:Label ID="lblr2" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            3.
                        </td>
                        <td>
                            <img src="img/motor-sports.png" />
                            &nbsp; Two Wheeler Down Payment Rs. 10,000
                        </td>
                        <td>
                            60,000 BV
                        </td>
                        <td>
                            60,000 BV
                        </td>
                        <td>
                            <asp:Label ID="lblr3" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            4.
                        </td>
                        <td>
                            &nbsp;
                            <img src="img/car.png" />
                            &nbsp; Four Wheeler Down Payment Rs. 1,50,000
                        </td>
                        <td>
                            5,00,000 BV
                        </td>
                        <td>
                            5,00,000 BV
                        </td>
                        <td>
                            <asp:Label ID="lblr4" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            5.
                        </td>
                        <td>
                            <img src="img/house.png" />
                            &nbsp; House Fund Rs. 20,00,000
                        </td>
                        <td>
                            10,000,000 BV
                        </td>
                        <td>
                            10,000,000 BV
                        </td>
                        <td>
                            <asp:Label ID="lblr5" runat="server"></asp:Label>
                        </td>
                    </tr>--%>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

        </div>
        </div>
        </div>
    
    </div>
    </div>
  
</asp:Content>
