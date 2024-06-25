<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="PackingSlip.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_PackingSlip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="head">
        <i class="fa fa-line-chart" aria-hidden="true"></i>&nbsp;Packing Slip</h2>
    <div class="panel panel-default" id="Div_PackageSlip">
        <div class="col-md-12">
            <div class="clearfix"></div>

            <header class="clearfix"> 

              <div class="clearfix"></div>
             
                <div id="project">
                    <img src="../secretadmin/images/logo.png" width="250px">
                    <div class="card-group-row row">
                     <div class="col-md-12 " style="font-weight: bold;"><span>FranchiseID : </span> <asp:Label id="lbl_Regno" runat="server"></asp:Label></div>
                   </div>
                    <div class="col-sm-12 row total-bold" style="font-size:larger;"><asp:Label id="lbl_DisplayName" runat="server" style="width:100%"></asp:Label></div>
                    <div><asp:Label id="lbl_B_Address" runat="server" style="width:100%;font-size:12px;"></asp:Label></div>
                     <div><span style="font-weight: bold;">State:</span> <asp:Label id="lbl_B_state" runat="server"></asp:Label></div>  
                    <div><span style="font-weight: bold;">Tel : </span> <asp:Label id="lbl_Phone" runat="server"></asp:Label></div>
                    <div><span style="font-weight: bold;">Email:</span> <asp:Label id="lbl_F_Email" runat="server"></asp:Label> </div>
                    <div><span style="font-weight: bold;">GSTIN :</span> <asp:Label id="lbl_GSTIN" runat="server"></asp:Label>  </div>
                    <div><span style="font-weight: bold;">PlaceofSupply :</span><asp:Label id="lbl_place_supply" runat="server"></asp:Label>  </div>
                    
                    <div><span style="font-weight: bold;">Invoice No. :</span> <asp:Label id="lbl_UserINVNo" runat="server"></asp:Label> </div>
                    <div><span style="font-weight: bold;">Invoice Date :</span> <asp:Label id="lbl_UserINVDate" runat="server"></asp:Label> </div>
                    <div><span style="font-weight: bold;">Date PO No. :</span>  <asp:Label id="lbl_User_Date_PO_NO" runat="server"></asp:Label>     </div>
                    <div><span style="font-weight: bold;">E-Way Bill No. : </span>    NA    </div>
                    <div><span style="font-weight: bold;">PAN :</span> <asp:Label id="lbl_UserPAN" runat="server"></asp:Label> </div>
                    <div><span style="font-weight: bold;">CIN :</span> <asp:Label id="lbl_UserCIN" runat="server"></asp:Label> </div>
              </div>
              

              <div id="company" class="clearfix">
                   <img src="../secretadmin/images/Packingslip.png">
                <div><span>Franchise Id: </span> <asp:Label id="lbl_Userid" runat="server" ></asp:Label></div>
                <div class="total-bold" style="font-size:larger;"><asp:Label id="lbl_UserName" runat="server" style="width:100%"></asp:Label></div>
                <div><asp:Label id="lbl_UserAdd" runat="server" style="width:100%;font-size:12px;"></asp:Label>
                </div>
                   <div><span style="font-weight: bold;">State:</span>  <asp:Label id="lbl_UserSate" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">Tel : </span> <asp:Label id="lbl_UserMobileNo" runat="server"></asp:Label> </div>
                <div><span style="font-weight: bold;">Email:</span>  <asp:Label id="lbl_UserEmail" runat="server"></asp:Label> </div>
                 <div><span style="font-weight: bold;">GSTIN :</span> <asp:Label id="lbl_UserGSTIN" runat="server"></asp:Label> </div>
                <div><b>Shipping Address : </b>   <asp:Label id="lbl_ShipingAdd" Width="100%" runat="server"></asp:Label>      </div>
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

        <div class="clearfix">
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
                /* padding: 10px 0;*/
                margin-bottom: 30px;
                width: 22cm;
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
                    width: 100px;
                    margin-right: 10px;
                    display: inline-block;
                    font-size: 1em;
                    line-height: 1.5;
                }

            #company span {
                font-weight: bold;
                color: #5D6975;
                text-align: left;
                width: 90px;
                margin-right: 10px;
                display: inline-block;
                font-size: 1em;
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
    <div class="col-lg-12">
        <asp:Button ID="btnExport" runat="server" Text="Print" OnClientClick="printDiv()" CssClass="btn btn-info" />
        &nbsp;  &nbsp;  &nbsp;  &nbsp;
         <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" CssClass="btn btn-success" />
    </div>
    <div class="clearfix"></div>




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

