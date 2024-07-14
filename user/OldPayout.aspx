<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="OldPayout.aspx.cs" Inherits="User_OldPayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div class="site-content">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-cart-arrow-down" aria-hidden="true"></i>&nbsp;Link for old payout
            </div>
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
  <asp:Button ID="Button2" runat="server" Text="Proceed" CssClass="btn btn-success" onclick="Button1_Click"/></div>
                                    <div class="col-md-4">
                                
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
         
        </div>



</asp:Content>

