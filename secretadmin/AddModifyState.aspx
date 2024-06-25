<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="AddModifyState.aspx.cs" Inherits="secretadmin_AddModifyState" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery.autocomplete.js" type="text/javascript"></script>
    <link href="../css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            var datafranID = document.getElementById("<%=divState.ClientID%>").innerText.split(",");
            $('#<%=txtAddState.ClientID %>').autocomplete(datafranID);
        });
    </script>
    
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add State  </h4>					
				</div>

   

        <div class="row">
           
            <div class="col-sm-3">
                <asp:TextBox ID="txtAddState" runat="server" CssClass="form-control" Placeholder="Enter State Name"></asp:TextBox>
                <div id="divState" runat="server" style="display: none">
                </div>
                
            </div>

            <div class="col-sm-3">
                <asp:TextBox ID="txtStateNo" runat="server" CssClass="form-control" Placeholder="Enter State No." MaxLength="2"></asp:TextBox>
                <asp:RangeValidator ID="RangeValidator1" runat="server" Type="Integer"
                    MinimumValue="0" MaximumValue="99" ControlToValidate="txtStateNo"
                    ErrorMessage="*Value must be a two digit number" ForeColor="#FF3300" />
                <div id="div1" runat="server" style="display: none">
                </div>
               
            </div>
            <div class="col-sm-3">
                <asp:TextBox ID="txtStateCode" runat="server" CssClass="form-control" Placeholder="Enter State Code"></asp:TextBox>
                <div id="div2" runat="server" style="display: none">
                </div>
               
            </div>

            <div class="col-sm-1">
                <asp:Button ID="btnAddstate" runat="server" Text="ADD" CssClass="btn btn-primary"
                    Style="float: right" OnClick="btnAddstate_Click" />
            </div>
        </div>



     
        <div class=" table-responsive">
            <asp:GridView ID="GridState" runat="server" CssClass="table table-striped table-hover mygrd"
                PageSize="50" AutoGenerateColumns="false" Width="100%" DataKeyNames="sid" EmptyDataText="No Record Found."
                AllowPaging="true" OnPageIndexChanging="GridState_PageIndexChanging" OnRowDataBound="GridState_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Sr No.">
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SID" HeaderText="Sr No." Visible="false" />
                    <asp:BoundField DataField="statename" HeaderText="State Name" />
                    <asp:BoundField DataField="stateno" HeaderText="State No" />
                    <asp:BoundField DataField="statecode" HeaderText="State Code" />
                    <asp:TemplateField HeaderText="Region" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                             <asp:HiddenField ID="hnd_ID" runat="server" Value='<%# Bind ("sid") %>' />
                            <asp:HiddenField ID="hnd_RId" runat="server" Value='<%# Bind ("RId") %>' />

                            <asp:DropDownList ID="ddl_Region" runat="server" CssClass="form-control" Width="150px"
                                AutoPostBack="true" OnSelectedIndexChanged="ddl_Region_SelectedIndexChanged">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" Style="text-decoration: none; margin: 2px"
                                CssClass="btn btn-primary" OnClick="lnkEdit_Click">Edit</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>


        <div class="clearfix"></div>
    </div>
</asp:Content>
