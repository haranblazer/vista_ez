<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="AddCity.aspx.cs" Inherits="secretadmin_AddCity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
  <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery.autocomplete.js" type="text/javascript"></script>
    <link href="../css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />

 
 <script type="text/javascript">
     $(document).ready(function () {
         var datafranID = document.getElementById("<%=divCity.ClientID%>").innerText.split(",");
         $('#<%=txtAddCity.ClientID %>').autocomplete(datafranID);
     });
    </script>
    <div class="clearfix">
    </div>
    <br />
    <br />
    <script type="text/javascript">
        function Validate() {

            var state = document.getElementById("ddlSelectState").value;
            var cityname = document.getElementById("txtAddCity").value;
            if (state == "0" && cityname == "") {
                alert("Both state and city name are Required.");
                return false;
            }

        }
    
    </script>
    <div class="col-sm-12">
        <div class="form-horizontal">
            <div class="panel panel-default">
                <div class=" txt panel-heading" style="background-color: #1D964B; border-radius: 6px;
                    font-size: 14px; color: #fff">
                    Add City</div>
                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-sm-2">
                            <label>
                                Select State</label>
                        </div>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlSelectState" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlSelectState_SelectedIndexChanged"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <div class="form-group">
                        <div class="col-sm-2">
                            <label>
                                City Name</label>
                        </div>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtAddCity" runat="server" CssClass="form-control"></asp:TextBox>
                             <div id="divCity" runat="server" style="display:none"></div>
                            <div class="clearfix">
                            </div>
                            <br />
                            <asp:Button ID="btnCity" runat="server" Text="ADD" CssClass="btn btn-success" Style="float: right"
                                OnClick="btnAddCity_Click" ValidationGroup="cc" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-12">
        <asp:RequiredFieldValidator ID="rfvState" runat="server" ErrorMessage="Please Select State."
            InitialValue="0" ControlToValidate="ddlSelectState" AccessKey="S" SetFocusOnError="true"
            Display="None" ValidationGroup="cc"></asp:RequiredFieldValidator>
        <br />
        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="Please Enter City Name."
             ControlToValidate="txtAddCity" AccessKey="C" SetFocusOnError="true"
            Display="None" ValidationGroup="cc"></asp:RequiredFieldValidator>
        <br />
        <asp:ValidationSummary ID="CityValidationSmry" runat="server" ValidationGroup="cc"
            ShowMessageBox="true" ShowSummary="false" HeaderText="Please check the following...  " />
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="table table-responsive">
        <asp:GridView ID="GridCity" runat="server" CssClass="table table-striped table-hover mygrd"
            PageSize="10" AutoGenerateColumns="false" Width="100%" DataKeyNames="sid" EmptyDataText="No Record Found."
            AllowPaging="true" OnPageIndexChanging="GridCity_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="Sr No.">
                    <ItemTemplate>
                        <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="sid" Visible="false"/>
                <asp:BoundField DataField="CityName" HeaderText="City Name" />
               <asp:TemplateField HeaderText="State ID" Visible="false">
               <ItemTemplate>
                   <asp:Label ID="lblState" runat="server" Text='<%# Eval("state") %>' ></asp:Label>
               </ItemTemplate>
               </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" Style="text-decoration: none; margin: 2px"
                            CssClass="btn btn-success" OnClick="lnkEdit_Click">Edit</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
