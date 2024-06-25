<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="genology.aspx.cs" Inherits="user_genology" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        table
        {
            border-collapse: collapse;
            border-spacing: 0;
            width: 100%;
        }
        
        th, td
        {
            width: 6.6%;
            text-align: center;
            padding: 0px;
        }
        
        #table1, #table2, #table3, #table4, #table5, #table6, #table7, #table8, #table9, #table10, #table11, #table12, #table13, #table14, #table15
        {
           
            min-width: 40px;
            max-width: 400px;
            height: 40px;           
          /*  data-placement: top;*/
            data-toggle: popover;           
            z-index: 1;
            position: absolute;
            top:230px;
            display:none; 
            background-color: white; 
        }
        
        
    </style>
    <script type="text/javascript">
        $(function () {

            $('#<%=HyperLink1.ClientID%>').mouseover(function () {
                $("#table1").show();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();

            })
            $('#<%=HyperLink1.ClientID%>').mouseout(function () {
                ab();
            })
            $('#<%=HyperLink2.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").show();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink2.ClientID%>').mouseout(function () {
                ab();
            })
            $('#<%=HyperLink3.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").show();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink3.ClientID%>').mouseout(function () {
                ab();
            })

            $('#<%=HyperLink4.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").show();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink4.ClientID%>').mouseout(function () {
                ab();
            })

            $('#<%=HyperLink5.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").show();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink5.ClientID%>').mouseout(function () {
                ab();
            })

            $('#<%=HyperLink6.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").show();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink6.ClientID%>').mouseout(function () {
                ab();
            })


            $('#<%=HyperLink7.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").show();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink7.ClientID%>').mouseout(function () {
                ab();
            })

            $('#<%=HyperLink8.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").show();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink8.ClientID%>').mouseout(function () {
                ab();
            })


            $('#<%=HyperLink9.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").show();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink9.ClientID%>').mouseout(function () {
                ab();
            })


            $('#<%=HyperLink10.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").show();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink10.ClientID%>').mouseout(function () {

                ab();
            })

            $('#<%=HyperLink11.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").show();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink11.ClientID%>').mouseout(function () {

                ab();
            })

            $('#<%=HyperLink12.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").show();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink12.ClientID%>').mouseout(function () {

                ab();
            })


            $('#<%=HyperLink13.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").show();
                $("#table14").hide();
                $("#table15").hide();
            })
            $('#<%=HyperLink13.ClientID%>').mouseout(function () {

                ab();
            })

            $('#<%=HyperLink14.ClientID%>').mouseover(function () {

                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").show();
                $("#table15").hide();







            })
            $('#<%=HyperLink14.ClientID%>').mouseout(function () {
                ab();
            })


            $('#<%=HyperLink15.ClientID%>').mouseover(function () {
                $("#table1").hide();
                $("#table2").hide();
                $("#table3").hide();
                $("#table4").hide();
                $("#table5").hide();
                $("#table6").hide();
                $("#table7").hide();
                $("#table8").hide();
                $("#table9").hide();
                $("#table10").hide();
                $("#table11").hide();
                $("#table12").hide();
                $("#table13").hide();
                $("#table14").hide();
                $("#table15").show();
            })
            $('#<%=HyperLink15.ClientID%>').mouseout(function () {

                //                ab();
            })

        })
    </script>
    <script type="text/javascript">

        function ab() {


            $("#table1").hide();
            $("#table2").hide();
            $("#table3").hide();
            $("#table4").hide();
            $("#table5").hide();
            $("#table6").hide();
            $("#table7").hide();
            $("#table8").hide();
            $("#table9").hide();
            $("#table10").hide();
            $("#table11").hide();
            $("#table12").hide();
            $("#table13").hide();
            $("#table14").hide();
            $("#table15").hide();
        }
    </script>
    <div class="container">
        <div class="row">
            <div>
                <h1 class="head">
                    <i class="fa fa-sitemap" aria-hidden="true"></i>Genelogy
                </h1>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-md-1">
                    UserId:<span style="color: #CC3300">*<strong></strong></span>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="TextBox1" onkeypress="number()" runat="server" CssClass="form-control">
                    </asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" CssClass="btn btn-success" />
                    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                </div>
                <div class="clearfix">
                </div>
                <br />
            </div>
            <div class="table table-responsive">
                <table>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton1" runat="server" Enabled="False" ImageUrl="~/user_images/paid12.gif" />
                            <asp:Image ID="imgR1" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Black" Font-Bold="True"
                                CssClass="tooltip">[HyperLink1]</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
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
                            <asp:ImageButton ID="ImageButton2" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR2" runat="server" Visible="False" />
                            <asp:HyperLink ID="HyperLink2" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">Open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton3" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR3" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink3" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton4" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR4" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink4" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton5" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR5" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink5" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton6" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR6" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink6" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton7" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR7" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink7" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">open</asp:HyperLink></center>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="ImageButton8" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR8" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink8" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">open</asp:HyperLink></center>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton9" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR9" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink9" runat="server" ForeColor="Black" Visible="False" CssClass="tooltip">open</asp:HyperLink></center>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton10" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR10" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink10" runat="server" ForeColor="Black" Visible="False"
                                CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton11" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR11" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink11" runat="server" ForeColor="Black" Visible="False"
                                CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton12" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR12" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink12" runat="server" ForeColor="Black" Visible="False"
                                CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton13" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR13" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink13" runat="server" ForeColor="Black" Visible="False"
                                CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton14" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR14" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink14" runat="server" ForeColor="Black" Visible="False"
                                CssClass="tooltip">open</asp:HyperLink>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton15" runat="server" Enabled="False" ImageUrl="~/user_images/unpaid12.gif" />
                            <asp:Image ID="imgR15" runat="server" Visible="False" /><br />
                            <asp:HyperLink ID="HyperLink15" runat="server" ForeColor="Black" Visible="False"
                                CssClass="tooltip">open</asp:HyperLink>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
