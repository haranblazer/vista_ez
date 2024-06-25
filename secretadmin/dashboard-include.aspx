<script>
    function Geturl(flag) {
        var Userid = '', UserType = '';

        if (flag == "Dashboard") {
            Userid = $('#<%=txt_Dashboard.ClientID%>').val();
            UserType = $('#<%=ddl_Dashboard.ClientID%>').val();
        }
        else if (flag == "Billing") {
            Userid = $('#<%=txt_Billing.ClientID%>').val();
            UserType = $('#<%=ddl_Billing.ClientID%>').val();
        }
        else if (flag == "TopperTree") {
            Userid = $('#<%=txt_TopperTree.ClientID%>').val();
            UserType = $('#<%=ddl_TopperTree.ClientID%>').val();
        }
        else if (flag == "GenerationDownline") {
            Userid = $('#<%=txt_GenerationDownline.ClientID%>').val();
            UserType = $('#<%=ddl_GenerationDownline.ClientID%>').val();
        }
        else if (flag == "TopperDownline") {
            Userid = $('#<%=txt_TopperDownline.ClientID%>').val();
            UserType = $('#<%=ddl_TopperDownline.ClientID%>').val();
        }
        else if (flag == "payout") {
            Userid = $('#<%=txt_payout.ClientID%>').val();
            UserType = $('#<%=ddl_payout.ClientID%>').val();
        }
        else if (flag == "Wallet") {
            Userid = $('#<%=txt_Wallet.ClientID%>').val();
            UserType = $('#<%=ddl_Wallet.ClientID%>').val();
        }
        else if (flag == "Passbook") {
            Userid = $('#<%=txt_Passbook.ClientID%>').val();
            UserType = $('#<%=ddl_Passbook.ClientID%>').val();
        }

        $.ajax({
            type: "POST",
            url: 'welcome.aspx/GetLogin',
            data: '{flag: "' + flag + '", Userid: "' + Userid + '", UserType: "' + UserType + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                 
                if (data.d == "SessionOut") {
                    window.location = "adminlog.aspx";
                }
                 
                if (data.d == "1") {

                    if (flag == "Dashboard") {
                        if (UserType == "1") {
                            //window.open(url, '_blank');
                            window.open("../user/Dashboard.aspx", '_blank');
                        }
                        if (UserType == "2")
                            window.open("../franchise/welcome.aspx", '_blank');
                    }

                    if (flag == "Billing") {
                        if (UserType == "1") {
                            window.open("../user/BarcodeBilling.aspx");
                        }
                        if (UserType == "2")
                            window.open("../franchise/BarcodeBilling.aspx");
                    }

                    if (flag == "TopperTree" && UserType == "1") {
                        window.open("../user/genology.aspx");
                    }
                    if (flag == "GenerationDownline" && UserType == "1") {
                        window.open("../user/GroupSales.aspx");
                    }
                    if (flag == "TopperDownline" && UserType == "1") {
                        window.open("../user/downstatus1.aspx");
                    }

                    if (flag == "payout") {
                        if (UserType == "1") {
                            window.open("../user/UserRepurchaseList.aspx");
                        }
                        if (UserType == "2")
                            window.open("../franchise/welcome.aspx");
                    }

                    if (flag == "Wallet") {
                        if (UserType == "1") {
                            window.open("../user/approvewalletlist.aspx");
                        }
                        if (UserType == "2")
                            window.open("../franchise/welcome.aspx");
                    }

                    if (flag == "Passbook") {
                        if (UserType == "1") {
                            window.open("../user/dwallet.aspx");
                        }
                        if (UserType == "2")
                            window.open("../franchise/welcome.aspx");
                    }

                    /*window.location = "deals";
                    window.open("Deals-Offer.aspx?ID=" + response.d);

                    window.close();
                    window.open("Dashboard.aspx", "_self");*/
                }
                else {
                    alert(data.d);
                    return false;
                }
            },
            error: function (response) {
                return false;
            }
        });
    }
</script>
<style>
   .coin-tabs .nav-tabs .nav-item .nav-link {
    margin-left: 5px;
    background:#fff;
    margin-bottom: 5px;
}
</style>
<br />

<div class="card" id="user-activity1">
    <div class="card-header border-0 p-0 pb-4 d-none">
        <div class="card-action coin-tabs">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="#daily1" role="tab" aria-selected="false">Current Month</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#weekly1" role="tab" aria-selected="true">Topper Tree</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#monthly1" role="tab" aria-selected="false">Generation Downline</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#topper_downline" role="tab" aria-selected="false">Topper Downline</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="card-body p-0">
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade active show" id="daily1">
                <div class="form-group row">
                    <div class="col-sm-2">
                        <asp:TextBox ID="txt_Dashboard" runat="server" CssClass="form-control" placeholder="Enter UserId" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_Dashboard" runat="server" CssClass="form-control">
                            <asp:ListItem Value="1">Team Partners</asp:ListItem>
                            <asp:ListItem Value="2">Billing Panel</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2">
                        <input type="button" class="btn btn-primary" value="Go" onclick="return Geturl('Dashboard')" />
                        <%-- <asp:Button ID="btn_Dashboard" runat="server" Text="Submit" class="btn  btn-success" OnClick="btn_Dashboard_Click"/>--%>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="weekly1">
                <div class="form-group row">
                    <div class="col-sm-2">
                        <asp:TextBox ID="txt_TopperTree" runat="server" CssClass="form-control" placeholder="Enter UserId" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_TopperTree" runat="server" CssClass="form-control">
                            <asp:ListItem Value="1">Associate</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2">
                        <input type="button" class="btn  btn-primary" value="Go" onclick="return Geturl('TopperTree')" />
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="monthly1">
                <div class="form-group row">
                    <div class="col-sm-2">
                        <asp:TextBox ID="txt_GenerationDownline" runat="server" placeholder="Enter UserId" CssClass="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_GenerationDownline" runat="server" CssClass="form-control">
                            <asp:ListItem Value="1">Associate</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2">
                        <input type="button" class="btn  btn-primary" value="Go" onclick="return Geturl('GenerationDownline')" />
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="topper_downline">
                <div class="form-group row">
                    
                    <div class="col-sm-2">
                        <asp:TextBox ID="txt_TopperDownline" runat="server" CssClass="form-control" placeholder="Enter UserId" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddl_TopperDownline" runat="server" CssClass="form-control">
                            <asp:ListItem Value="1">Associate</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-2">
                        <input type="button" class="btn  btn-primary" value="Go" onclick="return Geturl('TopperDownline')" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div>
    <div id="div_Fillter" runat="server" class="row panel card card-body d-none">
        <div class="classic-tabs mx-2 col-lg">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item active">
                    <a class="nav-link active" data-toggle="tab" href="#Dashboard" role="tab">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#TopperTree" role="tab"></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#GenerationDownline" role="tab"></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#TopperDownline" role="tab"></a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="clearfix"></div>
                <div class="tab-pane fade" id="Billing" role="tabpanel">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                            Enter UserId:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_Billing" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddl_Billing" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Associate</asp:ListItem>
                                <asp:ListItem Value="2">Billing Panel</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <input type="button" class="btn  btn-primary" value="Go" onclick="return Geturl('Billing')" />
                            <%-- <asp:Button ID="btn_Billing" runat="server" Text="Submit" class="btn  btn-success" OnClick="btn_Billing_Click" />--%>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <br />
                </div>

                
                <div class="clearfix"></div>
                <div class="tab-pane fade" id="GenerationDownline" role="tabpanel">
                </div>

                <div class="clearfix"></div>
                <div class="tab-pane fade" id="TopperDownline" role="tabpanel">

                    <div class="clearfix"></div>
                    <br />
                    <br />
                </div>
                <div class="clearfix"></div>
                <div class="tab-pane fade" id="payout" role="tabpanel">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                            Enter UserId:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_payout" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddl_payout" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Associate</asp:ListItem>
                                <asp:ListItem Value="2">Billing Panel</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <input type="button" class="btn  btn-primary" value="Go" onclick="return Geturl('payout')" />
                            <%-- <asp:Button ID="btn_payout" runat="server" Text="Submit" class="btn  btn-success" OnClick="btn_payout_Click" />--%>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                </div>

                <div class="clearfix"></div>
                <div class="tab-pane fade" id="Wallet" role="tabpanel">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                            Enter UserId:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_Wallet" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddl_Wallet" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Associate</asp:ListItem>
                                <asp:ListItem Value="2">Billing Panel</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <input type="button" class="btn  btn-primary" value="Go" onclick="return Geturl('Wallet')" />
                            <%-- <asp:Button ID="btn_Wallet" runat="server" Text="Submit" class="btn  btn-success" OnClick="btn_Wallet_Click" />--%>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <br />
                </div>
                <div class="clearfix"></div>
                <div class="tab-pane fade" id="Passbook" role="tabpanel">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                            Enter UserId:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txt_Passbook" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddl_Passbook" runat="server" CssClass="form-control">
                                <asp:ListItem Value="1">Associate</asp:ListItem>
                                <asp:ListItem Value="2">Billing Panel</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <input type="button" class="btn  btn-primary" value="Go" onclick="return Geturl('Passbook')" />
                            <%--  <asp:Button ID="btn_Passbook" runat="server" Text="Submit" class="btn  btn-success" OnClick="btn_Passbook_Click" />--%>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <br />
                    <br />
                </div>

            </div>
        </div>
    </div>
</div>
<%--<style>
    .fade {
        transition: opacity .1s linear;
    }
</style>--%>
