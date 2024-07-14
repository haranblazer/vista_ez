<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="blog.aspx.cs" Inherits="blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="css/bootstrap.min.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1" />
     <link rel="stylesheet" href="css/pe-icon-7-stroke.min.css?v=0.1"/>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    
    <div class="row" style="padding: 25px 100px;">
       
        <div class="col-md-9">
            <div id="messagediv" runat="server">

            </div>
            <div id="singleBlog" runat="server">
            <asp:Image runat="server" width="800px" heigt="300px" id="imgBlog" Height="300px"  /> 
            <h1 id="h1" runat="server"></h1>
            <div class="post-meta">
                <span class="post-author"><i class="pe-7s-user"></i><a href="#"> Administrator</a></span>
                <span class="post-date"><i class="pe-7s-clock"></i>
                    <asp:Label runat="server" ID="lblCreated_DT" />
                </span>
            </div>
            <p><asp:Label runat="server" ID="lblDescription" /></p>
            <section><asp:Label runat="server" ID="lblContent" /></section>
            <div runat="server" id="divComments">
                <label>Comments:</label>
                <asp:TextBox ID="comments" runat="server" Width="100%" Rows="3" TextMode="MultiLine" />
                <asp:Button runat="server" ID="post" Text="Post" CssClass="btn btn-primary" onclick="post_click" />
                <asp:Repeater runat="server" ID="rptComments">
                    <itemtemplate>
                        <p>
                            <%#Eval("comments") %><br />
                            <%#Eval("comment_by") %> &nbsp; (<%#Eval("comment_dt") %>)
                        </p>
                    </itemtemplate>
                </asp:Repeater>
            </div>
            </div>
            
            <div id="multipleBlog" runat="server"> 
            <asp:UpdatePanel runat="server" ID="updPanel">
                <ContentTemplate>
                     <asp:Repeater runat="server" ID="rptBlogs">
                 <ItemTemplate>
            <asp:Image runat="server" width="800px" heigt="300px" id="Image1" Height="300px" ImageUrl=' <%#Eval("imageName") %>'/> 
            <h1><asp:Label runat="server" Text='<%#Eval("title") %>'/></h1>
            <div class="post-meta">
                <span class="post-author"><i class="pe-7s-user"></i><a href="#"> Administrator</a></span>
                <span class="post-date"><i class="pe-7s-clock"></i>
                    <asp:Label runat="server" Text='<%#Eval("created_dt") %>'/>
                </span>
            </div>
            <p><%#Eval("description") %></p>
            <section>
              <a href="/Blog/<%# Eval("title").ToString().Replace(" ", "-") %>">  <%# Eval("content") %>  </a>  </section>
            <hr />       
        <br />
        </ItemTemplate>
        </asp:Repeater>
                     <div style="margin-top: 20px;">
                        <table style="width: 600px;">
                        <tr>
                            <td>
                                <asp:LinkButton ID="lbFirst" runat="server" OnClick="lbFirst_Click">First</asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="lbPrevious" runat="server" OnClick="lbPrevious_Click">Previous</asp:LinkButton>
                            </td>
                            <td>
                                <asp:DataList ID="rptPaging" runat="server"
                                    OnItemCommand="rptPaging_ItemCommand"
                                    OnItemDataBound="rptPaging_ItemDataBound" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbPaging" runat="server"
                                            CommandArgument='<%# Eval("PageIndex") %>' CommandName="newPage"
                                            Text='<%# Eval("PageText") %> ' Width="20px"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                            <td>
                                <asp:LinkButton ID="lbNext" runat="server" OnClick="lbNext_Click">Next</asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="lbLast" runat="server" OnClick="lbLast_Click">Last</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label ID="lblpage" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        </table>
                     </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            </div>
            </div>
           
        <div class="col-md-3">
            <h4>Recent Blogs</h4>
            <ul class="dropdown" runat="server" id="tabs"></ul>
        </div>
    </div>
</asp:Content>
