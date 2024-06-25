<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="CalculateTopperReward.aspx.cs" Inherits="secretadmin_CalculateTopperReward" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
    <h4 class="fs-20 font-w600  me-auto">Calculate Reward</h4>
    </div> 
    
  
 
                        <asp:Button ID="btn_cal_title" runat="server" Text="Calculate Reward"
                            CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure you want to proceed？')"
                            OnClick="btn_cal_title_Click" />
                  
</asp:Content>

