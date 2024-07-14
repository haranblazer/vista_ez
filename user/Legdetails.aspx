<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true" CodeFile="Legdetails.aspx.cs" Inherits="secretadmin_Legdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <link href="assets/css/respo.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .not-active {
            pointer-events: none;
            cursor: default;
            color: #999999;
        }
    </style>
     <div class="container-fluid page__heading-container">
        <div class="page__heading d-flex align-items-center">
            <div class="flex">
                <nav aria-label="breadcrumb">
                   <ol class="breadcrumb mb-0">
                       <li class="breadcrumb-item"><a href="#">My Business</a></li>
                       <li class="breadcrumb-item active" aria-current="page">Cum 750 RPV IDs Report
</li>
                   </ol>
                </nav>
                <h1 class="m-0">Cum 750 RPV IDs Report
</h1>
            </div>
            <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
        </div>
    </div>

    <div class="container-fluid page__container">
        <div class="panel card card-body">
            <div class="panel panel-default">

                <div class="col-sm-1 float-right text-right">
                      <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="20px" />
                </div>
                    
                     

                </div>
             
                 
                <div class="table-responsive">

                    <div class="card m-0">

                        <asp:GridView ID="GridView1" runat="server"  CellPadding="4" CssClass="table table-striped table-hover"
                    Font-Names="Arial" Font-Size="Small" AutoGenerateColumns="False"
                    EmptyDataText="No Record Found." ShowFooter="true" FooterStyle-Font-Bold="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SNo">
                            <ItemTemplate>
                               <asp:Label ID="lblUser" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="UserId" DataField="UserId" />
                        <asp:BoundField HeaderText="User Name" DataField="UserName" />
                        <asp:BoundField HeaderText="District" DataField="District" />
                        <asp:BoundField HeaderText="State" DataField="State" />
                       <%-- <asp:BoundField HeaderText="Mobile No" DataField="MobileNo" />--%>
                          <asp:BoundField HeaderText="Values" DataField="RPV" />
                         <asp:BoundField HeaderText="Month" DataField="MonthName" />
                    </Columns>
                </asp:GridView>

                         
                    </div>
                </div>
            </div>
        </div>
    </div>
   




     
</asp:Content>

