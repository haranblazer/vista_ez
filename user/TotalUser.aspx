<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="TotalUser.aspx.cs" Inherits="user_TotalUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="site-content">

        <div class="panel-heading">
                 <i class="fa fa-user" aria-hidden="true"></i>&nbsp; Total User 
            </div>

 <div id="main-container" style="background-color: #fff">  
    <br />

        <div class="table-responsive"> 
    <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
        Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
        EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False"
        OnPageIndexChanging="dglst_PageIndexChanging">
        <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="Sr.No">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                <ItemStyle Font-Bold="True" Height="20px" />
            </asp:TemplateField>
            <asp:BoundField DataField="AppMstregno" HeaderText="User ID" />
            <asp:BoundField DataField="appmstfname" HeaderText="Name" />
            <asp:BoundField DataField="appmstmobile" HeaderText="Mobile" visible="false"/>
            <asp:BoundField DataField="sponsorid" HeaderText="Sponsor Id" />
         <%--   <asp:BoundField DataField="appmstlefttotal" HeaderText="Paid Left" />
            <asp:BoundField DataField="appmstrighttotal" HeaderText="Paid Right" />


             <asp:BoundField DataField="templefttotal" HeaderText="Associates in Group A" />
            <asp:BoundField DataField="temprighttotal" HeaderText="Associates in Group B" />--%>
            <asp:BoundField DataField="pbvamt" HeaderText="CV" />
            <asp:BoundField DataField="gbvamt" HeaderText="CV" />
          
        </Columns>
    </asp:GridView>
    </div>
    </div>
</div>

</asp:Content>
