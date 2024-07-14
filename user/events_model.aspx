<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="events_model.aspx.cs" Inherits="user_events_model" %>

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
            Events Model
        </div>
    </div>
    <br />
    <ul class="dashboard_menu">
        <li><a href="AddUserEvent.aspx" class="d1"><span>Add Events</span></a></li>
        <li><a href="UpcomingEvents.aspx" class="d1"><span>View Upcoming Events</span></a></li>
    </ul>
</asp:Content>


