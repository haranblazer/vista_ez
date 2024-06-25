<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="RunTour.aspx.cs" Inherits="secretadmin_RunTour" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h1>Calculate Tour </h1>

<div class="col-md-12"> <asp:Label ID="lbldtour" runat="server" ></asp:Label> </div>
    <div class="clearfix"> </div> <br />

<div class="col-md-12"> <asp:Label ID="lblitour" runat="server" ></asp:Label> </div>
  <div class="clearfix"> </div> <br />
<div class="col-md-12"> <asp:Button ID="Button1" runat="server" Text="Submit"  CssClass="btn btn-success ladda-button"
    onclick="Button1_Click" /> </div>
    <div class="clearfix"> </div> <br />

</asp:Content>

