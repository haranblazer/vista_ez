<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="LEVELReport.aspx.cs" Inherits="user_LEVELReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container-fluid page__heading-container">
        <div class="page__heading d-flex align-items-center">
            <div class="flex">
                <h1 class="m-0">Level Wise Report</h1>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>




    <%-- <div id="Div1" class="b2">
        <h2 style="    background: #ececec;
    font-size: 21px;
    padding: 10px; margin-top:0px;"> &nbsp; <span class="fa fa-edit"></span>&nbsp;    Level Wise Report  </h2>
             
    </div>
        <div class="clearfix"></div> <br />

        <br />--%>

    <div class="container-fluid page__container">

        <div class="panel card card-body">

            <div class="table-responsive">

                   <div class="form-group card-group-row row">
                        <label class="col-md-2 control-label">Search Level</label>
                        <div class="col-md-2">
                            <asp:TextBox ID="txt_Level" runat="server" Width="100px" CssClass="form-control">1</asp:TextBox>
                        </div>
                        <div class="col-md-1 text-left">
                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Search" OnClick="btnSearch_Click" />
                        </div>

                        <div class="col-md-5">
                            
                        </div>

                        <div class="col-md-2 text-right">
                            <asp:ImageButton ID="imgbtnExport" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExport_Click" />
                        </div>


                        <div class="clearfix"></div>
                    </div>
                    <div class="clearfix">
                    </div>


                <table class="table" cellspacing="0" style="width: 100%;">
                     
                    <tr runat="server" id="l1">
                        <td class="headingLEVEL" style="padding: 0px;">
                            <strong><span style="color: #0022af">LEVEL #<asp:Label ID="lbl_level" runat="server">0</asp:Label></span></strong>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">Total
                                <asp:Label ID="lblCount1" runat="server">0</asp:Label>
                                    </span></strong> 
                        </td>
                    </tr>
                    <tr runat="server" id="l1d">
                        <td style="padding: 0px;">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                CellPadding="4" CellSpacing="1" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="UserID">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="status" HeaderText="Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentRPV" HeaderText="Cur.RPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentGBV" HeaderText="Cur.GPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GenerationRank" HeaderText="Rank">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l1t" style="display: none">
                        <td>
                            <strong><span style="color: #C04000">TOTAL UNITS:</span></strong>
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C04000"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server" id="l2" style="padding: 0px; display: none;">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #2</span></strong> <%--<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED 
                                    <asp:Label ID="lblRequired2" runat="server" Text="Label"></asp:Label></span></strong> --%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">Total
                                <asp:Label ID="lblCount2" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <%-- <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending2" runat="server" Text="Label"></asp:Label></span></strong> --%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l2d" style="padding: 0px;  display: none;">
                        <td style="padding: 0px;">
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView2" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView2_PageIndexChanging"
                                PageSize="50" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="UserID">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="status" HeaderText="Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentRPV" HeaderText="Cur.RPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentGBV" HeaderText="Cur.GPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GenerationRank" HeaderText="Rank">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l2t" style="display: none">
                        <td>
                            <strong><span style="color: #C04000">TOTAL UNITS:</span></strong>
                            <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="#C04000"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server" id="l3">
                        <td class="headingLEVEL" style="padding: 0px;  display: none;">
                            <strong><span style="color: #0022af">LEVEL #3</span></strong> <%--<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired3" runat="server" Text="Label"></asp:Label></span></strong> --%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">Total
                                <asp:Label ID="lblCount3" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <%-- <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending3" runat="server" Text="Label"></asp:Label></span></strong> --%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l3d">
                        <td style="padding: 0px;  display: none;">
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView3" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" OnPageIndexChanging="GridView3_PageIndexChanging"
                                PageSize="500" HorizontalAlign="Center" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="UserID">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="status" HeaderText="Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentRPV" HeaderText="Cur.RPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentGBV" HeaderText="Cur.GPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GenerationRank" HeaderText="Rank">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l3t" style="display: none">
                        <td>&nbsp; <strong><span style="color: #C04000">TOTAL UNITS:</span></strong><asp:Label
                            ID="Label3" runat="server" Font-Bold="True" ForeColor="#C04000"></asp:Label>
                        </td>
                    </tr>
                    <%-- <tr runat="server" id="l4">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #4</span></strong> <%--<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired4" runat="server" Text="Label"></asp:Label></span></strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">Total
                                <asp:Label ID="lblCount4" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending4" runat="server" Text="Label"></asp:Label></span></strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l4d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView4" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView4_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                               <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="UserID">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentRPV" HeaderText="CurrentRPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentGBV" HeaderText="CurrentRPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GenerationRank" HeaderText="Rank">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l4t" style="display: none">
                        <td>
                            <strong><span style="color: #C04000">TOTAL UNITS:</span></strong><asp:Label ID="Label4"
                                runat="server" Font-Bold="True" ForeColor="#C04000"></asp:Label>
                        </td>
                    </tr>  --%>

                    <%-- <tr runat="server" id="l5">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #5</span></strong> <%-- <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired5" runat="server" Text="Label"></asp:Label></span></strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">Total
                                <asp:Label ID="lblCount5" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending5" runat="server" Text="Label"></asp:Label></span></strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l5d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView5" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView5_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                                  <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="UserID">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentRPV" HeaderText="CurrentRPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentGBV" HeaderText="CurrentRPV">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="GenerationRank" HeaderText="Rank">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l5t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:</strong></span><asp:Label ID="Label5"
                                runat="server" Font-Bold="True" ForeColor="#C04000"></asp:Label>
                        </td>
                    </tr> --%>
                    <%-- <tr runat="server" id="l6">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #6</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired6" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount6" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending6" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l6d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView6" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                               <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l6t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label6" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l7t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:</strong></span><asp:Label ID="Label7"
                                runat="server" Font-Bold="True" ForeColor="#C04000"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server" id="l7">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #7</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired7" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount7" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending7" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l7d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView7" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                             <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>


                      <tr runat="server" id="l8">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #8</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired8" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount8" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending8" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l8d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView8" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                                 <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l8t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label8" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr>




                      <tr runat="server" id="l9">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #9</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired9" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount9" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending9" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l9d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView9" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                            <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l9t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label9" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr>



                      <tr runat="server" id="l10">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #10</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired10" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount10" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending10" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l10d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView10" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                      <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l10t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label10" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr>




                      <tr runat="server" id="l11">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #11</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired11" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount11" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending11" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l11d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView11" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l11t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label11" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr>




                      <tr runat="server" id="l12">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #12</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired12" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount12" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending12" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l12d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView12" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                               <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l12t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label12" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr>





                      <tr runat="server" id="l13">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #13</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired13" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount13" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending13" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l13d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView13" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                               <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l13t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label13" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr>





                      <tr runat="server" id="l14">
                        <td class="headingLEVEL">
                            <strong><span style="color: #0022af">LEVEL #14</span></strong> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span style="color: #0022af">REQUIRED
                                    <asp:Label ID="lblRequired14" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">COUNT
                                <asp:Label ID="lblCount14" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <strong><span style="color: #0022af">PENDING
                                <asp:Label ID="lblPending14" runat="server" Text="Label"></asp:Label></span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr runat="server" id="l14d">
                        <td>
                            <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView14" runat="server" AllowPaging="true"
                                AutoGenerateColumns="False" CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center"
                                HeaderStyle-VerticalAlign="Middle" OnPageIndexChanging="GridView6_PageIndexChanging"
                                PageSize="5" Font-Size="Small" CssClass="mygrd">
                                <PagerSettings PageButtonCount="25" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="User Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fname" HeaderText="User Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile No" Visible="false">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorId" HeaderText="Sponsor Id">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SponsorName" HeaderText="Sponsor Name">
                                        <ItemStyle Width="20%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DOJ" HeaderText="Date Of Entry">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="status" HeaderText="Paid Status">
                                        <ItemStyle Width="10%" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="paiddate" HeaderText="Paid date">
                                        <ItemStyle Width="15%" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" id="l14t" style="display: none">
                        <td>
                            <span style="color: #C04000"><strong>TOTAL UNITS:<asp:Label ID="Label14" runat="server"
                                Font-Bold="True" ForeColor="#C04000"></asp:Label></strong></span>&nbsp;
                        </td>
                    </tr> --%>





                    <tr id="Tr3" runat="server">
                        <td>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
                                HeaderText="Please Check Following Problems:" ShowMessageBox="true" ShowSummary="false"
                                ValidationGroup="lv" />
                        </td>
                    </tr>
                </table>
            </div>



            <div class="clearfix"></div>
        </div>

    </div>

    </div>

          
    <script type="text/javascript">
        $(document).ready(

     function () {

         $('.3').show();
     }
    );
    </script>
</asp:Content>
