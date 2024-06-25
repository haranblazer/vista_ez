<%@ Page Title="Add File" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="download.aspx.cs" Inherits="download" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function HideLabel() {
            var seconds = 10;
            setTimeout(function () {
                document.getElementById("<%=lblMessage.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Upload File</h4>
    </div>

    <div class="row">
        <div class="col-md-2 control-label">
            Doc Type 
        </div>
        <div class="col-md-3">
            <%--<asp:DropDownList runat="server" ID="ddl_doctype" CssClass="form-control">
                <asp:ListItem Value="0">Select Doc Type</asp:ListItem>
                <asp:ListItem Value="1">Product Catalog</asp:ListItem>
                <asp:ListItem Value="2">Forms</asp:ListItem>
                <asp:ListItem Value="3">Download</asp:ListItem>
                <asp:ListItem Value="4">Compilance</asp:ListItem>
            </asp:DropDownList--%>
            <select id="ddl_doctype" runat="server" class="form-control" onchange="DisType()">
                <option value="0" selected="selected">Select Doc Type</option>
                <option value="1">Product Catalog</option>
                <option value="2">Forms</option>
                <option value="3">Download</option>
                <option value="4">Compilance</option>
            </select>
        </div> 
        <div class="col-md-2 control-label" style="display: none" id="div_Dtype">
            Display Type 
        </div>
        <div class="col-md-3" id="div_ddlDType" style="display: none">
            <asp:DropDownList ID="ddl_DisplayType" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddl_DisplayType_SelectedIndexChanged">
                <asp:ListItem Value="">All</asp:ListItem>
                <asp:ListItem Value="HOME">Home</asp:ListItem>
                <asp:ListItem Value="USER">User</asp:ListItem>
                <%--<asp:ListItem Value="FRANCHISE">Franchise</asp:ListItem>--%>
            </asp:DropDownList>
        </div>
      
        <div class="clearfix">
        </div>
          <div class="col-md-2 control-label">
      Title 
  </div>
  <div class="col-md-3">
      <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rvfTitle" Display="Dynamic" runat="server" ErrorMessage="Please provide title."
          ValidationGroup="pp" ControlToValidate="txtTitle" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator ID="revTitle" runat="server" ControlToValidate="txtTitle"
          Display="Dynamic" ErrorMessage="Please enter only alphabets in title." ValidationExpression="^[a-zA-Z][a-zA-Z\s]*$"
          ValidationGroup="pp" SetFocusOnError="True" ForeColor="Red"></asp:RegularExpressionValidator>
  </div>


        <div class="col-md-2 control-label">
            Upload Document
        </div>
        <div class="col-md-3">

            <asp:FileUpload ID="FileUploadDoc" runat="server" CssClass="form-file-input form-control" onchange="revDocUp" />
            <br />
            <%--  <asp:RequiredFieldValidator ID="rfvUpDoc" runat="server" ControlToValidate="FileUploadDoc"
                Display="Dynamic" ErrorMessage="You haven't selected any file." ValidationGroup="pp"
                SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>--%>
            <asp:RegularExpressionValidator ID="revDocUp" runat="server" ControlToValidate="FileUploadDoc"
                Display="Dynamic" ValidationGroup="pp" ValidationExpression="^.*\.(doc|DOC|docx|DOCX|pdf|PDF|txt|TXT|ppt|PPT|pptx|PPTX|ppsx|PPSX|xls|XLS|xlsx|XLSX|rtf|RTF)$"
                ErrorMessage="Please select only <b>.txt/.pdf/.doc/.docx/.ppt/.pptx/.ppsx/.xlsx/.xls/.rtf</b> file."
                SetFocusOnError="True" ForeColor="Red"></asp:RegularExpressionValidator>
        </div>


        <div class="alert alert-primary alert-dismissible fade show mt-2">

            <strong>Note:</strong>  Only <b>.txt/.pdf/.doc/.docx/.ppt/.pptx/.ppsx/.xlsx/.xls/.rtf</b>
            files are allowed.
            <span style="color: Blue"><b>File size should not exceed than <b>30 MB</b>.</b></span>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
            </button>
        </div>


        <div class="clearfix">
        </div>

        <%--  <div class="col-md-2 control-label">
           Upload Image 
        </div>
        <div class="col-md-3">
            <asp:FileUpload ID="FileUploadImg" runat="server" CssClass="form-file-input form-control" onchange="revDocUp" />
            <br />
           <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FileUploadImg"
                Display="Dynamic" ErrorMessage="You haven't selected any file." ValidationGroup="pp"
                SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>--%>
        <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="FileUploadImg"
                Display="Dynamic" ValidationGroup="pp" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.gif)$"
                ErrorMessage="Please select only <b>.png/.jpg/.jpeg/.gif</b> file."
                SetFocusOnError="True" ForeColor="Red"></asp:RegularExpressionValidator>
        </div>--%>
        <div class="col-md-2">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                OnClientClick="" ValidationGroup="pp" CssClass="btn btn-primary" />
        </div>

        <%-- <div class="alert alert-primary alert-dismissible fade show mt-2">
								
									<strong>Note:</strong>  Image size must be width
        304 px and height 190 px and Image size should be less than 5 MB ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
								</div>--%>


        <div class="clearfix">
        </div>


        <div class="col-md-2 ">
            <asp:Label ID="lblMessage" runat="server" Text="File size exceeds maximum limit 20 MB."
                ForeColor="Red"></asp:Label>
        </div>

    </div>
    <div class="clearfix">
    </div>

    <br />

    <div class="table table-responsive">
        <asp:GridView ID="GridView1" CssClass="table table-striped table-hover mygrd" runat="server"
            AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand" DataKeyNames="id" EmptyDataText="No Data Found">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <ItemTemplate>
                        <asp:Label ID="lblserial" Text='<%# Container.DataItemIndex + 1%>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:BoundField DataField="DocType" HeaderText="Document Type" />
                <asp:BoundField DataField="DisplayType" HeaderText="Display Type" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="FileName" HeaderText="File Name" />
                <asp:TemplateField HeaderText="Download">
                    <ItemTemplate>
                        <a href="../images/downloads/<%# Eval("FileName")%>" target="_blank">Download</a>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:ButtonField ButtonType="Link" Text="Delete" CommandName="Dwn" HeaderText="Files" />
            </Columns>
        </asp:GridView>
    </div>


    <!-- middle content -->
    <div class="indexmiddle">
        <script language="JavaScript" type="text/javascript">
            //Begin CCS script
            //End CCS script
          //  ddl_doctype div_Dtype div_ddlDType
            function DisType() {
                //ddl_Ctype  div_UserId
                if ($('#ddl_doctype').val() == "3") {
                    // div_NoOfCoupon  div_Coupon
                    document.getElementById("div_Dtype").style.display = "block";
                    document.getElementById("div_ddlDType").style.display = "block";
                }
                else {
                    document.getElementById("div_Dtype").style.display = "none";
                    document.getElementById("div_ddlDType").style.display = "none";
                }
            }
        </script>
    </div>

    <div class="clearfix"></div>
    </div>
</asp:Content>
