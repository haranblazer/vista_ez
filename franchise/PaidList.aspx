<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="PaidList.aspx.cs" Inherits="admin_PaidList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <style type="text/css">
        body, td, th
        {
            font-family: Arial;
            font-size: 12px;
        }
        
         .b2 h1
        {
            font-size: 30px;
            padding: 0px 0px 10px 0px;
        }
        .panel-default > .panel-heading
        {
            background: linear-gradient(#F4DF82 , #D1A457);
            border: none;
            color: #000;
            font-weight: bold;
        }
        
        
    </style>

    <div class="container">

        <h2 class="head"> <i class="fa fa-bars" aria-hidden="true"></i> &nbsp;Paid List </h2>
    </div>   
    <hr />
    <div class="clearfix"> </div> <br /><br />

    <div class="row">

    <div class="col-md-4">
        
        <div class="form-group">
        <div class=" col-xs-4"> <strong> From :</strong> </div>
        <div class=" col-xs-8"> <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox> </div>
        <div class="clearfix"> </div> 
        </div>
   </div>
       <div class="col-md-4">
       <div class="form-group">
        <div class=" col-xs-4"> <strong> To :</strong> </div>
        <div class=" col-xs-8"> <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox> </div>
        <div class="clearfix"> </div> 
        </div>
        </div>
            <div class="col-md-4">
    
        
      <div class="form-group">
      
        <div class="col-md-3 col-xs-9">  <asp:Button ID="Button2" runat="server" OnClick="Button1_Click" CssClass="btn btn-success" Text="Show" /> </div>
        </div>

        </div>

        </div>
    <div class="clearfix"> </div> <br />   
      
      <div class="col-md-12" style="text-align:right;">   
      <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/franchise/images/excel.gif"
                        OnClick="imgbtnExcel_Click" Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/franchise/images/word.jpg"
                        OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
      </div>
      <div class="clearfix"> </div> <br />       
              
         <div class="table table-responsive">       
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="center" style="height: 30px; text-align: left" valign="middle">
                    <strong>&nbsp;
                        <asp:Label ID="Label3" runat="server"></asp:Label>
                    </strong>
                    <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" style="text-align: center; valign="top">
                    <asp:Panel ID="Panel1" runat="server">
                        <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                            Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                            AutoGenerateColumns="False" OnPageIndexChanging="dglst_PageIndexChanging">
                            <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %></ItemTemplate>
                                    <ItemStyle Font-Bold="True" Height="20px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="AppMstregno" HeaderText="User ID" />
                                <asp:BoundField DataField="SponsorID" HeaderText="Sponser ID" />
                                <asp:BoundField DataField="name" HeaderText="Name" />
                                <asp:BoundField DataField="appmstaddress1" HeaderText="Address" />
                                <asp:BoundField DataField="AppMstCity" HeaderText="City" />
                                <asp:BoundField DataField="AppMstState" HeaderText="State" />
                                <asp:BoundField DataField="appmstprimaryphone" HeaderText="Phone Number" />
                                <asp:BoundField DataField="AppMstMobile" HeaderText="Mobile Number" />
                                <asp:BoundField DataField="Joinfor" HeaderText="Join For" />
                                <asp:BoundField DataField="AppMstDOJ" HeaderText="Date of Joining" />
                                <asp:BoundField DataField="appmstpaid" HeaderText="Status" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        </div>
         <div class="clearfix"> </div> 
         </div>
        
</asp:Content>
