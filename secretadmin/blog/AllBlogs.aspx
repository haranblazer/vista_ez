<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="AllBlogs.aspx.cs" Inherits="secretadmin_blog_AllBlogs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>
      
    <style>
        .ui-widget-content {
            z-index: 100000 !important;
        }

        #Approve {
            background-color: #315787;
            color: white;
        }

        #Cancel {
            background-color: red;
            color: white;
        }
    </style>


    <script type="text/javascript">

        /*function closePopup_Model() { $('#Model_Popup').hide(); }*/


        function openPopup(UserLink, userid, appmstfname, panno, dob, panDateLoaded, PANImage) {
            /*$('#Model_Popup').show();*/
            //var row = UserLink.parentNode.parentNode;

            $('#lblId').html(appmstfname + "(" + userid + ")");
            $('#lblDob').html(dob + ", D.O.E: " + panDateLoaded);
            $('#lblPan').html(panno);  
            $('#lblPanImg').html("<a href='" + PANImage + "' data-fancybox='gallery' style='min-height:267px; min-height:450px;' > <img src='" + PANImage + "' Width='450px' Height='267px'> </a>");

         
        }
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">All Blogs</h4>
   
    <div class="table-responsive">
        <asp:GridView ID="GridAllBlogs" runat="server" AutoGenerateColumns="False" AllowPaging="true" PageSize="50"
            EmptyDataText="No Data Found." DataKeyNames="blogid" CssClass="table table-striped table-hover"
            OnPageIndexChanging="GridAllBlogs_PageIndexChanging">
            <Columns>
                <asp:TemplateField Visible="false">
                    <HeaderTemplate>
                        <span id="cbSelectSpan">
                            <input type="checkbox" id="cbSelectAll" onclick="ShowHideDiv(this,2)" />
                            Approve all</span>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <input type="checkbox" name="ChequeSelected" class="cbSelectRow" id="cbSelectRowid" onclick="ShowHideDiv(this,2)" value="<%# Eval("blogid") %>"></input>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="false">
                    <HeaderTemplate>
                        <span id="cbRejectSpan">
                            <input type="checkbox" id="cbSelectAllrej" onclick="ShowHideDiv(this,1)" />
                            Reject all</span>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <input type="checkbox" name="ChequeSelectedrej" class="cbSelectRowreject" id="cbSelectRowrejectid" value="<%# Eval("blogid") %>" onclick="ShowHideDiv(this,1)"></input>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="View">
                    <ItemTemplate>
                        <a href="#" class="gridViewToolTip text-blue" onclick='openPopup(this,"<%# Eval("blogid")%>","<%# Eval("title")%>","<%# Eval("title")%>","<%# Eval("author")%>","<%# Eval("created_dt")%>","<%# Eval("title","../images/KYC/PanImage/{0}")%>");return false;' data-bs-toggle='modal' data-bs-target='#Model_Popup'>View</a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:HyperLinkField DataNavigateUrlFields="title" HeaderText="Title" DataTextField="title"
                    ControlStyle-ForeColor="Blue" DataNavigateUrlFormatString="Edit_Profile.aspx?n={0}" />
                    
                <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                <asp:BoundField DataField="author" HeaderText="Author" />
                <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("AppMstMobile") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="panno" HeaderText="PAN No." />
                <asp:BoundField DataField="panDateLoaded" HeaderText="D.O.E" />
                <%--<asp:TemplateField HeaderText="PAN Image">
                    <ItemTemplate>
                        <a href="<%# Eval("PANImage","../images/KYC/PanImage/{0}") %>" data-fancybox="gallery">
                            <asp:Image ID="PANImage" runat="server" Height="50px" ImageUrl='<%# Eval("PANImage","../images/KYC/PanImage/{0}") %>' Width="50px" />
                                
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>--%>
               
            </Columns>
        </asp:GridView>
        <%-- <div id="popupdiv" title="Basic modal dialog" style="display: none">
            
        </div>--%>

        <div id="Model_Popup" class="modal fade show" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-md modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <h5 class="modal-title text-white"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;PAN Documents</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closePopup_Model()">
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-3 pb-2">User Id </div>
                            <div class="col-sm-9 pb-2">
                                <div id="lblId"></div>
                            </div>

                            <div class="col-sm-3 pb-2">D.O.B</div>
                            <div class="col-sm-9 pb-2">
                                <div id="lblDob"></div>
                            </div>

                            <div class="col-sm-3 pb-2">Pan No</div>
                            <div class="col-sm-9">
                                <div id="lblPan"></div>
                            </div>

                            <div class="col-sm-3 pb-2">Status</div>
                            <div class="col-sm-9">
                                <div id="lblPanStatus" style="width: 100%;"></div>
                            </div>

                            <br />

                            <div class="col-sm-12 pb-2">
                                <div id="lblPanImg" ></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</asp:Content>
