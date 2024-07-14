<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="genology.aspx.cs" Inherits="user_genology" Title="Genology Tree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <style type="text/css">
        tr:nth-child(even)
        {
            background-color: #ffffff;
            box-shadow: none;
            border: none;
        }
        tr:nth-child(odd)
        {
            background-color: #ffffff;
            box-shadow: none;
            border: none;
        }
        #table1 tr, #table2 tr, #table3 tr, #table4 tr, #table5 tr, #table6 tr, #table7 tr, #table8 tr, #table9 tr
        {
            background-color: #ffffff;
            box-shadow: 0 10px 25px 0 rgb(50 50 93 / 7%), 0 5px 15px 0 rgb(0 0 0 / 7%);
            border: none;
        }
        @media only screen and (max-width: 520px) and (min-width: 180px)
        {               
            #table2, #table3
            {
                top: 87px !important;
                left: 0px !important;
            }
            #table2, #table3
            {
                top: 150px !important;
                left: 13px !important;
            }
            #table1
            {
                min-width: 100% !important;
                top: 200px !important;
                left: 35px !important;
            }
            #table4, #table5
            {
                top: 188px !important;
                left: 0px !important;
            }
            #table6, #table7
            {
                top: 188px !important;
                left: 0px !important;
            }
            #table7
            {
                min-width: 40px;
                max-width: 300px;
                max-height: 95px;
                data-toggle: popover;
                z-index: 9999999;
                position: absolute;
                top: 280px; /* left: 536px; */
                display: none;
            }
            #table6
            {
                min-width: 40px;
                max-width: 300px;
                max-height: 102px;
                data-toggle: popover;
                z-index: 9999999;
                position: absolute;
                top: 280px; /* left: 536px; */
                display: none;
            }        
            .gen
            {
                width: 50%;
            }
            th, td
            {
                font-size: 11px;
                color: #000;
                line-height: 1;
            }
        
        
            #table2, #table3, #table4, #table5, #table6, #table7
            {
                width: 50%;
                top: 60px;
                left: 90px;
                right: 0px;
                bottom: 0px;
            }
        
            #table8, #table9, #table10, #table11, #table12, #table13, #table14, #table15
            {
                width: 50% !important;
                bottom: 176px !important;
                left: 96px !important;
            }
        
        }
        
        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th
        {
            padding: 4px !important;
        }
        
        table
        {
            border-collapse: collapse;
            border-spacing: 0;
            width: 100%;
        }
        
        th, td
        {
            /*width: 6.6%;*/
            text-align: center;
            padding: 0px;
        }
        
        #table4, #table7,  #table10, #table11
        {
            min-width: 40px;
    width: 450px;
    max-height: 161px;
    data-toggle: popover;
    z-index: 500000000000;
    position: absolute;
    top: 220px;
    left: 285px;
    display: none;
}
       #table5  {
    min-width: 40px;
    width: 392px;
    max-height: 161px;
    data-toggle: popover;
    z-index: 500000000000;
    position: absolute;
    top: 220px;
    left: 300px;
    display: none;
}
       
        #table3
        {
            min-width: 40px;
    width: 450px;
    max-height: 161px;
    data-toggle: popover;
    z-index: 500000000000;
    position: absolute;
    top: 130px;
    right: 80px;
    display: none;
        }
        #table2
        {
           min-width: 40px;
    width: 450px;
    max-height: 161px;
    data-toggle: popover;
    z-index: 500000000000;
    position: absolute;
    top: 126px;
    left: 290px;
    display: none;
        }
        #table1
        {
           min-width: 40px;
    width: 450px;
    /* height: 40px; */
    data-toggle: popover;
    z-index: 500000000000;
    position: absolute;
    top: 36px;
    left: 540px;
    display: none;
    font-weight: 300 !important;
        }
        #table8, #table9
        {
            min-width: 40px;
            width: 300px;
            max-height: 95px;
            data-toggle: popover;
            z-index: 500000000000;
            position: absolute;
            bottom: 176px;
            left: 235px;
            display: none;
        }
        #table6, #table7 {
    min-width: 40px;
    width: 450px;
    max-height: 95px;
    data-toggle: popover;
    z-index: 500000000000;
    position: absolute;
    top: 235px;
    left: 800px;
    display: none;
}
        
        #table12, #table13
        {
            min-width: 40px;
            width: 300px;
            max-height: 95px;
            data-toggle: popover;
            z-index: 500000000000;
            position: absolute;
            bottom: 176px;
            left: 650px;
            display: none;
        }
        #table14, #table15
        {
            min-width: 40px;
            width: 300px;
            max-height: 95px;
            data-toggle: popover;
            z-index: 500000000000;
            position: absolute;
            bottom: 176px;
            left: 850px;
            display: none;
        }
    </style>
    <script type="text/javascript">
        $(function () {

            $('#<%=HyperLink1.ClientID%>').mouseover(function () {

                $("#table1").css('display', 'block');
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

                ab();
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
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">My Business  </h4>					
				</div>
   
                      <div class="form-group card-group-row row">
                        <div class="col-md-1">
                            UserId:<span style="color: #CC3300">*<strong></strong></span>
                        </div>
                        <div class="col-md-3" style="float: left;">
                            <asp:TextBox ID="TextBox1" onkeypress="number()" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-4" style="float: left;">
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" CssClass="btn btn-primary" />
                            <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="table-responsive">
                        <table>
                            <tr>
                                <td colspan="8" witdh="100%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton1" runat="server" Enabled="False" ImageUrl="images/paid12.gif" />
                                        <asp:Image ID="imgR1" runat="server" Visible="False" />
                                        <br />
                                        <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Black" Font-Bold="True"></asp:HyperLink>
                                        <br />
                                        <asp:Image ID="Image2" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen"
                                            Style="max-width: 52%;" />
                                    </center>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" width="50%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton2" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR2" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink2" runat="server" ForeColor="Black" Visible="False">Open</asp:HyperLink>
                                        <br />
                                        <asp:Image ID="Image1" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen"
                                            Style="max-width: 52%;" />
                                    </center>
                                </td>
                                <td colspan="4" width="50%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton3" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR3" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink3" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink>
                                        <br />
                                        <asp:Image ID="Image3" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen"
                                            Style="max-width: 52%;" />
                                    </center>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" width="25%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton4" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR4" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink4" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink>
                                        <br />
                                        <%--<asp:Image ID="Image4" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen" style="max-width: 50%;" />--%>
                                    </center>
                                </td>
                                <td colspan="2" width="25%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton5" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR5" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink5" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink>
                                        <br />
                                        <%--<asp:Image ID="Image5" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen" style="max-width: 50%;" />--%>
                                    </center>
                                </td>
                                <td colspan="2" width="25%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton6" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR6" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink6" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink>
                                        <br />
                                        <%--<asp:Image ID="Image6" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen" style="width: 50%;" />--%>
                                    </center>
                                </td>
                                <td colspan="2" width="25%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton7" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR7" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink7" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink>
                                        <br />
                                        <%--<asp:Image ID="Image7" runat="server" ImageUrl="images/tree3_2.gif" class="img-responsive gen" style="width: 50%;" />--%>
                                    </center>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton8" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR8" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink8" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink></center>
                                </td>
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton9" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR9" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink9" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink></center>
                                </td>
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton10" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR10" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink10" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink>
                                    </center>
                                </td>
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton11" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR11" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink11" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink>
                                    </center>
                                </td>
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton12" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR12" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink12" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink></center>
                                </td>
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton13" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR13" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink13" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink></center>
                                </td>
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton14" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR14" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink14" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink></center>
                                </td>
                                <td width="12.5%">
                                    <center>
                                        <asp:ImageButton ID="ImageButton15" runat="server" Enabled="False" ImageUrl="images/unpaid12.gif" />
                                        <asp:Image ID="imgR15" runat="server" Visible="False" /><br />
                                        <asp:HyperLink ID="HyperLink15" runat="server" ForeColor="Black" Visible="False">open</asp:HyperLink></center>
                                </td>
                            </tr>
                        </table>
                    </div>
            
</asp:Content>
