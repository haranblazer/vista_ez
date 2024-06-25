<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="PartyWisePrimary_Sales_Pivot.aspx.cs" Inherits="secretadmin_PartyWisePrimary_Sales_Pivot" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Party Wise Primary sales</h4>
    <div class="form-group card-group-row row">
          <div class="col-md-2">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>
        </div>

        <div class="col-md-2 ">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"
                MaxLength="10"></asp:TextBox>

        </div>
        <div class="col-md-2">
             <asp:TextBox ID="txt_BuyerID" runat="server" CssClass="form-control" placeholder="Enter Buyer UserId"></asp:TextBox>
        </div>
         <div class="col-sm-2 ">
            <asp:DropDownList ID="ddl_Type" style="display: none;" CssClass="form-control" runat="server">
            </asp:DropDownList>
        </div>

        <div class="col-sm-2">
            <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearchByDate_Click" 
                OnClientClick="javascript:return Validation()"/>

        </div> 
        <div class="col-sm-2 col-xs-2 text-right pull-right">
            <asp:Button ID="ImageButton2" runat="server" Text="Excel" OnClick="imgbtnExcel_Click" class="btn btn-primary btn-sm" />
            <asp:Button ID="ImageButton4" runat="server" Text="CSV" OnClick="imgbtnCsv_Click" class="btn btn-primary btn-sm" />
        </div>
    </div>
    <hr />
    <div class="clearfix"></div>
    <div class="table-responsive">
        <asp:GridView ID="grdviewdata" runat="server" OnRowDataBound="grdviewdata_RowDataBound" ShowFooter="true" CssClass="table table-striped table-hover display dataTable nowrap cell-border">
            <Columns>
                <asp:TemplateField HeaderText="#">
                    <ItemTemplate>
                        <asp:Label ID="lblserial" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField> 
            </Columns>
        </asp:GridView>
    </div>


    <%-- <div class="container-fluid">
            <div class="card-header py-3 align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">
                    <center>Partywise Primary sales</center>
                </h6>
            </div>
          
            <br />
            <div class="row">
                 <div class="col-sm-2.5 ">
                    <span class="month" style="color: #bb8f38" aria-setsize="20">Select Number of Months Required :</span>
                    <asp:DropDownList ID="ddlmonth" runat="server">
                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                        <asp:ListItem Value="6">6</asp:ListItem>
                        <asp:ListItem Value="8">8</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="12">12</asp:ListItem>
                    </asp:DropDownList>
                  </div>

                <div class="col-sm-2 ">
                    <asp:Button ID="ViewReport" runat="server" Text="View Report" OnClick="ViewReport_Click" BackColor="#24a0ed" ForeColor="White"></asp:Button>
                </div>  
                  </div>
                  <div class="col-sm-6" style="width:80%;text-align:right">
                <asp:Button ID="btnexcel" runat="server" Text="Download Excel" OnClick="btnexcel_Click" />
            </div>

          
            <br />
            <div style="align-content: center">
                <asp:GridView ID="grdviewdata" ShowFooter="true" runat="server" OnRowDataBound="grdviewdata_RowDataBound">

                    <Columns>                      
                        <asp:TemplateField HeaderText="Sl No">
                        <ItemTemplate>
                            <asp:Label ID="lblSerial" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                                    
                     <asp:TemplateField HeaderText="Total">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalAmt" runat="server" ></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                  
                  </Columns>   
                </asp:GridView>
            </div>

        </div>--%>

      <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript">
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });

        function Validation() {
            var MSG = "";
            if ($('#<%=txtFromDate.ClientID%>').val() == "") {
                MSG += "\n Please select date.!!";
                $('#<%=txtFromDate.ClientID%>').focus();
            }
            if ($('#<%=txtToDate.ClientID%>').val() == "") {
                MSG += "\n Please select date.!!";
                $('#<%=txtToDate.ClientID%>').focus();
            }
            if (MSG != "") {
                alert(MSG);
                return false;
            } else {
                return true;
            }
        }
    </script>


</asp:Content>

