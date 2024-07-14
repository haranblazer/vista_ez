<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="OldPurchases.aspx.cs" Inherits="User_OldPayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <section class="page--header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6">
                            <!-- Page Title Start -->
                            <h2 class="page--title h5"> My Purchase</h2>
                            <!-- Page Title End -->
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item active"><span>Link for old purchases</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

         <section class="main--content">
             <br />
        
            <div class=" gutter-20">
            <div class="col-md-12">
        <div class="panel panel-default">
           
            <div class="panel-body">
                <!-- middle content -->
                <div class="indexmiddle" style="padding-bottom: 200px;">
                    <fieldset>
                        <div class="form-group">
                            <div class="col-md-3">
                                
                            </div>
                            <div class="col-md-7">
                                <asp:Label ID="lblNote" runat="server" Font-Bold="True" Font-Size="Larger" Text="Note-:Please use your old password to login." ForeColor="red"></asp:Label>
                            </div>
                            <div class="col-md-2">
                                
                            </div>
                        </div>
                        <div class="clearfix">
                        </div>
                        <br />
                       <div class="form-group">
                            <div class="col-md-5">
                                
                            </div>
                              <div class="col-md-3">
                              <a href="http://store.freecjshop.com/user-login-old.aspx" class="btn btn-success" target="_blank">Proceed</a>
  <asp:Button ID="Button2" runat="server" Text="Proceed" CssClass="btn btn-success" Visible="false"  onclick="Button1_Click"/></div>
                                    <div class="col-md-4">
                                
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
         
        </div>

        </div>
        </div>
        </section>

</asp:Content>

