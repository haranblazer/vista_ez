<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="Events.aspx.cs" Inherits="secretadmin_Events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function HideLabel() {
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, 15 * 1000);
        };


        $(function () {
            $("[id*=fuUpload]").change(function () {
                if (typeof (FileReader) != "undefined") {
                    var dvPreview = $('#<%=dvPreview.ClientID%>');
                    dvPreview.html("");
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                    $($(this)[0].files).each(function () {
                        var file = $(this);
                        if (regex.test(file[0].name.toLowerCase())) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var img = $("<img />");
                                img.attr("style", "height:112px;width: 105px");
                                img.attr("src", e.target.result);
                                dvPreview.append(img);
                            }
                            reader.readAsDataURL(file[0]);
                        } else {
                            alert(file[0].name + " is not a valid image file.");
                            dvPreview.html("");
                            $('#<%=fuUpload.ClientID%>').val('');
                            return false;
                        }
                    });
                } else {
                    alert("This browser does not support HTML5 FileReader.");
                }
            });
         });

    </script>
   <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Upload Event Link</h4>					
				</div>
   
 <div class="alert alert-primary alert-dismissible fade show">
								
									<strong>Note:</strong> Video size should
            be in width=100% and height=220px.
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
								</div>
            

            <div class="form-group">
                <div class="col-md-4">
                    <asp:DropDownList ID="ddl_title" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <div class="col-md-7">
                </div>
                <div class="col-md-1 ">
                    <a href="AddTitle.aspx?T=Events" class="btn btn-info">Add Title</a>
                </div>
            </div>
            <div class="clearfix"></div>
            <br />
            <div class="form-group">
                <div class="col-md-2 ">
                    Video Link:<span style="color: Red">*</span>
                </div>
                <div class="col-md-4 ">
                    <asp:TextBox ID="txtVideoUpload" runat="server" required="required" CssClass="form-control"
                        placeholder="Please Enter Embed Video Link"></asp:TextBox>
                    <asp:Label ID="lblMsg" runat="server" Text="" Visible="false" ForeColor="Red" Font-Bold="true"></asp:Label>
                </div>
                <div class="col-md-4">
                    <asp:TextBox ID="txt_TitleHeader" runat="server" CssClass="form-control"
                        placeholder="Please Enter Title Header" style="display:none;"></asp:TextBox>
                </div>
                

            </div>
       
            <div class="form-group">
                <div class="col-md-2 ">
                    Upload Image
                </div>
                <div class="col-md-4 ">
                     <div class="input-group">
                                            <div class="form-file">
                    <asp:FileUpload ID="fuUpload" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
                    </div>
                         </div>
                </div>
                 <div class="alert alert-primary alert-dismissible fade show mt-2">
								
									<strong>Note:</strong> Image size must be width 700px and height 500px
                     
                        and Image size should be less than 500 KB.
                        (Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
								</div>
                <div class="col-md-4 ">
                    <div id="dvPreview" runat="server"></div>
                </div>
                <div class="col-md-2 ">
                    <asp:Button ID="btnSubmit" runat="server" Text="Add" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
                </div>
            </div>
            <div class="clearfix"></div>
            <hr />


            <asp:ListView ID="DataVideo" runat="server" RepeatColumns="3" RepeatDirection="Horizontal">
                <ItemTemplate>
                    <div style="padding: 10px 10px 10px 10px;" class="floating" style="clear: both;">
                        <asp:HiddenField ID="hnd_id" runat="server" Value='<%# Eval("id") %>' />
                        <asp:HiddenField ID="hnd_Img" runat="server" Value='<%# Eval("Img") %>' />
                          <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Title:   <%# Eval("Title") %></h4>					
				</div>
                        
                      
                       <%-- Heading:   <%# Eval("TitleHeader") %>
                        <br />--%>
                        <asp:LinkButton ID="lnkVideo" runat="server" Text='<%# Eval("VName") %>'></asp:LinkButton>
                        <div class="clearfix"></div>
                        <img src="<%# Eval("Img","../images/Slip/{0}")%>" width="70px;" height="80px;" />
                         <div class="col-md-4">
                                         
                         <asp:FileUpload ID="imgdlUpload" runat="server" CssClass="form-file-input form-control" accept=".png,.jpg,.jpeg,.gif" />
                                             
                             </div>
                        <asp:LinkButton ID="lnkupdate" runat="server" Text="Update Image" CssClass="btn btn-primary"
                            OnClick="lnkupdate_Click"></asp:LinkButton>
                    
                        <asp:LinkButton ID="lnkDel" runat="server" CssClass="btn btn-danger" Text="Delete" OnClick="lnkDel_Click" OnClientClick="return confirm('Are you sure want to delete this record?');"></asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:ListView>

        </div>
        <div class="clearfix"></div>
    </div>




    <%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="css/PagingGridView.css" rel="stylesheet" type="text/css" />
   
    
    <h2 class="head">
        <i class="fa fa-calendar" aria-hidden="true"></i>&nbsp;Events
    </h2>
    <div class="panel panel-default">
        <br />
        <asp:Panel ID="Panel1" runat="server">
            <div class="form-group">
                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        State:<span style="color: Red">*</span></label>
                    <asp:Label ID="lblsrno" runat="server" class="txt control-label" Style="text-align: left" Visible="false" />

                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="ContryExp" runat="server" ControlToValidate="DdlState"
                        SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                        InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        City:<span style="color: Red">*</span></label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter your City"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                        Display="None" ErrorMessage="Please Enter City!" ForeColor="#C00000" ValidationGroup="NJ"
                        SetFocusOnError="true"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        Location:<span style="color: Red">*</span></label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Enter your City"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCity"
                        Display="None" ErrorMessage="Please Enter City!" ForeColor="#C00000" ValidationGroup="NJ"
                        SetFocusOnError="true"></asp:RequiredFieldValidator>
                </div>

                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        Contact:<span style="color: Red">*</span></label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="txtcontact" runat="server" CssClass="form-control" placeholder="Enter your Contact"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtcontact"
                        Display="None" ErrorMessage="Please Enter Contact!" ForeColor="#C00000" ValidationGroup="NJ"
                        SetFocusOnError="true"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        Type:<span style="color: Red">*</span></label>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">Select</asp:ListItem>  
                        <asp:ListItem Value="1">Meeting</asp:ListItem>
                        <asp:ListItem Value="2">Seminar</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DdlState"
                        SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                        InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        Event Date:<span style="color: Red">*</span></label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="clearfix"></div>

                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        Leader:<span style="color: Red">*</span></label>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlLeader" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlLeader_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div class="col-md-1">
                    <label for="MainContent_myForm_txtPname" class="txt control-label" style="text-align: left">
                        Time:<span style="color: Red">*</span></label>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="DdlHR" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">Select</asp:ListItem>
                        <asp:ListItem Value="1">01</asp:ListItem>
                        <asp:ListItem Value="2">02</asp:ListItem>
                        <asp:ListItem Value="3">03</asp:ListItem>
                        <asp:ListItem Value="4">04</asp:ListItem>
                        <asp:ListItem Value="5">05</asp:ListItem>
                        <asp:ListItem Value="6">06</asp:ListItem>
                        <asp:ListItem Value="7">07</asp:ListItem>
                        <asp:ListItem Value="8">08</asp:ListItem>
                        <asp:ListItem Value="9">09</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="11">11</asp:ListItem>
                        <asp:ListItem Value="12">12</asp:ListItem>
                        <asp:ListItem Value="13">13</asp:ListItem>
                        <asp:ListItem Value="14">14</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="16">16</asp:ListItem>
                        <asp:ListItem Value="17">17</asp:ListItem>
                        <asp:ListItem Value="18">18</asp:ListItem>
                        <asp:ListItem Value="19">19</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="21">21</asp:ListItem>
                        <asp:ListItem Value="22">22</asp:ListItem>
                        <asp:ListItem Value="23">23</asp:ListItem>
                        <asp:ListItem Value="24">24</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="DdlMin" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">Select</asp:ListItem>
                        <asp:ListItem Value="1">00</asp:ListItem>
                        <asp:ListItem Value="2">01</asp:ListItem>
                        <asp:ListItem Value="3">02</asp:ListItem>
                        <asp:ListItem Value="4">03</asp:ListItem>
                        <asp:ListItem Value="5">04</asp:ListItem>
                        <asp:ListItem Value="6">05</asp:ListItem>
                        <asp:ListItem Value="7">06</asp:ListItem>
                        <asp:ListItem Value="8">07</asp:ListItem>
                        <asp:ListItem Value="9">08</asp:ListItem>
                        <asp:ListItem Value="10">09</asp:ListItem>
                        <asp:ListItem Value="11">10</asp:ListItem>
                        <asp:ListItem Value="12">11</asp:ListItem>
                        <asp:ListItem Value="13">12</asp:ListItem>
                        <asp:ListItem Value="14">13</asp:ListItem>
                        <asp:ListItem Value="15">14</asp:ListItem>
                        <asp:ListItem Value="16">15</asp:ListItem>
                        <asp:ListItem Value="17">16</asp:ListItem>
                        <asp:ListItem Value="18">17</asp:ListItem>
                        <asp:ListItem Value="19">18</asp:ListItem>
                        <asp:ListItem Value="20">19</asp:ListItem>
                        <asp:ListItem Value="21">20</asp:ListItem>
                        <asp:ListItem Value="22">21</asp:ListItem>
                        <asp:ListItem Value="23">22</asp:ListItem>
                        <asp:ListItem Value="24">23</asp:ListItem>
                        <asp:ListItem Value="25">24</asp:ListItem>
                        <asp:ListItem Value="26">25</asp:ListItem>
                        <asp:ListItem Value="27">26</asp:ListItem>
                        <asp:ListItem Value="28">27</asp:ListItem>
                        <asp:ListItem Value="29">28</asp:ListItem>
                        <asp:ListItem Value="30">29</asp:ListItem>
                        <asp:ListItem Value="31">30</asp:ListItem>
                        <asp:ListItem Value="32">31</asp:ListItem>
                        <asp:ListItem Value="33">32</asp:ListItem>
                        <asp:ListItem Value="34">33</asp:ListItem>
                        <asp:ListItem Value="35">34</asp:ListItem>
                        <asp:ListItem Value="36">35</asp:ListItem>
                        <asp:ListItem Value="37">36</asp:ListItem>
                        <asp:ListItem Value="38">37</asp:ListItem>
                        <asp:ListItem Value="39">38</asp:ListItem>
                        <asp:ListItem Value="40">39</asp:ListItem>
                        <asp:ListItem Value="41">40</asp:ListItem>
                        <asp:ListItem Value="42">41</asp:ListItem>
                        <asp:ListItem Value="43">42</asp:ListItem>
                        <asp:ListItem Value="44">43</asp:ListItem>
                        <asp:ListItem Value="45">44</asp:ListItem>
                        <asp:ListItem Value="46">45</asp:ListItem>
                        <asp:ListItem Value="47">46</asp:ListItem>
                        <asp:ListItem Value="48">47</asp:ListItem>
                        <asp:ListItem Value="49">48</asp:ListItem>
                        <asp:ListItem Value="50">49</asp:ListItem>
                        <asp:ListItem Value="51">50</asp:ListItem>
                        <asp:ListItem Value="52">51</asp:ListItem>
                        <asp:ListItem Value="53">52</asp:ListItem>
                        <asp:ListItem Value="54">53</asp:ListItem>
                        <asp:ListItem Value="55">54</asp:ListItem>
                        <asp:ListItem Value="56">55</asp:ListItem>
                        <asp:ListItem Value="57">56</asp:ListItem>
                        <asp:ListItem Value="58">57</asp:ListItem>
                        <asp:ListItem Value="59">58</asp:ListItem>
                        <asp:ListItem Value="60">59</asp:ListItem>
                        <asp:ListItem Value="61">60</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-1">
                    <b>Hours</b>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success" Text="Save"
                        OnClick="btnSubmit_Click" />
                </div>
            </div>
            <div class="clearfix"></div>
            <br />
            <div class="form-group">
                <div class="table-responsive">
                    <asp:GridView ID="gridTrnReq" EmptyDataText="No Record Found." CssClass="table table-striped table-hover mygrd"
                        runat="server" AllowPaging="true" AutoGenerateColumns="false"
                        PageSize="25" OnPageIndexChanging="gridTrnReq_PageIndexChanging"
                        OnRowDataBound="gridTrnReq_RowDataBound" DataKeyNames="srno" Rowcomm
                        OnRowCommand="gridTrnReq_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="srno" HeaderText="srno" Visible="false" />
                            <asp:BoundField DataField="appmstregno" HeaderText="UserId" Visible="false" />
                            <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                            <asp:BoundField DataField="State" HeaderText="State" />
                            <asp:BoundField DataField="City" HeaderText="City" />
                            <asp:BoundField DataField="Location" HeaderText="Location" />
                            <asp:BoundField DataField="Contact" HeaderText="Contact" />
                            <asp:BoundField DataField="typeofevent" HeaderText="Type Of Event" />
                            <asp:BoundField DataField="eventdate" HeaderText="Event Date" />
                            <asp:BoundField DataField="eventtime" HeaderText="Event Time" />
                            <asp:BoundField DataField="entrydate" HeaderText="Entry Date" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="appmstid" HeaderText="UId" Visible="false" />
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:Button ID="btedit" runat="server" CssClass="btn btn-success" Text="Edit" OnClick="btedit_Click"
                                        CommandName="e" CommandArgument="<%#((GridViewRow) Container).RowIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Del">
                                <ItemTemplate>
                                    <asp:Button ID="btdel" runat="server" CssClass="btn btn-success" Text="Delete" OnClick="btdel_Click"
                                        CommandName="d" CommandArgument="<%#((GridViewRow) Container).RowIndex %>" OnClientClick="return confirm('Are you sure you want to delete this bill?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </asp:Panel>

        <div class="clearfix">
        </div>
    </div>--%>
</asp:Content>
