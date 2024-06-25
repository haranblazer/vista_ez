﻿<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="DateWiseSold.aspx.cs" Inherits="admin_ProductStock" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

      <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {

            
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });

            <%--var dataUserID = document.getElementById("<%=divProduct.ClientID%>").innerHTML.split(",");
            $('#<%=txtPname.ClientID %>').autocomplete(dataUserID);--%>
        });

        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Date Wise Sale Report</h4>
    <div class="row">
                  <div class="col-sm-2">
                <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
            </div>
          
            <div class="col-sm-2">
                <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
            </div>
            <%--<div class="col-sm-2">--%>
                <asp:TextBox ID="txt_userid" runat="server" style="display: none;" placeholder="Enter FranchiseId" MaxLength="20" CssClass="form-control"></asp:TextBox>
          <%--  </div>

            <div class="col-sm-2">--%>
                <asp:DropDownList ID="ddl_FranchiseType" runat="server" style="display: none;" CssClass="form-control">
                    <asp:ListItem Value="2">Company + Depo</asp:ListItem>
                    <asp:ListItem Value="4">Top Circle</asp:ListItem>
                    <asp:ListItem Value="5">Top Point</asp:ListItem>
                    <asp:ListItem Value="6">TopShopee</asp:ListItem>
                </asp:DropDownList>
            <%--</div>--%>
            <div class="col-sm-1 col-xs-6">
                <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary"
                    OnClick="btnSearchByDate_Click" />

            </div>
            <div class="col-sm-1 col-xs-6 text-right pull-right">
                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="images/excel.gif"
                    OnClick="imgbtnExcel_Click" />
                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />
            </div> 

                </div>

  
   
            <%--    <div class="col-sm-3">
            <asp:DropDownList ID="ddlRewardList" runat="server" AutoPostBack="true" CssClass="form-control"
                OnSelectedIndexChanged="ddlRewardList_SelectedIndexChanged">
            </asp:DropDownList>
        </div>--%>
     <hr />

        <div style="display: none">
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
                    Product Name
                </label>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtPname" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-md-12" style="text-align: right;">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                        Style="margin-left: 0px" Width="26px" />
                </div>
            </div>
        </div>
       
        <div class="table-responsive">
            <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-hover" ShowFooter="True">
            </asp:GridView>

        </div>
        <%--<div id="divProduct" style="display: none;" runat="server">
        </div>--%>

     
     
</asp:Content>
