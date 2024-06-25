<%@ Page Title="Add File" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddProductDocument.aspx.cs" Inherits="download" %>

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
    <h1 class="head">
        <i class="fa fa-reply" aria-hidden="true"></i>&nbsp; Upload File</h1>
    <div class="panel panel-default">
        <div class="col-md-12">
            <br />
           
            <div class="form-group" style="display:none">
                <div class="col-md-2 col-xs-4">
                    <strong>Title </strong>
                </div>
                <div class="col-md-3 col-xs-8">
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rvfTitle" Display="Dynamic" runat="server" ErrorMessage="Please provide title."
                        ValidationGroup="pp" ControlToValidate="txtTitle" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revTitle" runat="server" ControlToValidate="txtTitle"
                        Display="Dynamic" ErrorMessage="Please enter only alphabets in title." ValidationExpression="^[a-zA-Z][a-zA-Z\s]*$"
                        ValidationGroup="pp" SetFocusOnError="True" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group">
                <div class="col-md-2 col-xs-4">
                    <strong>Upload Document </strong>
                </div>
                <div class="col-xs-10">
                    <asp:FileUpload ID="FileUploadDoc" runat="server" Width="280px" onchange="revDocUp" />
                    <br />
                    <asp:RequiredFieldValidator ID="rfvUpDoc" runat="server" ControlToValidate="FileUploadDoc"
                        Display="Dynamic" ErrorMessage="You haven't selected any file." ValidationGroup="pp"
                        SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revDocUp" runat="server" ControlToValidate="FileUploadDoc"
                        Display="Dynamic" ValidationGroup="pp" ValidationExpression="^.*\.(doc|DOC|docx|DOCX|pdf|PDF|txt|TXT|ppt|PPT|pptx|PPTX|ppsx|PPSX|xls|XLS|xlsx|XLSX|rtf|RTF)$"
                        ErrorMessage="Please select only <b>.txt/.pdf/.doc/.docx/.ppt/.pptx/.ppsx/.xlsx/.xls/.rtf</b> file."
                        SetFocusOnError="True" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="form-group">
                <div class="col-md-2 col-xs-4">
                </div>
                <div class="col-xs-10">
                    <span id="Span1" style="color: Blue"><strong><i class="fa fa-clipboard"></i>&nbsp;Note:</strong>
                        Only <b>.txt/.pdf/.doc/.docx/.ppt/.pptx/.ppsx/.xlsx/.xls/.rtf</b> files are allowed.</span><br />
                    <span id="Span2" style="color: Blue"><b>File size should not exceed than <b>30 MB</b>.</b></span>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="form-group" style="display:none">
                <div class="col-md-2 col-xs-4">
                    <strong>Upload Image </strong>
                </div>
                <div class="col-xs-10">
                    <asp:FileUpload ID="FileUploadImg" runat="server" Width="280px" onchange="revDocUp" />
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FileUploadImg"
                        Display="Dynamic" ErrorMessage="You haven't selected any file." ValidationGroup="pp"
                        SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="FileUploadImg"
                        Display="Dynamic" ValidationGroup="pp" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.gif)$"
                        ErrorMessage="Please select only <b>.png/.jpg/.jpeg/.gif</b> file." SetFocusOnError="True"
                        ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="form-group">
                <div class="col-md-2 col-xs-4">
                </div>
                <div class="col-xs-10">
                    <span id="Span3" style="color: Blue"><strong><i class="fa fa-clipboard"></i>&nbsp;Note:</strong>
                        Image size must be width 304 px and height 190 px and Image size should be less
                        than 5 MB ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">
                            Tinypng.com</a>)</span>
                </div>
            </div>
           <%-- <div class="clearfix">
            </div>
            <br />--%>
            <div class="form-group">
                <div class="col-md-2 ">
                    <asp:Label ID="lblMessage" runat="server" Text="File size exceeds maximum limit 20 MB."
                        ForeColor="Red"></asp:Label>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                        OnClientClick="" CssClass="btn btn-success" />
                </div>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="col-md-12" runat="server" id="prodoc">
            </div>
            <div class="col-md-12" style="display:none">
                <div class="table table-responsive">
                    <asp:GridView ID="GridView1" CssClass="table table-striped table-hover mygrd" runat="server"
                        AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand" DataKeyNames="id"
                        EmptyDataText="No Data Found">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblserial" Text='<%# Container.DataItemIndex + 1%>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Title" HeaderText="Title" />
                            <asp:BoundField DataField="FileName" HeaderText="File Name" />
                            <asp:ButtonField ButtonType="Link" Text="Delete" CommandName="Dwn" HeaderText="Files" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <!-- middle content -->
            <div class="indexmiddle">
                <script language="JavaScript" type="text/javascript">
                    //Begin CCS script
                    //End CCS script
                </script>
            </div>
        </div>
        <div class="clearfix">
        </div>
    </div>
</asp:Content>
