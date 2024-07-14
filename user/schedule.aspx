<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="schedule.aspx.cs" Inherits="user_schedule" %>

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
            Schedule
        </div>
    </div>

    <br />
    <ul class="dashboard_menu">
        <li><a href="TrainRequest.aspx" class="d1"><span>Training Request</span></a></li>
        <li><a href="EventDetail.aspx" class="d1"><span>Event List</span></a></li>
    </ul>
</asp:Content>


