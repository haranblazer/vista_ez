<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="branches-list.aspx.cs" Inherits="user_branches_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="accordion accordion-rounded-stylish accordion-bordered" id="accordion-eleven">
								  <div class="accordion-item mb-0 row">
                                      <div class="col-md-6">
									<div class="accordion-header rounded-lg collapsed" id="accord-11One" data-bs-toggle="collapse" data-bs-target="#collapse11One" aria-controls="collapse11One" aria-expanded="false" role="button">
										<span class="accordion-header-icon"></span>
								<h4 class="fs-20 font-w600  me-auto float-left mb-0"> Franchise List</h4>
									  <span class="fa fa-sort-desc plus float-left"></span>                                           
									</div>
                                          </div>
                                      <div class="col-md-6">
                                       <div class="pull-right ">					
					 <div>
					    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-word-o me-2"></i>Word</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-excel-o me-2"></i>Excel</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-pdf-o me-2"></i>PDF</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-print me-2"></i>Print</a>
					</div>
				</div>
                                          </div>
                          <div class="clearfix"></div>
									<div id="collapse11One" class="accordion__body collapse" aria-labelledby="accord-11One" data-bs-parent="#accordion-eleven" style="">
									  <div class="accordion-body-text">										
                                         <div class="form-group card-group-row row">
                  
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="Search By Franchise ID/Name"></asp:TextBox>
                        </div>

                        <div class="col-sm-2 ">
                            <asp:DropDownList ID="ddl_State" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>

                        <div class="col-sm-2 ">
                            <asp:DropDownList ID="ddl_Type" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <button id="btnSearch" runat="server" class="btn btn-primary" title="Search" onserverclick="btnSearch_Click">
                                <i class="fa fa-search"></i>&nbsp;Search
                            </button>

                        </div>

                        <div class="col-sm-2">
                            <asp:DropDownList ID="ddPageSize" runat="server" CssClass="form-control" AutoPostBack="true"
                                OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged">
                                <asp:ListItem>25</asp:ListItem>
                                <asp:ListItem>50</asp:ListItem>
                                <asp:ListItem>100</asp:ListItem>
                                <asp:ListItem>All</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2 text-right">
                            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"  Style="margin-left: 0px" Width="20px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-left: 0px" Width="23px" />
                            <%--<asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" 
                    onclick="imgbtnPdf_Click" />--%>
                        </div>
                  
                    </div>
									  </div>
									</div>
								  </div>
								</div>


  


                    <div class="col-sm-8" style="display: none">
                        <asp:Label ID="lblCount" runat="server" Font-Bold="true"></asp:Label>
                    </div>

                    <div class="table-responsive">
                     
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover" HeaderStyle-BackColor="#fe6a00" HeaderStyle-ForeColor="#ffffff"
                                EmptyDataText="record not found." AllowPaging="True" 
                                OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
                                <Columns>

                                    <%--<asp:TemplateField HeaderText="Franchise Id">
                                        <ItemTemplate>
                                            <%# Eval("FranchiseId")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Franchise Name">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbl_TI" runat="server" Text='<%# Eval("FranchiseName")%>' Style="color: blue;" CommandName="login" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    
                                     <asp:BoundField HeaderText="Franchise Id" DataField="FranchiseId"></asp:BoundField>
                                     <asp:BoundField HeaderText="Franchise Name" DataField="FranchiseName"></asp:BoundField>
                                     <asp:BoundField HeaderText="Type" DataField="Type"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# Eval("Status").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     
                                    <asp:BoundField HeaderText="State" DataField="State"></asp:BoundField>
                                    <asp:BoundField HeaderText="District" DataField="District"></asp:BoundField>
                                    <asp:BoundField HeaderText="City" DataField="City"></asp:BoundField>
                                    <asp:BoundField HeaderText="PIN" DataField="PIN"></asp:BoundField>
                                    <asp:BoundField HeaderText="Address" DataField="Address"></asp:BoundField>
                                  
                                </Columns>
                            </asp:GridView>
                        </div>
                    
  
    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>

       <script type = "text/javascript">
           var GridId = "<%=GridView1.ClientID %>";
           var ScrollHeight = 400;
           window.onload = function () {
               debugger;
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
</script>
<style>
.table {    
    margin-bottom: 0px;
}
th
{ border:none;
    }
</style>
</asp:Content>
