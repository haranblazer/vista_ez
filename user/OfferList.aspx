<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="OfferList.aspx.cs" Inherits="user_OfferList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#"> My Shopping</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Offer List</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Offer List</h1>
                            </div>
                          <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div> 


                    <div class="container-fluid page__container">                 
         <div class="panel card card-body">
        <div class="panel panel-default">  
          
            <div class="panel-body">
  
            <div class="table-responsive">
    
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:GridView ID="grd1" runat="server" AutoGenerateColumns="false" CssClass="mygrd"
                                    DataKeyNames="Id" OnRowDataBound="grd1_RowDataBound" GridLines="None" ShowHeader="False"
                                    Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Srno">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1%>
                                            </ItemTemplate>
                                            <ItemStyle VerticalAlign="Top" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="width: 1000px; font-size: 15px; font-weight: bold; color: #003366;">
                                                            <asp:Label ID="lblProduct" Text='<%#Eval("offeron") %>' runat="server"></asp:Label>
                                                        </td>
                                                        <td align="left" style="font-size: 15px; font-weight: bold; color: #003366;">
                                                            Validity:<asp:Label ID="lblDate" Text='<%#Eval ("VData") %>' runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:GridView ID="GridView2" AutoGenerateColumns="false" Width="100%" runat="server">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Offer Product Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAmt" Text='<%#Eval ("productname") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Quantity">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="Label2" Text='<%#Eval ("quantity") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Payable Amount">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEligible" Text='<%#Eval ("Pamount") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="left" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                
                </div>
                </div>
                </div>
               </div>
               </div>
    </div>
   
   
</asp:Content>
