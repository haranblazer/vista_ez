<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="RepliedEnquiry.aspx.cs" Inherits="secretadmin_RepliedEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Replied Enquiry List</h4>					
				</div>
      
    <div class="table-responsive">
        <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="false" 
            EmptyDataText="No Data Found." CssClass="table table-striped table-hover" AllowPaging="true"
            PageSize="20" onpageindexchanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="enquiryid" HeaderText=" Enquiry Id" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="PhoneNo" HeaderText="Mobile No" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Msg" HeaderText="Message" />
                <asp:BoundField DataField="doe" HeaderText="Enquiry Date" />
                <asp:BoundField DataField="reply" HeaderText="Reply" />
                <asp:BoundField DataField="rplydate" HeaderText="Reply Date" />
            </Columns>
        </asp:GridView>
    </div>
   
</asp:Content>
