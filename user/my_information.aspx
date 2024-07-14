<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="my_information.aspx.cs" Inherits="user_my_information" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .container-fluid {
            padding-top: 0;
            padding-right: 0rem !important;
            padding-left: 0rem !important;
        }
    </style>
    <div class="top-bar">
        <div class="page-title">
            My Information
        </div>
    </div>

    <br />
    <ul class="dashboard_menu">
       <%-- <li><a href="welcomeLetter.aspx" class="d1"><span>Welcome Letter</span></a></li>--%>
        <li><a href="Change_Profile.aspx" class="d1"><span>Edit Profile</span></a></li>
        <li><a href="ChangePassword.aspx" class="d1"><span>Change Password</span></a></li>
        <li><a href="IDCard.aspx" class="d1"><span>Print Id Card</span></a></li>
    </ul>
</asp:Content>


