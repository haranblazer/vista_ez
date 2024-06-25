<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AssoPackingSlip.aspx.cs"
    EnableEventValidation="false" Inherits="franchise_AssoPackingSlip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="head">
        <i class="fa fa-line-chart" aria-hidden="true"></i>&nbsp;Packing Slip</h2>
    <div class="panel panel-default" id="Div_PackageSlip">
        <div class="col-md-12">
            <div class="clearfix"></div>

            <header class="clearfix">
              <img src="../secretadmin/images/logo.png" width="250px">
               <img src="../images/billcancel.png" class="cancel" style="position: absolute; right: 0px; top: 162px;width: 95%;z-index: 0000000000;" id="imgbill" runat="server" /> 

                  
                <img src="../secretadmin/images/Packingslip.png">
             <div>

              <div class="clearfix"></div><br />
          
             
              <div id="project">
              <div class="total-bold"> <span>CIN:<asp:Label id="lbl_MainCompanyCIN" runat="server"></asp:Label> </span>  </div> 

               <div ><span>Seller: </span></div>
                <div><span>User Id: </span> <asp:Label id="lbl_Sellerid" runat="server"></asp:Label> </div>
                <div class="total-bold" style="font-size:larger;"> <asp:Label id="lbl_SellerName" runat="server" Width="100%"></asp:Label> </div>
                <div> <asp:Label id="lbl_ComAdd" runat="server"  Width="100%"></asp:Label></div>
                    <div><span>Tel : </span> <asp:Label id="lbl_ComMobileno" runat="server"></asp:Label></div>
                    <div><span>Email:</span> <asp:Label id="lbl_ComEmail" runat="server"></asp:Label> </div>
                    <br />
                <div><span>GSTIN :</span> <asp:Label id="lbl_ComGSTIN" runat="server"></asp:Label>  </div>
                <div><span>PAN :</span> <asp:Label id="lbl_ComPanNo" runat="server"></asp:Label>  </div>
                <div><span>CIN :</span> <asp:Label id="lbl_ComCIN" runat="server"></asp:Label>  </div>
                  <div><span>Invoice No. :</span> <asp:Label id="lbl_UserINVNo" runat="server"></asp:Label> </div>
                <div><span>Invoice Type :</span> <asp:Label id="lbl_UserInvType" runat="server" style="width: 55%;"></asp:Label> </div>

                <div><span>Invoice Date :</span> <asp:Label id="lbl_UserINVDate" runat="server"></asp:Label> </div>
                <div><span>PO No. :</span>  <asp:Label id="lbl_User_PO_NO" runat="server"></asp:Label>     </div>
                  <div ><span>E-Way Bill No. : </span> <asp:Label id="lbl_EwayNo" runat="server"></asp:Label>     </div>
                    <div ><span>Pay Mode :</span> <asp:Label id="lbl_PayMode" runat="server"></asp:Label>     </div>

                <div style="display:none;"><span>E-Way Bill No. : </span>    NA    </div>

                <div style="display:none;"><span>Invoice No. :</span> <asp:Label id="lbl_InvoiceNo" runat="server"></asp:Label> </div>
                <div style="display:none;"><span>Invoice Type :</span> <asp:Label id="lbl_InvType" runat="server"></asp:Label> </div>
                <div style="display:none;"><span>Invoice Date :</span> <asp:Label id="lbl_InvoiceDate" runat="server"></asp:Label> </div>
                <div style="display:none;"><span>Date PO No. :</span>  <asp:Label id="lbl_Date_PO_NO" runat="server"></asp:Label>  </div>
                
              </div>

              <div id="company" class="clearfix">

                <div ><span>Buyer: </span></div>
                <div><span>User Id: </span> <asp:Label id="lbl_Userid" runat="server"></asp:Label></div>
                <div class="total-bold"><asp:Label id="lbl_UserName" runat="server"></asp:Label></div>
                <div><asp:Label id="lbl_UserAdd" runat="server" Width="100%"></asp:Label>
                </div>
                <div><span>Tel : </span> <asp:Label id="lbl_UserMobileNo" runat="server"></asp:Label> </div>
                <div><span>Email:</span>  <asp:Label id="lbl_UserEmail" runat="server"></asp:Label> </div>
                <br />
                <div><span>GSTIN :</span> <asp:Label id="lbl_UserGSTIN" runat="server"></asp:Label> </div>
                <div><span>PAN :</span> <asp:Label id="lbl_UserPAN" runat="server"></asp:Label> </div>
                <div><span>CIN :</span> <asp:Label id="lbl_UserCIN" runat="server"></asp:Label> </div>
                 <div><span>Shipping Address : </span>   <asp:Label id="lbl_ShipingAdd" runat="server"></asp:Label>      </div>
              </div>
    </header>

            <div class="clearfix"></div>
            <hr />
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mygrd"
                    EmptyDataText="No Data Found" Width="100%" ShowFooter="true">
                    <Columns>
                        <asp:TemplateField HeaderText="Box Number">
                            <ItemTemplate>
                                <asp:TextBox ID="txt_BoxNo" runat="server" Text='<%#Eval("BoxNo") %>' CssClass="form-control"
                                    Style="border-style: none;"></asp:TextBox>
                                <asp:HiddenField ID="hdn_Pid" runat="server" Value='<%#Eval("Pid") %>' />
                                <%-- <asp:HiddenField ID="HiddenField2" runat="server" Value="<%#Eval("quantity") %>" />--%>
                                <asp:HiddenField ID="hdn_Qty" runat="server" Value='<%#Eval("quantity") %>' />
                            </ItemTemplate>
                            <FooterTemplate>Total:</FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sl No.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <%#Eval("ProductCode") %> - 
                                <asp:Label ID="lbl_productname" runat="server" Text='<%#Eval("productname") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Billed Qty" DataField="quantity" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <style>
            .clearfix:after {
                content: "";
                display: table;
                clear: both;
            }

            a {
                color: #5D6975;
                text-decoration: underline;
            }


            header {
                position: relative;
                padding: 10px 0;
                margin-bottom: 30px;
                width: 17cm;
                margin: auto;
            }

            .right-sign {
                position: absolute;
            }

            .tax-invoice {
                position: absolute;
                right: 220px;
            }

            #logo {
                text-align: center;
                margin-bottom: 10px;
            }

                #logo img {
                    width: 90px;
                }

            h1 {
                border-top: 1px solid #5D6975;
                border-bottom: 1px solid #5D6975;
                color: #5D6975;
                font-size: 2.4em;
                line-height: 1.4em;
                font-weight: normal;
                text-align: center;
                margin: 0 0 20px 0;
                background: url(dimension.png);
            }

            .total-bold {
                font-weight: bold;
            }

            #project {
                float: left;
                width: 40%;
            }

                #project span {
                    color: #5D6975;
                    text-align: left;
                    width: 90px;
                    margin-right: 10px;
                    display: inline-block;
                    font-size: 1.0em;
                    line-height: 1.5;
                }

            #company span {
                font-weight: bold;
                color: #5D6975;
                text-align: left;
                /* width: 90px;*/
                margin-right: 10px;
                display: inline-block;
                font-size: 1.0em;
                line-height: 1.5;
            }

            #company {
                float: left;
                /* text-align: right; */
                width: 40%;
                margin-left: 20%;
            }

                #project div,
                #company div {
                    /*white-space: nowrap;   */
                }

            table {
                width: 100%;
                /* border-collapse: collapse;*/
                border-spacing: 0;
                margin-bottom: 20px;
            }

                table tr td {
                    /*background: #F5F5F5;*/
                    border-bottom: 2px dotted #000;
                }

                table th,
                table td {
                    text-align: left;
                }

                table th {
                    padding: 5px;
                    color: #000;
                    border-bottom: 2px dotted #000000;
                    white-space: nowrap;
                    font-weight: normal;
                }

                table .service,
                table .desc {
                    text-align: left;
                }

                table td {
                    padding: 5px;
                    /*text-align: right;*/
                }

                    table td.service,
                    table td.desc {
                        vertical-align: top;
                    }

                    table td.unit,
                    table td.qty,
                    table td.total {
                        font-size: 1.2em;
                    }

                    table td.grand {
                        /*border-top: 1px solid #5D6975;*/
                        border-bottom: 2px dotted #000;
                    }

            #notices .notice {
                color: #5D6975;
                font-size: 1.2em;
            }

            footer {
                color: #5D6975;
                width: 100%;
                height: 30px;
                position: absolute;
                bottom: 0;
                border-top: 1px solid #C1CED9;
                padding: 8px 0;
                text-align: center;
            }

            #project span {
                font-weight: bold;
            }
        </style>
    </div>

    <asp:Button ID="btnExport" runat="server" Text="Print" OnClientClick="printDiv()" CssClass="btn btn-info" />
    &nbsp;  &nbsp;  &nbsp;  &nbsp;
         <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn btn-success" />
    <div class="clearfix">
    </div>


  <%--  <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        //$(function () {
        //    jQuery.noConflict(true);

        //});

        function printDiv() {
            var printContents = document.getElementById('Div_PackageSlip').innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>




</asp:Content>

