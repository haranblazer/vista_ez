<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="MonthlyPayoutList.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_MonthlyPayoutList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Topper Monthly Payout List</h4>
   <asp:Panel ID="pnlUtility" runat="server">

                 <div class="row">
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddl_Payout_Fillter" runat="server" CssClass="form-control"
                            AutoPostBack="true" OnSelectedIndexChanged="ddl_Payout_Fillter_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="-1">All Payout</asp:ListItem>
                            <asp:ListItem Value="1">Dispatch & Release</asp:ListItem>
                            <asp:ListItem Value="0">Hold Payout</asp:ListItem>
                            <asp:ListItem Value="2">Release</asp:ListItem>

                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlDateRange_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddl_BankWallet" runat="server" AutoPostBack="True" CssClass="form-control"
                            OnSelectedIndexChanged="ddl_BankWallet_SelectedIndexChanged">
                            <asp:ListItem Value="-1">All</asp:ListItem>
                            <asp:ListItem Value="0">Bank</asp:ListItem>
                            <asp:ListItem Value="1">Wallet</asp:ListItem>
                        </asp:DropDownList>
                    </div>
             
                    <div class="col-md-1 control-label">
                        Paging
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                            CssClass="form-control">
                            <asp:ListItem>All</asp:ListItem>
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>

                        </asp:DropDownList>
                    </div>
               
                    <div class="col-md-2">
                        <asp:ImageButton ID="ibtnExcel" runat="server" ImageUrl="images/excel.gif" Width="24px"
                            OnClick="ibtnExcel_Click" />
                        &nbsp;<asp:ImageButton ID="ibtnWord" runat="server" ImageUrl="images/word.jpg"
                            OnClick="ibtnWord_Click" />
                    </div>
                </div>
            </asp:Panel>


    <hr />
 
                <p>
                    <span style="background-color: #fff; color: Black;">Dispatched
                                        Payout</span> <span style="background-color: #ffebea; color: Black;" class="label label-default ">Hold Payout</span> <span class="label label" style="background-color: #e2fbd7; color: Black;">Release Payout </span>
                </p>
         
          
            <asp:Label ID="lblPayoutNo" runat="server" Font-Names="Arial" Font-Size="Small"></asp:Label>

         

                <div class="table-responsive" id="trGrid" runat="server">

                    <asp:GridView ID="dgList" runat="server" Width="100%" DataKeyNames="payoutno, appmstregno"
                        AutoGenerateColumns="False" OnPageIndexChanging="dgList_PageIndexChanging" CssClass="table table-striped table-hover"
                        OnRowCommand="dgList_RowCommand" AllowPaging="True"
                        ShowFooter="True" FooterStyle-Font-Bold="true">
                        <Columns>
                            <%-- <asp:TemplateField HeaderText="Sr.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Payout Period">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("[Payout Period]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="User Id">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hnd_Iselegible" runat="server" Value='<%#Eval("iselegible") %>' />
                                    <asp:LinkButton ID="lnkbtnStatement" CommandName="Statement" Text='<%# Eval("appmstregno") %>'
                                        CommandArgument='<%#((GridViewRow)Container).RowIndex %>' runat="server" ReadOnly="True" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="User Name">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("[User Name]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:BoundField DataField="Mobile" HeaderText="Mobile" ReadOnly="True" />
                            <asp:BoundField DataField="PAN" HeaderText="PAN" ReadOnly="True" />
                            <asp:BoundField DataField="Bank" HeaderText="Bank" ReadOnly="True" />
                             <asp:BoundField DataField="Branch" HeaderText="Branch" ReadOnly="True" />
                            <asp:TemplateField HeaderText="Account No">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%#Eval("[Account No]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IFSC Code">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%#Eval("[IFSC Code]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:BoundField DataField="TPV" HeaderText="TPV" ReadOnly="True" />
                            <asp:TemplateField HeaderText="Mathing Counts">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text=''></asp:Label><%#Eval("[Mathing Counts]") %>  </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TopperPIN" HeaderText="Topper PIN" ReadOnly="True" />




                            <asp:TemplateField HeaderText="Bronze& Silver">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%#Eval("[Bronze_Silver]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Gold">
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%#Eval("Gold").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Ruby">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%#Eval("Ruby").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Pearl">
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%#Eval("Pearl").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Diamond">
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%#Eval("Diamond").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Double Diamond">
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%#Eval("DoubleDiamond").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Blue Diamond">
                                <ItemTemplate>
                                    <asp:Label ID="Label12" runat="server" Text='<%#Eval("BlueDiamond").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Black Diamond">
                                <ItemTemplate>
                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("BlackDiamond").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Crown Ambassador">
                                <ItemTemplate>
                                    <asp:Label ID="Label14" runat="server" Text='<%#Eval("CrownAmbassador").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Offer Income">
                                <ItemTemplate>
                                    <asp:Label ID="Label15" runat="server" Text='<%#Eval("Offer_Income").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Reward Fund">
                                <ItemTemplate>
                                    <asp:Label ID="Label16" runat="server" Text='<%#Eval("Reward_Fund").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Total Payout">
                                <ItemTemplate>
                                    <asp:Label ID="Label17" runat="server" Text='<%#Eval("[Total Payout]").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TDS">
                                <ItemTemplate>
                                    <asp:Label ID="Label18" runat="server" Text='<%#Eval("TDS").ToString()%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="PC Charges">
                                <ItemTemplate>
                                    <asp:Label ID="Label19" runat="server" Text='<%#Eval("[PC Charges]").ToString()%>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Net Payout">
                                <ItemTemplate>
                                    <asp:Label ID="Label20" runat="server" Text='<%#Eval("[Net Payout]").ToString()%>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Payout Status">
                                <ItemTemplate>
                                    <asp:Label ID="Label21" runat="server" Text='<%#Eval("[Payout Status]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID Status">
                                <ItemTemplate>
                                    <asp:Label ID="Label22" runat="server" Text='<%#Eval("[ID Status]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bank Details">
                                <ItemTemplate>
                                    <asp:Label ID="Label23" runat="server" Text='<%#Eval("[Bank Details]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="500 PPV">
                                <ItemTemplate>
                                    <asp:Label ID="Label24" runat="server" Text='<%#Eval("[Self PPV]") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" />--%>

                            <asp:TemplateField HeaderText="Transfer to G Wallet">
                                <ItemTemplate>
                                    <asp:Label ID="Label25" runat="server" Text='<%#Eval("[Transfer to G Wallet]") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Transfer to C Wallet">
                                <ItemTemplate>
                                    <asp:Label ID="Label26" runat="server" Text='<%#Eval("[Transfer to C Wallet]") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>

                </div>

           

    <%--  <script type="text/javascript">
        var GridId = "<%=dgList.ClientID %>";
        var ScrollHeight = 400;
        window.onload = function () {
            var grid = document.getElementById(GridId);
            var gridWidth = grid.offsetWidth;
            var gridHeight = grid.offsetHeight;
            var headerCellWidths = new Array();
            for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
            }
            grid.parentNode.appendChild(document.createElement("div"));
            var parentDiv = grid.parentNode;

            var table = document.createElement("table");
            for (i = 0; i < grid.attributes.length; i++) {
                if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                    table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                }
            }
            table.style.cssText = grid.style.cssText;
            table.style.width = gridWidth + "px";
            table.appendChild(document.createElement("tbody"));
            table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
            var cells = table.getElementsByTagName("TH");

            var gridRow = grid.getElementsByTagName("TR")[0];
            for (var i = 0; i < cells.length; i++) {
                var width;
                if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                    width = headerCellWidths[i];
                }
                else {
                    width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                }
                cells[i].style.width = parseInt(width) + "px";
                gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width) + "px";
            }
            parentDiv.removeChild(grid);

            var dummyHeader = document.createElement("div");
            dummyHeader.appendChild(table);
            parentDiv.appendChild(dummyHeader);
            var scrollableDiv = document.createElement("div");
            if (parseInt(gridHeight) > ScrollHeight) {
                gridWidth = parseInt(gridWidth) + 17;
            }
            scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
            scrollableDiv.appendChild(grid);
            parentDiv.appendChild(scrollableDiv);
        }
    </script>--%>
    <style>
        .table {
            margin-bottom: 0px;
        }

        th {
            border: none;
        }

        td, th {
            padding: 8px !important;
        }
    </style>
</asp:Content>

