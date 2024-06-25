<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TopperDetail.aspx.cs" Inherits="admin_TopperDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>--%>
      <style>
    td,
    th {
      padding:0px 0px 0px 5px; border-color:#ddd; line-height:normal;
    }
  
    
    </style>
    <h1>
        Detail
    </h1>
    <br />
  <%--  <div class="form-group">
        <label for="MainContent_txtPassword" class="col-md-2 control-label">
            From :</label>
        <div class="col-md-3">
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
    </div>--%>
   <%-- <div class="form-group">
        <label for="MainContent_txtPassword" class="col-md-2 control-label">
            To :</label>
        <div class="col-md-3">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox><br />
            <asp:Button ID="Button1" runat="server" CssClass="btn btn-success ladda-button" Text="Show"
                OnClick="Button1_Click" />
        </div>
    </div>--%>
   <%-- <div class="form-group">
        <div class="col-md-12" style="text-align: right;">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user_images/excel.gif"
                Width="25px" />
        </div>
    </div>--%>
    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="text-align: Left">
                <asp:GridView ID="dgList" runat="server" Width="100%"  PageSize="50"
                    AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle"
                    AllowPaging="True" OnPageIndexChanging="dgList_PageIndexChanging"
                    OnRowCommand="dgList_RowCommand" OnRowCreated="dgList_RowCreated">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>


                          <asp:BoundField DataField="causeregno" HeaderText="User Id" />
                          <asp:BoundField DataField="causename" HeaderText="Name" />
                          <asp:BoundField DataField="causemobile" HeaderText="Mobile" />
                          <asp:BoundField DataField="causesponsorid" HeaderText="Sponsorid" />
                          <asp:BoundField DataField="causesponsorname" HeaderText="Sponsor Name" />
                          <asp:BoundField DataField="Amount" HeaderText="Amount" />
                 

                       <asp:HyperLinkField ControlStyle-Width="30px" DataNavigateUrlFields="srno,status"  HeaderText="Invoice" DataTextField="Invoiceno"
                       DataNavigateUrlFormatString="printbill.aspx?id={0}&st={1}" />




                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>


</asp:Content>

