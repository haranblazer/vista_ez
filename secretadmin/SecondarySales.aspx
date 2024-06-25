<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="SecondarySales.aspx.cs"
    Inherits="secretadmin_SecondarySales" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        function GetDashboardUrl(flag) {
            var From = $('#<%=txtFromDate.ClientID%>').val(),
                To = $('#<%=txtToDate.ClientID%>').val();

            if (flag == "SEC_INVWISE") {
                window.location = "SecondarySalesDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "SEC_DEPOWISE") {
                window.location = "SecondarySalesDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
            else if (flag == "SEC_BUYERWISE") {
                window.location = "SecondarySalesDetails.aspx?Key=" + flag + "&From=" + From + "&To=" + To;
            }
        }
    </script>

      <h4 class="fs-20 font-w600  me-auto float-left mb-0">Secondary Sales Report</h4>
       <hr />
        <div id="div_Directors" runat="server" visible="false" class="row ">
          
            <div class="col-md-2"  style="display:none;">
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
            </div>
            <div class="col-md-2"  style="display:none;">
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"></asp:TextBox>
            </div>


            <div class="col-md-4">
                <div class="small-box bg-blue">
                    <div class="inner">
                        <h3><a style="cursor: pointer;" onclick="return GetDashboardUrl('SEC_INVWISE')" id="lbl_INVWISE" runat="server">0</a></h3>
                        <p>Invoice Wise </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="small-box bg-blue">
                    <div class="inner">
                        <h3><a style="cursor: pointer;" onclick="return GetDashboardUrl('SEC_DEPOWISE')" id="lbl_DEPOWISE" runat="server">0</a></h3>
                        <p>Depo Wise </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="small-box bg-blue">
                    <div class="inner">
                        <h3><a style="cursor: pointer;" onclick="return GetDashboardUrl('SEC_BUYERWISE')" id="lbl_BUYERWISE" runat="server">0</a></h3>
                        <p>Buyer Wise </p>
                    </div>
                    <div class="icon">
                        <i class="fa fa-handshake-o"></i>
                    </div>
                </div>
            </div>
        </div>
     

    <style>
        .small-box {
            border-radius: 10px;
            position: relative;
            display: block;
            box-shadow: 0px 0px 25px 0px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }

            .small-box > .inner {
                padding: 20px;
            }

            .small-box h3 a {
                color: #fff;
            }

            .small-box h3 {
                font-size: 24px;
                font-weight: normal;
                margin: 0 0 10px 0;
                white-space: nowrap;
                padding: 0;
                color: white;
            }

            .small-box p {
                font-size: 16px;
                color: white;
            }

            .small-box .icon {
                position: absolute;
                top: 20px;
                right: 20px;
                z-index: 0;
                font-size: 40px;
                color: rgba(0,0,0,0.15);
                transition: all .3s linear;
                -webkit-transition: all .3s linear;
                -moz-transition: all .3s linear;
                -o-transition: all .3s linear;
            }

        .bg-blue {
            background-color: #0d47a1 !important;
        }
    </style>
</asp:Content>
