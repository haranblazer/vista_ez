<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="AddEditProduct.aspx.cs" Inherits="d2000admin_AddEditProduct" EnableEventValidation="false"
    ValidateRequest="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <script src="https://cdn.ckeditor.com/4.5.6/standard/ckeditor.js"></script>
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script src="//cdn.ckeditor.com/4.15.0/standard/ckeditor.js"></script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script type="text/javascript">
        function CheckUploadFile() {
            var file = document.querySelector('#<%=imgUpload.ClientID %>').files[0];
            if (file.size > 512000) {
                alert("File size must be less than equal to 500 KB. Please reduce your file size then upload.");
                var uploadControl = document.getElementById('<%=imgUpload.ClientID%>');
                uploadControl.value = "";
                return false;
                file.focus();
            }
            else {
                return true;
            }
        }



        $(function () {
            $('#<%=txt_HSN.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });
            $('#<%=txtProductName.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

            $('#<%=txt_Prod_Display.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

            $('#<%=txt_TagName.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

            $('#<%=txtPack.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

            $('#<%=txt_CaseSize.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

            $('#<%=txt_MaxLoyalty.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });

            $('#<%=txtWeight.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 32 && e.which != 46 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 96 || e.which > 122) && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });
        });

        function onlyNumber(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }
            catch (err) {
                alert(err.Description);
            }
        }

        function Alphanumeric(e, t) {
            try {
                if (window.event) { var charCode = window.event.keyCode; }
                else if (e) { var charCode = e.which; }
                else { return true; }
                if (charCode = 32 || (charCode >= 48 && charCode <= 57) || (charCode >= 65 && charCode <= 90)
                    || (charCode >= 97 && charCode <= 122)) {
                    return true;
                }
                return false;
            }
            catch (err) { alert(err.Description); }
        }


    </script>



    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Add Product </h4>
    </div>

    <div class="form-group row">
        <div class="col-sm-2 control-label">
            Category
        </div>
        <div class="col-sm-4">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div class="col-sm-2 control-label">Sub Category</div>
        <div class="col-sm-4">
            <asp:DropDownList ID="ddl_Sub_Cat" runat="server" CssClass="form-control">
            </asp:DropDownList>

        </div>

        <div class="col-sm-4 control-label d-none">
            <asp:CheckBox ID="chk_IsComboPack" runat="server" Text="Packed Product" Style="width: 32px; font-size: 16px;" />
        </div>

    </div>
    <br />
    <div class="alert alert-primary alert-dismissible fade show">

        <strong>Note!</strong> Special characters not allowed( !@#$%^&*()_+|\}]{[:;"'?/.>,<~ )
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
    </div>

    <asp:Panel ID="Pro" runat="server">

        <div class="form-group row">
            <div class="col-sm-2 control-label">Product/Bar Code<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:TextBox ID="txtProductCode" runat="server" ValidationGroup="p" oninput="removeSpecialCharacters(this);" CausesValidation="True" MaxLength="50" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-sm-2 control-label"></div>
            <div class="col-sm-4">
            </div>
            <div class="clearfix"></div>


            <div class="col-sm-2 control-label">Product Name<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:TextBox ID="txtProductName" runat="server" ValidationGroup="p" CausesValidation="True" MaxLength="50" CssClass="form-control" oninput="removeSpecialCharacters(this);" onkeypress="return Alphanumeric(event,this);"></asp:TextBox>
            </div>
            <div class="col-sm-2 control-label">Is Variant<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:CheckBox runat="server" ID="chk_variant" />
            </div>
             <div class="clearfix"></div>

            <div class="col-sm-2 control-label">Display Product<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_Prod_Display" runat="server" ValidationGroup="p" CausesValidation="True" MaxLength="30" CssClass="form-control"></asp:TextBox>
            </div>
             <div class="col-sm-2 control-label">Brand</div>
            <div class="col-sm-4">
                <asp:DropDownList ID="ddl_bid" runat="server" CssClass="form-control"> 
                </asp:DropDownList>
            </div>

            <div class="clearfix"></div>


            <div class="col-sm-2 control-label">Tag Line</div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_TagName" runat="server" ValidationGroup="p" CausesValidation="True" MaxLength="5000" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-2 control-label">Youtube Url</div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_youtubeUrl" runat="server" ValidationGroup="p" CausesValidation="True" MaxLength="100" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="clearfix"></div>


            <div class="col-sm-2 control-label">Purchase Price<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_ProductCost" runat="server" ValidationGroup="p" CausesValidation="True" MaxLength="50" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-2 control-label"><b>Purchase GST:<span style="color: Red">*</span> </b></div>
            <div class="col-md-4 col-sm-4">
                <asp:DropDownList ID="ddlGST" runat="server" CssClass="form-control" onchange="CalculateDP();">
                    <asp:ListItem>0</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>28</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="clearfix"></div>


            <div class="col-sm-2 control-label">HSN Code<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_HSN" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
            </div>
            <div class="col-sm-2 control-label">Weight<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:TextBox ID="txtWeight" runat="server" ValidationGroup="p" CausesValidation="True" CssClass="form-control" MaxLength="7"></asp:TextBox>
                <span class="text-danger text-sm-left">Note*: 1kg=1.0, 500gm=0.5</span>
            </div>
            <div class="clearfix"></div>


            <div class="col-sm-2 control-label d-none">Is Redeem<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4 d-none">
                <asp:DropDownList ID="ddl_IsRedeem" runat="server" CssClass="form-control">
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-2 control-label d-none">Sale Type<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4 d-none">
                <asp:DropDownList ID="ddl_SaleType" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">All</asp:ListItem>
                    <asp:ListItem Value="1">First Purchase</asp:ListItem>
                    <asp:ListItem Value="3">Generation</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="clearfix"></div>


            <div class="col-sm-2 control-label ">Case Size<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4 ">
                <asp:TextBox ID="txt_CaseSize" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
            </div>

            <div class="col-sm-2 control-label">Max Qty Loyalty<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_MaxLoyalty" runat="server" CssClass="form-control" MaxLength="10" ValidationGroup="p"></asp:TextBox>
            </div>
            <div class="clearfix"></div>


            <div class="col-sm-2 control-label ">Pack Size<b><span style="color: Red">*</span></b></div>
            <div class="col-sm-4 ">
                <asp:TextBox ID="txtPack" runat="server" ValidationGroup="p" CssClass="form-control"></asp:TextBox>
                <asp:DropDownList ID="ddlPackSize" runat="server" onchange="showPackUnit(this)" ValidationGroup="p" CssClass="form-control">
                </asp:DropDownList>
            </div>


            <div class="col-sm-2 control-label ">Left To Right Scroll </div>
            <div class="col-sm-4 ">
                <asp:TextBox ID="txt_TitleScroll" runat="server" ValidationGroup="p" MaxLength="500" CssClass="form-control"
                    TextMode="MultiLine" Height="50px"></asp:TextBox>
            </div>
            <div class="clearfix"></div>

            <div class="col-sm-2 control-label">Ingredients Title</div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_INGREDIENTS_Title" runat="server" CssClass="form-control"
                    MaxLength="500" TextMode="MultiLine" Height="50px"></asp:TextBox>
            </div>
            <div class="col-sm-2 control-label">Ingredients Topic</div>
            <div class="col-sm-4">
                <asp:TextBox ID="txt_Ingredients_Topic" runat="server" CssClass="form-control"
                    MaxLength="500" TextMode="MultiLine" Height="50px"></asp:TextBox>
            </div>

            <div class="col-sm-2 control-label">Country</div>
            <div class="col-sm-4">
                <asp:DropDownList ID="ddl_Countries" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">Select Country</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-2 control-label">Length Unit</div>
            <div class="col-sm-4">
                <asp:DropDownList ID="ddl_LUnit" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">Select Length Unit</asp:ListItem>
                    <asp:ListItem Value="mm">mm</asp:ListItem>
                    <asp:ListItem Value="cm">cm</asp:ListItem>
                    <asp:ListItem Value="m">m</asp:ListItem>
                    <asp:ListItem Value="in">in</asp:ListItem>
                    <asp:ListItem Value="ft">ft</asp:ListItem>
                    <asp:ListItem Value="yd">yd</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-2 control-label">Length</div>
            <div class="col-sm-4">
                <asp:TextBox runat="server" onkeypress="return onlyNumbers(event,this);" ID="txt_length" CssClass="form-control"></asp:TextBox>

            </div>
            <div class="col-sm-2 control-label">Width</div>
            <div class="col-sm-4">
                <asp:TextBox runat="server" ID="txt_width" onkeypress="return onlyNumbers(event,this);" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-2 control-label">Height</div>
            <div class="col-sm-4">
                <asp:TextBox runat="server" ID="txt_height" onkeypress="return onlyNumbers(event,this);" CssClass="form-control"></asp:TextBox>
            </div>



            <div id="div_Product" runat="server" visible="false" class="col-sm-2 control-label">
                Upload Image
            </div>
            <div id="div_Product1" runat="server" visible="false" class="col-sm-4">
                <asp:FileUpload ID="imgUpload" runat="server" ForeColor="Black" onchange="CheckUploadFile();" accept=".png,.jpg,.jpeg,.gif" /><br />
                <span style="color: Red">Note: &nbsp; Image size must be width 400px and height 525px and File Size must be less than 500 KB.<br />
                    Only .jpg/.jpeg/.png/.gif file types are allowed.<br />
                    Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>
                </span>
            </div>
            <div class="clearfix"></div>

            <div class="form-group" style="padding-top: 7px;">
                <label class="col-sm-2 control-label">
                    Description:
                     <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/description.jpg" width="100%" />
                    </div>
                </label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtTitle10" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p" Visible="false"></asp:TextBox>
                </div>

                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtDescription1" runat="server" placeholder="Description" TextMode="MultiLine"
                        CssClass="form-control" Rows="3"></asp:TextBox>

                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtDescription1.ClientID%>');
                    </script>
                    <label id="Label1" runat="server">
                    </label>
                </div>
            </div>
            <div class="clearfix"></div>
            <h2 class="head">हिन्दी</h2>
            <div class="clearfix"></div>
            <div class="form-group" style="padding-top: 7px;">
                <label class="col-sm-2 control-label">
                    Title 1:
                     <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/product_detail_1.jpg" width="100%" />
                    </div>
                </label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtTitle1" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <label class="col-sm-2 control-label">
                    Description 1:</label>
                <div class="clearfix"></div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtDescription2" runat="server" placeholder="Description" TextMode="MultiLine"
                        CssClass="form-control" Rows="3"></asp:TextBox>
                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtDescription2.ClientID%>');
                    </script>
                    <label id="Label2" runat="server"></label>
                </div>
            </div>
            <div class="form-group" style="padding-top: 7px;">
                <label class="col-sm-2 control-label">
                    Title 2:
                    <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/product_detail_2.jpg" width="100%" />
                    </div>
                </label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtTitle2" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-2">
                    <b>Description 2:</b>
                </div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtDescription3" runat="server" placeholder="Description" TextMode="MultiLine"
                        CssClass="form-control" Rows="3"></asp:TextBox>
                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtDescription3.ClientID%>');
                    </script>
                    <label id="Label3" runat="server">
                    </label>
                </div>
                <div class="clearfix"></div>
                <label class="col-sm-2 control-label">
                    Title 3:
                    <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/product_detail_3.jpg" width="100%" />
                    </div>
                </label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtTitle3" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-2">
                    <b>Description 3:</b>
                </div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtDescription4" runat="server" placeholder="Description" TextMode="MultiLine"
                        CssClass="form-control" Rows="3"></asp:TextBox>
                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtDescription4.ClientID%>');
                    </script>
                    <label id="Label4" runat="server">
                    </label>
                </div>
                <div class="clearfix"></div>


                <label class="col-sm-2 control-label">
                    Title 4:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtTitle4" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-2">
                    <b>Description 4:</b>
                </div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtDescription5" runat="server" placeholder="Description" TextMode="MultiLine"
                        CssClass="form-control" Rows="3"></asp:TextBox>

                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtDescription5.ClientID%>');
                    </script>
                    <label id="Label5" runat="server">
                    </label>
                </div>
                <label class="col-sm-2 control-label">
                    Manufacture Title:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txt_manufacture_title" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-2">
                    <b>Manufacture Detail:</b>
                </div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txt_manufacture_detail" runat="server" placeholder="Description" TextMode="MultiLine"
                        CssClass="form-control" Rows="3"></asp:TextBox>

                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txt_manufacture_detail.ClientID%>');
                    </script>
                    <label id="Label9" runat="server">
                    </label>
                </div>



                <%-- Ingredients --%>


                <label class="col-sm-2 control-label">
                    Ingredients key 1:
                     <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/ingredients_key_1.jpg" width="50%" />
                    </div>
                </label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txt_PT8" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-2">
                    <b>Ingredients Description 1:</b>
                </div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtPD8" runat="server" placeholder="Description" TextMode="MultiLine" CssClass="form-control" Rows="2"></asp:TextBox>
                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtPD8.ClientID%>');
                    </script>
                    <label id="Label6" runat="server">
                    </label>
                </div>
                <div class="clearfix"></div>



                <label class="col-sm-2 control-label">
                    Ingredients key 2:
                     <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/ingredients_key_2.jpg" width="50%" />
                    </div>
                </label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txt_PT9" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-2">
                    <b>Ingredients Description 2:</b>
                </div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtPD9" runat="server" placeholder="Description" TextMode="MultiLine" CssClass="form-control" Rows="2"></asp:TextBox>
                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtPD9.ClientID%>');
                    </script>
                    <label id="Label7" runat="server">
                    </label>
                </div>
                <div class="clearfix"></div>



                <label class="col-sm-2 control-label">
                    Ingredients key 3:
                     <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/ingredients_key_3.jpg" width="50%" />
                    </div>
                </label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txt_PT10" runat="server" CssClass="form-control" MaxLength="50" ValidationGroup="p"></asp:TextBox>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-2">
                    <b>Ingredients Description 3:</b>
                </div>
                <div class="col-sm-12" style="padding-top: 7px;">
                    <asp:TextBox ID="txtPD10" runat="server" placeholder="Description" TextMode="MultiLine" CssClass="form-control" Rows="2"></asp:TextBox>
                    <script type="text/javascript" lang="javascript">
                        CKEDITOR.replace('<%=txtPD10.ClientID%>');
                    </script>
                    <label id="Label8" runat="server">
                    </label>
                </div>
                <div class="clearfix"></div>



                <div class="col-sm-12 control-label">
                    <span style="color: Red">Note: &nbsp; Image size must be width 1400px and height 520px.<br />
                        Only .jpg/.jpeg/.png/.gif file types are allowed.<br />
                </div>
                <div class="col-sm-2 control-label">
                    Effective Result Image
                    <i class="fa fa-question-circle selector" aria-hidden="true" style="position: relative;"></i>
                    <div class="selector_data" style="display: none; position: absolute; z-index: 9;">
                        <img src="images/detail_page_banner2.jpg" width="50%" />
                    </div>
                </div>
                <div class="col-sm-4">
                    <asp:FileUpload ID="FU_EffectResultImg" runat="server" ForeColor="Black" accept=".png,.jpg,.jpeg,.gif" /><br />
                    <div id="div_EffectResult" runat="server"></div>
                </div>
                <div class="clearfix"></div>

            </div>

        </div>
        <hr />
        <div class="clearfix">
        </div>

        <div class="form-group">
            <%-- <label class="col-sm-2 control-label">
                Upload PDF</label>--%>
            <div class="col-sm-4">
                <asp:FileUpload ID="pdfUpload" runat="server" ForeColor="Black" Visible="false" /><br />
                <%--<asp:RegularExpressionValidator
                    ID="RegularExpressionValidator3" runat="server"
                    ErrorMessage="Only PDF files are allowed!" ValidationGroup="p"
                    ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.pdf|.PDF)$"
                    ControlToValidate="pdfUpload" CssClass="text-red"></asp:RegularExpressionValidator>--%>
            </div>

            <label class="col-sm-2 control-label">
                &nbsp;</label>
            <div class="col-sm-4">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                    ValidationGroup="p" CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure you want to proceed？')" />
            </div>
        </div>
        <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="ra" HeaderText="Please Check the following..." />
        <div class="form-group">
            <label class="col-sm-2 control-label">
                &nbsp;</label>
            <div class="col-sm-4">
                <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="False" Font-Names="Arial"></asp:Label>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <br />
        <div class="form-group">
            <label class="col-sm-2 control-label">
                &nbsp;</label>
            <div class="col-sm-4">

                <%--  <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                                            Display="None" ErrorMessage="Please Enter Title !" ForeColor="#C00000" Style="left: 41px; position: static; top: -29px"
                                            ValidationGroup="p" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revTitle" runat="server" ControlToValidate="txtTitle"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Title Contains Alphabetic Value!"
                                            ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9\s]*$" ValidationGroup="p"></asp:RegularExpressionValidator>--%>
                <asp:RequiredFieldValidator ID="revProductName" runat="server" ControlToValidate="txtProductName"
                    Display="None" ErrorMessage="Please Enter Product Name !" ForeColor="#C00000"
                    SetFocusOnError="true" Style="left: 41px; position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                    ControlToValidate="txtProductName" SetFocusOnError="true" Display="None" ErrorMessage="Product Name Contains Alphabetic Value!"
                    ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9\s]*$" ValidationGroup="p"></asp:RegularExpressionValidator>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_Prod_Display"
                    Display="None" ErrorMessage="Please Enter Product Display Name !" ForeColor="#C00000"
                    SetFocusOnError="true" Style="left: 41px; position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server"
                    ControlToValidate="txt_Prod_Display" SetFocusOnError="true" Display="None" ErrorMessage="Product Display Name Contains Alphabetic Value!"
                    ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9\s]*$" ValidationGroup="p"></asp:RegularExpressionValidator>



                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                    ControlToValidate="txt_TagName" SetFocusOnError="true" Display="None" ErrorMessage="Product Name Contains Alphabetic Value!"
                    ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9\s]*$" ValidationGroup="p"></asp:RegularExpressionValidator>

                <asp:RequiredFieldValidator ID="rfvPacksize" runat="server" ControlToValidate="txtPack"
                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Pack Size!"
                    ForeColor="#C00000" ValidationGroup="p"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator20" runat="server"
                    SetFocusOnError="true" ControlToValidate="txtPack" Display="None" ErrorMessage="Pack Size Contains Numeric Value Without Space !"
                    Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9]*$" ValidationGroup="p"></asp:RegularExpressionValidator>


                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_CaseSize"
                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Case Size!"
                    ForeColor="#C00000" ValidationGroup="p"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                    SetFocusOnError="true" ControlToValidate="txt_CaseSize" Display="None" ErrorMessage="Case Size Contains Numeric Value Without Space !"
                    Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9]*$" ValidationGroup="p"></asp:RegularExpressionValidator>


                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                    SetFocusOnError="true" ControlToValidate="txt_MaxLoyalty" Display="None" ErrorMessage="Max Qty loyalty Contains Numeric Value Without Space !"
                    Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9]*$" ValidationGroup="p"></asp:RegularExpressionValidator>


                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtWeight"
                    SetFocusOnError="true" Display="None" ErrorMessage="Please Enter Weight !" ForeColor="#C00000"
                    Style="left: 41px; position: static; top: -29px" ValidationGroup="p"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtWeight"
                    Display="None" ErrorMessage="Weight Contains Numeric Value Without Space !" SetFocusOnError="true"
                    Font-Bold="False" ForeColor="#C00000" Style="position: static" ValidationExpression="^[0-9.]*$"
                    ValidationGroup="p"></asp:RegularExpressionValidator>


                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="p" HeaderText="Please Check the following..." />

            </div>
        </div>

    </asp:Panel>



    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script type="text/javascript">
        //(function ($) {
        //    //append div to document body
        //    $('<div class="selector">Test</div>').appendTo(document.body);
        //}(jQuery));
        $(".selector").on({
            mouseenter: function () {
                $('.selector_data').css("display", "block");
            },
            mouseleave: function () {
                $('.selector_data').css("display", "none");
            }
        });
        //  removeSpecialCharacters(myInput, /[^a-zA-Z0-9\s]/g); // Remove all non-alphanumeric characters and spaces
        function removeSpecialCharacters(input) {
            var regex = /[!@#$%^&*()_+|\\{}\[\]:"';?\/.,><~]/g;
            input.value = input.value.replace(regex, '');
        }
        function onlyNumbers(e, t) {
            if (window.event) { var charCode = window.event.keyCode; }
            else if (e) { var charCode = e.which; }
            else { return true; }
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) { return false; }
            return true;

        }

        function Alphanumeric_space(e, t) {
            try {
                if (window.event) { var charCode = window.event.keyCode; }
                else if (e) { var charCode = e.which; }
                else { return true; }
                if (charCode = 32 || (charCode >= 48 && charCode <= 57) || (charCode >= 65 && charCode <= 90)
                    || (charCode >= 97 && charCode <= 122)) {
                    return true;
                }
                return false;
            }
            catch (err) { alert(err.Description); }
        }
    </script>

    <style type="text/css">
        .accordionContent {
            background-color: #FFFFFF;
            border-color: -moz-use-text-color #2F4F4F #2F4F4F;
            padding: 10px 5px 5px;
            width: 100%;
        }

        .accordionHeaderSelected {
            background-color: #fbb34b;
            border: 1px solid #2F4F4F;
            color: white;
            cursor: pointer;
            font-family: Arial,Sans-Serif;
            font-weight: bold;
            margin-top: 5px;
            padding: 5px;
            width: 100%;
            background-image: url("images/minus.png");
            background-repeat: no-repeat;
            background-position: right;
        }

        .accordionHeader {
            background-color: #fbb34b;
            border: 1px solid #2F4F4F;
            color: white;
            cursor: pointer;
            font-family: Arial,Sans-Serif;
            font-weight: bold;
            margin-top: 5px;
            padding: 5px;
            width: 100%;
            background-image: url("images/plus.png");
            background-repeat: no-repeat;
            background-position: right;
        }

        .href {
            color: White;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
        }

        .ProductHead {
            background-color: #fbb34b;
            border: 1px solid #2F4F4F;
            color: white;
            font-family: Arial,Sans-Serif;
            font-weight: bold;
            margin-top: 5px;
            padding: 5px;
            width: 100%;
            background-repeat: no-repeat;
            background-position: right;
        }


        .cke_contents {
            height: 500px !important;
        }
    </style>
</asp:Content>
