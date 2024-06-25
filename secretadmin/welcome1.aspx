<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="welcome1.aspx.cs" Inherits="mumbaiadmin_welcome" Title="Admin Control Panel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <style type="text/css">
        @media only screen and (max-width: 500px)
        {
            .bdynx
            {
                height: auto !important;
                width: 320px !important;
            }
        }
        
        .acolor
        {
            color: #fff;
        }
        .dashboard-stat
        {
            display: block;
            padding: 30px 15px;
            text-align: right;
            font-size: 20px;
            position: relative;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
        }
        .dashboard-stat1
        {
            display: block;
    padding: 10px 10px;
    font-size: 20px;
    position: relative;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    border-radius: 4px;
        }
        .dashboard-stat .bg-icon
        {
            position: absolute;
            font-size: 80px;
            opacity: 0.4;
            left: 0;
            bottom: 0;
        }
        i.fa.fa-bell
        {
            position: absolute;
            font-size: 70px;
            opacity: 0.4;
            left: 20px;
            bottom: 25px;
        }
        .show {
    display: none!important;
}

    </style>
    <script src="js/jquery.counterup.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <script src="js/jquery.counterup.min.js" type="text/javascript"></script>
    <script>
        jQuery(document).ready(function ($) {
            $('.counter').counterUp({
                delay: 10,
                time: 1000
            });
        });
    </script>
  <div class="panel panel-default">
  <div class="col-md-12">
    <div class="clearfix">
    </div> 
    <center>

     <div id="title" class="b2">
        <h2>
           Welcome to 
            <asp:Label ID="lbladmin" runat="server" Text="Label"></asp:Label> Panel</h2>
    </div>
    <br />
        </center>
   
  
    </div>
    <div class="clearfix"></div>
    </div>     
    
        
        
     
</asp:Content>
