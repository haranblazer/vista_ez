<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="Calc-title.aspx.cs" Inherits="secretadmin_Calc_title" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto"> Calculate Rank</h4>					
				</div>
  
   
                    <div class="col-md-12">
                        <asp:Button ID="btn_cal_title" runat="server" Text="Calculate Rank"
                            CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure you want to proceed？')"
                            OnClick="btn_cal_title_Click" />
                    </div>
              
</asp:Content>
