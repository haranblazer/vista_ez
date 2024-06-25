<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AddTemplateImg.aspx.cs" Inherits="AddTemplateImg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
        <h4 class="fs-20 font-w600  me-auto">Upload Template</h4>
    </div>
    <div class="col-md-12">

        <div class="alert alert-primary alert-dismissible fade show">

            <strong>Note!</strong> Image size must be width 720px and height 1280px
                                <br />
            and Image size should be less than 500 KB. 
                                ( Use this link to reduce sizes <a href="https://tinypng.com/" target="_blank">Tinypng.com</a>)
									<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="btn-close">
                                    </button>
        </div>


        <div class="row">

            <div class="col-md-12">
                <div id="div_msg" runat="server"></div>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-2 control-label">
                Generation Rank 
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_GenerationRank" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_GenerationRank" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_GenerationRank_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_GenerationRankImg" runat="server"></div>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-2 control-label">
                Topper Rank 
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_TopperRank" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_TopperRank" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_TopperRank_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_TopperImg" runat="server"></div>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-2 control-label">
                Domestic Tour
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_DomesticTour" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_DomesticTour" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_DomesticTour_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_DomesticTour" runat="server"></div>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-2 control-label">
                International Tour
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_InternationalTour" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_InternationalTour" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_InternationalTour_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_InternationalTour" runat="server"></div>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-2 control-label">
                Loyalty 
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_Loyalty" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_Loyalty" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_Loyalty_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_Loyalty" runat="server"></div>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-2 control-label">
                Retail Booster Loyalty
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_RetailBooster" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_RetailBooster" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_RetailBooster_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_RetailBooster" runat="server"></div>
            </div>
        </div>


        <div class="row">
            <label class="col-sm-2 control-label">
                Stater Fund
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_Staterfund" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_Staterfund" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_Staterfund_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_Staterfund" runat="server"></div>
            </div>
        </div>


        <div class="row">
            <label class="col-sm-2 control-label">
                Top Earners Club 
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="fu_TopEarnersclub" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_TopEarnersclub" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_TopEarnersclub_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_TopEarnersclub" runat="server"></div>
            </div>
        </div>


        <div class="row">
            <label class="col-sm-2 control-label">
                Qualified Star
            </label>
            <div class="col-md-4">
                <asp:FileUpload ID="Fu_QualifiedStar" runat="server" CssClass="btn btn-default" accept=".png,.jpg,.jpeg" />
            </div>

            <div class="col-md-2">
                <asp:Button ID="Btn_QualifiedStar" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="Btn_QualifiedStar_Click" />
            </div>
            <div class="col-md-4">
                <div id="div_QualifiedStar" runat="server"></div>
            </div>
        </div>



    </div>
    <div class="clearfix"></div>
    <script src="../FancyBox/jquery-3.3.1.min.js" type="text/javascript"></script>
    <link href="../FancyBox/jquery.fancybox.min.css" rel="stylesheet" type="text/css" />
    <script src="../FancyBox/jquery.fancybox.min.js" type="text/javascript"></script>

</asp:Content>

