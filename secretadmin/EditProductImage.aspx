<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditProductImage.aspx.cs"
    EnableEventValidation="false" Inherits="d2000admin_EditProductImage" MasterPageFile="~/secretadmin/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Add Product Image</h4>
    </div>


    <div class="form-horizontal">
        <div class="row">
            <div class="col-sm-6">
                <asp:Label ID="lblProductName" runat="server" Font-Bold="True" Font-Size="11pt" ForeColor="Gray"></asp:Label><br />
            </div>
            <div id="div_ColorSize" runat="server" visible="false" class="col-sm-6 row">
                <div class="col-sm-1 control-label">
                    <label>Size</label>
                </div>
                <div class="col-sm-3">
                    <asp:DropDownList ID="ddl_SZId" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
                <div class="col-sm-2 control-label">
                    <label>Color</label>
                </div>
                <div class="col-sm-5">
                    <asp:DropDownList ID="ddl_CLRId" runat="server" CssClass="form-control" onchange="BindColor()">
                    </asp:DropDownList>

                </div>
                <div class="col-sm-1">
                    <div id="div_colorCode" runat="server"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="form-group row">
            <div class="control-label col-sm-2">
                Select Image :
            </div>
            <div class="col-sm-4">
                <asp:FileUpload ID="imgUploadMore" runat="server" CssClass="btn btn-default"
                    accept=".png,.jpg,.jpeg,.gif,.mp4" AllowMultiple="true" onchange="previewFile();" />

            </div>
              <div class="control-label col-sm-2">
                 Priority No.
              </div>
             <div class="col-sm-2">
                  <asp:TextBox runat="server" ID="txt_PrNo" CssClass="form-control"></asp:TextBox>
             </div>
            <div class="col-sm-2">
                &nbsp;<asp:Button ID="btaddmore" runat="server" Text="Submit"
                    CssClass="btn btn-primary" OnClick="btaddmore_Click" />

                <asp:Label ID="lblmessagemore" Font-Size="13px" runat="server" ForeColor="#C00000"></asp:Label>
            </div>

            <div class="col-sm-4">
                <asp:Image ID="imgProduct" runat="server" Width="105px" ToolTip="Default Image Show" Height="112px" CssClass="img-responsive" />
            </div>
            <br />
            <div class="alert alert-primary alert-dismissible fade show">

                <strong>Note!</strong> Image size must be width 1100 px and height 1100 px
                                <br />
                and Image size should be less than 500 KB. 
                                ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
            </div>
            <div class="clearfix">
            </div>
            <br />

        </div>

        <div class="clearfix">
        </div>
        <div class="form-group">
            <div class="col-md-12 table-responsive">

                <asp:DataList ID="dlproductimage" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                    RepeatLayout="Table">
                    <ItemTemplate>
                        <div style="padding: 10px">
                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("SrNo") %>' Visible="false"></asp:Label>
                            <a href='<%# Eval("ImageName","../ProductImage/{0}") %>' data-fancybox="gallery">
                                <asp:Image ID="productimage" runat="server" ImageUrl='<%# Eval("ImageName","../ProductImage/{0}") %>'
                                    Width="300px" Height="350px" CssClass="img-responsive img-thumbnail" />
                            </a>
                            <br />
                            <%# Eval("Size").ToString() == "" ? "" : " Size : "+ Eval("Size") %>

                            <%# Eval("ColorName").ToString() == "" ? "" :
                             "Color : "+Eval("ColorName") +"<span style='height:20px; width:20px; display:inline-block; border-radius:50%; background-color:"+ Eval("ColorCode")+"'></span> "%>
                            <br />

                            <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("PrimaryDefault").ToString() != "1"? "Set as Primary default" : "Primary Default" %>' OnClick="lnkPrimaryDef_Click" CssClass="btn btn-success"
                                OnClientClick="return confirm('Are you sure want to set this record as primary default?')" BackColor='<%# Eval("PrimaryDefault").ToString() == "1"? System.Drawing.Color.Green : System.Drawing.Color.Gray %>'></asp:LinkButton>
                            &nbsp;&nbsp;&nbsp; 

                            <asp:LinkButton ID="lnkSetdefault" runat="server" Text='<%# Eval("ImageDefault").ToString() != "1"? "Set as default" : "Default" %>' OnClick="lnkDef_Click" CssClass="btn btn-success"
                                OnClientClick="return confirm('Are you sure want to set this record as default?')" BackColor='<%# Eval("ImageDefault").ToString() == "1"? System.Drawing.Color.Green : System.Drawing.Color.Gray %>'></asp:LinkButton>
                            &nbsp;&nbsp;&nbsp; 
                            <asp:LinkButton ID="lnkDel" runat="server" OnClick="lnkDel_Click" CssClass="fa fa-times" ForeColor="Red" Font-Size="Large"
                                OnClientClick="return confirm('Are you sure want to delete this record?')"></asp:LinkButton><br />
                            <div class="row"><div class="col-sm-4 control-label">Priority No.</div>
 <div class="col-sm-4">
     <asp:TextBox ID="txt_PNo" CssClass="form-control" OnTextChanged="txt_PNo_TextChanged" AutoPostBack="true" runat="server"></asp:TextBox></div>
 </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>



        <div class="clearfix"></div>
        <%--First GiF--%>
        <%--<br />
        <hr />--%>
        <div class="form-group d-none">

            <label class="col-sm-2 control-label">
                Upload GIF 1</label>
            <label class="col-sm-2 control-label">
                <asp:TextBox runat="server" ID="txt_title" placeholder="Enter Title"></asp:TextBox>
            </label>
            <div class="col-sm-2 control-label">
                <%--                 <asp:Label ID="Label2" runat="server" Text='<%# Eval("ProductId") %>' Visible="false"></asp:Label>--%>

                <%--  ImageUrl='<%# Eval("gif1","../ProductImage/{0}") %>' --%>
                <asp:Image runat="server" ID="Image1" Width="100px" Height="100px" />
            </div>
            <div class="col-sm-4">
                <asp:FileUpload ID="GIF_Upload" runat="server" ForeColor="Black" accept=".gif" />
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4" id="div_GIF1_thumbnail" runat="server">
            </div>
        </div>
        <%-- <div class="form-group">
           
             <asp:Label ID="lblId" runat="server" Text='<%# Eval("ProductId") %>' Visible="false"></asp:Label>


             <asp:Image runat="server" ID="Img_GIF1" ImageUrl='<%# Eval("ImageName","../ProductImage/{0}") %>'    Width="100px" Height="100px"/>
             </div>--%>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <asp:Button ID="Button3" runat="server" Text="Update GIF" OnClick="Button3_Click"
                    CssClass="btn btn-primary" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                         <asp:Button ID="Button4" runat="server" Text="Delete GIF" OnClick="Button4_Click"
                             CssClass="btn btn-danger" />
            </div>
        </div>
        <%--<br />
        <hr />--%>
        <%--Second GiF--%>
        <div class="form-group d-none">

            <label class="col-sm-2 control-label">
                Upload GIF 2</label>
            <label class="col-sm-2 control-label">
                <asp:TextBox runat="server" ID="txt_title2" placeholder="Enter Title"></asp:TextBox>
            </label>
            <div class="col-sm-2 control-label">
                <%--                 <asp:Label ID="Label3" runat="server" Text='<%# Eval("ProductId") %>' Visible="false"></asp:Label>--%>


                <asp:Image runat="server" ID="Image2" Width="100px" Height="100px" />
            </div>
            <div class="col-sm-4">
                <asp:FileUpload ID="GIF_Upload2" runat="server" ForeColor="Black" accept=".gif" />
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4" id="div_gif2" runat="server">
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <asp:Button ID="Button5" runat="server" Text="Update GIF" OnClick="Button5_Click"
                    CssClass="btn btn-primary" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                         <asp:Button ID="Button6" runat="server" Text="Delete GIF" OnClick="Button6_Click"
                             CssClass="btn btn-danger" />
            </div>
        </div>
        <%--<br />
        <hr />--%>
        <%--Third GiF--%>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label">
                Upload GIF 3</label>
            <label class="col-sm-2 control-label">
                <asp:TextBox runat="server" ID="txt_title3" placeholder="Enter Title"></asp:TextBox>
            </label>
            <div class="col-sm-2 control-label">
                <%--                 <asp:Label ID="Label4" runat="server" Text='<%# Eval("ProductId") %>' Visible="false"></asp:Label>--%>


                <asp:Image runat="server" ID="Image3" Width="100px" Height="100px" />
            </div>

            <div class="col-sm-4">
                <asp:FileUpload ID="GIF_Upload3" runat="server" ForeColor="Black" accept=".gif" />
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4" id="div_gif3" runat="server">
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <asp:Button ID="Button7" runat="server" Text="Update GIF" OnClick="Button7_Click"
                    CssClass="btn btn-primary" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                         <asp:Button ID="Button8" runat="server" Text="Delete GIF" OnClick="Button8_Click"
                             CssClass="btn btn-danger" />
            </div>
        </div>
       <%-- <br />
        <hr />--%>
        <%--Fourth GiF--%>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label">
                Upload GIF 4</label>
            <label class="col-sm-2 control-label">
                <asp:TextBox runat="server" ID="txt_title4" placeholder="Enter Title"></asp:TextBox>
            </label>
            <div class="col-sm-2 control-label">
                <%-- <asp:Label ID="Label5" runat="server" Text='<%# Eval("ProductId") %>' Visible="false"></asp:Label>--%>


                <asp:Image runat="server" ID="Image4" Width="100px" Height="100px" />
            </div>
            <div class="col-sm-4">
                <asp:FileUpload ID="GIF_Upload4" runat="server" ForeColor="Black" accept=".gif" />
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4" id="div_gif4" runat="server">
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <asp:Button ID="Button9" runat="server" Text="Update GIF" OnClick="Button9_Click"
                    CssClass="btn btn-primary" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                         <asp:Button ID="Button10" runat="server" Text="Delete GIF" OnClick="Button10_Click"
                             CssClass="btn btn-danger" />
            </div>
        </div>
        <%--<hr />--%>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label">
                Upload Video</label>
            <div class="col-sm-4">
                <asp:FileUpload ID="FU_Video" runat="server" ForeColor="Black" accept=".mp4" />
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4" id="div_VideoThumbnails" runat="server">
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <asp:Button ID="Button1" runat="server" Text="Update Video" OnClick="Button1_Click"
                    CssClass="btn btn-primary" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                         <asp:Button ID="Button2" runat="server" Text="Delete Video" OnClick="Button2_Click"
                             CssClass="btn btn-danger" />
            </div>
        </div>





        <div class="clearfix"></div>
        <br />
        <hr />
        <div class="form-group d-none">
            <label class="col-sm-2 control-label">
                Upload PDF</label>
            <div class="col-sm-4">
                <asp:FileUpload ID="pdfUpload" runat="server" ForeColor="Black" accept=".pdf" />
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <div id="li_pdf" runat="server"></div>
            </div>
        </div>
        <div class="form-group d-none">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <asp:Button ID="btnPdfUpdate" runat="server" Text="UpdatePDF" OnClick="btnPdfUpdate_Click"
                    CssClass="btn btn-primary" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                         <asp:Button ID="btnPdfDelete" runat="server" Text="Delete PDF" OnClick="btnPdfDelete_Click"
                             CssClass="btn btn-danger" />
            </div>
        </div>
    </div>



    <div class="modal fade bd-example-modal-lg" tabindex="-1" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="div_Header" runat="server"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal">
                    </button>
                </div>
                <div class="modal-body">
                    <div id="div_video" runat="server"></div>
                </div>
            </div>
        </div>
    </div>



    <style type="text/css">
        .style1 {
            color: #FFFFFF;
        }

        .style2 {
            color: #FFFFFF;
            font-weight: bold;
        }
    </style>
    <script src="../js/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            BindColor();
        });

        function BindColor() {
            let ColorCode = $('#<%=ddl_CLRId.ClientID%> option:selected').text();
            ColorCode = ColorCode.split("#");
            ColorCode = "#" + ColorCode[1];
            $("#<%=div_colorCode.ClientID%>").css({ "height": "20px", "width": "20px", "background-color": ColorCode, "display": "inline-block", "border-radius": "50%" });
        }

        function previewFile() {
            var preview = document.querySelector('#<%=imgProduct.ClientID %>');
            var file = document.querySelector('#<%=imgUploadMore.ClientID %>').files[0];
            if (file.size > 512000) {
                alert("File size must be less than equal to 500 KB. Please reduce your file size then upload.");
                var uploadControl = document.getElementById('<%=imgUploadMore.ClientID%>');
                uploadControl.value = "";
                file.focus();
                return false;
            }
            var reader = new FileReader();
            reader.onloadend = function () {
                preview.src = reader.result;
            }
            if (file) {
                reader.readAsDataURL(file);
            }
            else {
                preview.src = "";
            }
        }

    </script>


</asp:Content>
