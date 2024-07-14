<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="downstatus2.aspx.cs" Inherits="user_downstatus" Title="Down Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function ($) {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
                    <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#"> My Business</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Downline Status</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Downline Status</h1>
                            </div>
                           <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div>

<div class="container-fluid page__container">                 
         <div class="panel card card-body">
        <div class="panel panel-default">          
            <div class="panel-body">

  <div class="form-group  card-group-row row">  
                        <div class="col-md-3">                                                    
                            <asp:RadioButton ID="rdSelf" runat="server" GroupName="ab" Checked="True" /> 
                            <strong><span style="font-size: 10pt; font-family: Verdana">Self </span></strong>
                            
                            <asp:RadioButton ID="rdDownline" runat="server" GroupName="ab" />
                            <strong><span style="font-size: 10pt; font-family: Verdana">Downline </span></strong>                         
                            
                        </div>
                        </div>
                        <div class="form-group  card-group-row row">
                        <div class="clearfix"></div>
                         <div class="col-md-3">
                            <strong><span style="font-size: 10pt; font-family: Verdana">DownLine Member ID: </span>
                            </strong>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtmemberid" runat="server" CssClass="form-control" OnTextChanged="txtmemberid_TextChanged"></asp:TextBox>
                            <%--<asp:Label ID="lbluname" runat="server" ForeColor="red" Visible="false"></asp:Label>--%>
                            <div class="clearfix">
                            </div>
                            
                        </div>
                        <div class="col-md-1">
                            <strong><span style="font-size: 10pt; font-family: Verdana">FROM </span></strong>
                        </div>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                            <div class="clearfix">
                            </div>
                           
                        </div>
                        <div class="col-md-1">
                            <strong><span style="font-size: 10pt; font-family: Verdana">TO</span></strong>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                            <div class="clearfix">
                            </div>
                            
                        </div>
                        <div class="col-md-1">
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" CssClass="btn btn-success" />
                        </div>                
                </div>
               
                <div class="row" style="display: none">
                    <div class="col-sm-3">
                        <strong><span style="font-size: 10pt; font-family: Verdana">Type :</span></strong>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddlMemberType" runat="server" AutoPostBack="True" CssClass="form-control"
                            OnSelectedIndexChanged="ddlMemberType_SelectedIndexChanged">
                            <asp:ListItem Value="-1">All</asp:ListItem>
                            <asp:ListItem Value="1">Active</asp:ListItem>
                            <%--<asp:ListItem Value="0">Inactive</asp:ListItem>--%>
                            <%--<asp:ListItem Value="2">Repurchase Paid</asp:ListItem>--%>
                        </asp:DropDownList>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="form-group">
                        <label for="MainContent_myForm_txtCcode" class="col-sm-1 control-label">
                            <strong><span style="font-size: 10pt; font-family: Verdana">Paging</span></strong>
                        </label>
                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                                OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                                <asp:ListItem>25</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                                <asp:ListItem>100</asp:ListItem>
                                <asp:ListItem>All</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                </div>
                <div class="clearfix">
                </div>
              
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table mb-0 thead-border-top-0" cellspacing="0" rules="all"
                                id="MainContent_GridView1" width="100%" style="border-collapse: collapse; color: #333;"
                                frame="border">
                                <tbody>
                                    <tr>
                                        <td width="50%">
                                            User:
                                        </td>
                                        <td>
                                            <asp:Label ID="lblcjusername" runat="server" Text="."></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Username:
                                        </td>
                                        <td>
                                            <asp:Label ID="lblcjuserid" runat="server" Text="."></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            First Purchase:
                                        </td>
                                        <td>
                                            <asp:Label ID="lblfpurchase" runat="server" Text="." onclick="lblfpurchase_Click"></asp:Label>
                                            <%--<asp:LinkButton ID="lblfpurchase" runat="server" Text="." onclick="lblfpurchase_Click" ></asp:LinkButton>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Re Purchase:
                                        </td>
                                        <td>
                                            <asp:Label ID="lblrpurchase" runat="server" Text="." onclick="lblrpurchase_Click"></asp:Label>
                                            <%--<asp:LinkButton ID="lblrpurchase" runat="server" Text="." onclick="lblrpurchase_Click"></asp:LinkButton>--%>
                                        </td>
                                    </tr>
                                    <tbody>
                            </table>
                        </div>
                    </div>
                </div>
                   
   </div>
   </div>
   </div>
 </div>
   
    </div>
    
   
</asp:Content>
