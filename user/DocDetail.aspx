<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="DocDetail.aspx.cs" Inherits="user_DocDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

 <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#">My Information</a></li>
                                        <li class="breadcrumb-item active" aria-current="page"></li>
                                    </ol>
                                </nav>
                                <h1 class="m-0"><asp:Label ID="Label1" runat="server" Text=""></asp:Label></h1>
                            </div>
                             <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div>

         
   <div class="container-fluid page__container">
            
         <div class="panel card card-body">
        <div class="panel panel-default">
          
            <div class="panel-body">
                <div id="DIV1" runat="server">
                    <table class="table table-striped table-hover" width="100%">
                        <thead>
                            <tr>
                                <td>
                                    Bank Name
                                </td>
                                <td>
                                    A/C Type
                                </td>
                                <td>
                                    A/C No
                                </td>
                                <td>
                                    Branch
                                </td>
                                <td>
                                    IFS Code
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <asp:Label ID="lblBankName" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAccountName" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblBanAcNo" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblBranch" runat="server" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblIFSCode" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br />
                    <div class="form-group">
                        <asp:Image ID="imgBank" runat="server" CssClass="img-responsive" />
                    </div>
                    <div class="clearfix">
                    </div>
                </div>
                <div id="DIV2" runat="server">
                    <table class="table table-striped table-hover" width="100%">
                        <thead>
                            <tr>
                                <td>
                                    <strong>PAN No</strong>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <strong>
                                        <asp:Label ID="lblPAN" runat="server"></asp:Label></strong>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br />
                    <div class="form-group">
                        <asp:Image ID="imagePAN" runat="server" CssClass="img-responsive" />
                    </div>
                    <div class="clearfix">
                    </div>
                </div>
                <div id="DIV3" runat="server">
                    <table class="table table-striped table-hover" width="100%">
                        <tr>
                            <td>
                                <asp:Image ID="imageAddress" runat="server" CssClass="img-responsive" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="DIV4" runat="server">
                    <div class="form-group">
                        <div class="col-md-6">
                            <asp:Image ID="AadharFront" runat="server" CssClass="img-responsive" />
                        </div>
                        <div class="col-md-6">
                            <asp:Image ID="AadharBack" runat="server" CssClass="img-responsive" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
  </div>
  </div>
    </div>
  
</asp:Content>
