<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="AddTitle.aspx.cs" Inherits="secretadmin_AddTitle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .accordion {
            width: 70%;
            margin: 0 auto;
        }

            /* accordion heading */
            .accordion h1 {
                font-size: 26px;
                font-weight: normal;
                text-align: center;
                margin-bottom: 0px;
                margin-top: 0px;
                background-color: gainsboro;
                padding-top: 7px;
                padding-bottom: 7px;
                border: 1px solid darkgrey;
                border-radius: 3px;
            }

                .accordion h1:hover {
                    cursor: pointer;
                }

            /* accordion section content */
            .accordion div {
                display: none;
                padding: 10px;
                height: 200px;
                line-height: 20px;
                border: 1px solid gray;
                border-radius: 3px;
            }

        @media screen and (max-width:480px) {
            .accordion {
                width: 100%;
                margin: 0;
            }
        }
    </style>


    <!-- accordion (start) -->
    <div class="accordion d-none">
        <!-- accordion section 1 -->
        <h1 id="accordionhead_1">Heading1</h1>
        <div id="accordioncontent_1" class="accordion-content">
            Content 1
        </div>

        <!-- accordion section 2 -->
        <h1 id="accordionhead_2">Heading2</h1>
        <div id="accordioncontent_2" class="accordion-content">
            Content 2
        </div>

        <!-- accordion section 3 -->
        <h1 id="accordionhead_3">Heading3</h1>
        <div id="accordioncontent_3" class="accordion-content">
            Content 3
        </div>

        <!-- accordion section 4 -->
        <h1 id="accordionhead_4">Heading4</h1>
        <div id="accordioncontent_4" class="accordion-content">
            Content 4
        </div>
    </div>
    <!-- accordion (end) -->
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add Title</h4>					
				</div>
 
                <div class="row">
                    <div class="col-md-2 control-label">
                        Title Type
                    </div>
                    <div class="col-sm-2 ">
                        <asp:DropDownList ID="ddl_TitleType" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Events">Events</asp:ListItem>
                            <asp:ListItem Value="Videos">Videos</asp:ListItem>
                            <asp:ListItem Value="Seminar">Seminar</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2 control-label">
                        Title Name
                    </div>
                    <div class="col-md-2">
                        <asp:TextBox ID="txt_Title" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                 
                    <div class="col-md-2">
                        <asp:Button ID="btnSave" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"
                            OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    </div>
                </div>

               
                <div class="table-responsive">

                    <asp:GridView ID="GridView1" EmptyDataText="Record not found." DataKeyNames="Tid"
                        CssClass="table table-striped table-hover mygrd" runat="server" AutoGenerateColumns="False" OnRowEditing="GridView1_RowEditing"
                        AllowPaging="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                    <asp:HiddenField ID="hnd_Tid" runat="server" Value='<%# Eval("Tid") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Title Type" DataField="TitleType" ReadOnly="True" />
                            <asp:BoundField HeaderText="Title" DataField="Title" ReadOnly="True" />

                            <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName='ACTIVE_DEACTIVE'>&nbsp;<%# Eval("IsActive").ToString() == "1" ? "<i class='fa fa-toggle-on' style='font-size:24px; color:green'></i>" : "<i class='fa fa-toggle-off' style='font-size:24px; color:red'></i>"%></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
           
    <script type="text/javascript">

        $(document).ready(function () {
            $(".accordion h1").click(function () {
                var id = this.id;   /* getting heading id */ 
                /* looping through all elements which have class .accordion-content */
                $(".accordion-content").each(function () { 
                    if ($("#" + id).next()[0].id != this.id) {
                        $(this).slideUp();
                    } 
                }); 
                $(this).next().toggle();  /* Selecting div after h1 */
            });
        });
    </script>
</asp:Content>

