<%--<script src="../JsChart/highcharts.js"></script> 
<script src="../JsChart/exporting.js"></script>
<script src="../JsChart/export-data.js"></script> 
<script src="../JsChart/accessibility.js"></script>--%>

<div class="row">
    <div class="col-md-2">
        <select id="ddl_TopProd" class="form-control">
            <option value="5">Top 5</option>
            <option value="10">Top 10</option>
            <option value="20">Top 20</option>
            <option value="30">Top 30</option>
            <option value="50">Top 50</option>
            <option value="99999">All</option>
        </select>
    </div>
    <div class="col-md-2">
        <select id="ddl_Categoty" class="form-control">
        </select>
    </div>

    <div class="col-md-2">
        <select id="ddl_ProdType" class="form-control">
            <option value="QTY">Qty</option>
            <option value="AMT">Amount</option>
            <option value="RPV">RPV</option>
        </select>
    </div>

    <div class="col-md-2">
        <input type="text" id="txtFromDateProd" class="form-control" title="dd/mm/yyyy" placeholder="From Date" />
    </div>

    <div class="col-md-2">
        <input type="text" id="txtToDateProd" class="form-control" title="dd/mm/yyyy" placeholder="To Date" />
    </div>

    <div class="col-md-2">
        <button type="button" title="Search" class="btn btn-primary" onclick="Details_Pie_Chart_ProductWise()">Search</button>
    </div>
</div>
<div class="clearfix"></div>

<div id="LoaderImgProd" class="loader-data" style="display: none;">
    <img src="../images/preloader.gif" alt="" style="height: 200px" />
</div>
<figure class="highcharts_figure_Pie_Chart_ProductWise">
    <div id="container_Pie_Chart_ProductWise"></div>
</figure>



<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="datepick/jquery.datepick.js" type="text/javascript"></script>
<link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
<script> var $JD = $.noConflict(true); </script>
<script type="text/javascript">
    $JD(function () {
        $JD('#txtFromDateProd').datepick({ dateFormat: 'dd/mm/yyyy' });
        $JD('#txtToDateProd').datepick({ dateFormat: 'dd/mm/yyyy' });

        var d = new Date();

        $JD('#txtFromDateProd').val("01/" + (d.getMonth() + 1) + "/" + d.getFullYear());
        $JD('#txtToDateProd').val(d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear());

        BindCategory();
    });


    function BindCategory() {

        $('#ddl_Categoty').empty().append('<option selected="selected" value="0">Loading...</option>');
        $.ajax({
            type: "POST",
            url: 'Services.aspx/GetCategory',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $("#ddl_Categoty").empty().append($("<option></option>").val(0).html('All Category'));
                PopulateControl(response.d, $("#ddl_Categoty"));
            },
            failure: function (response) { alert(response.d); }
        });
    }


    function PopulateControl(list, control) {
        if (list.length > 0) {
            control.removeAttr("disabled");
            $.each(list, function () {
                control.append($("<option></option>").val(this['Value']).html(this['Text']));
            });
        }
        else {  control.empty().append('<option selected="selected" value="0">Not available<option>');  }
    }



    function Details_Pie_Chart_ProductWise() {
      
        if ($('#txtFromDateProd').val() == "") {
            alert('Please Select From Date');
            return false;
        }
        if ($('#txtToDateProd').val() == "") {
            alert('Please Select To Date');
            return false;
        }
        let FromDate = dateFormate($('#txtFromDateProd').val());
        let ToDate = dateFormate($('#txtToDateProd').val());
        let Type = $('#ddl_ProdType').val();
        let Top = $('#ddl_TopProd').val();
        let CatId = $('#ddl_Categoty').val();
      
        $('#LoaderImgProd').show();
        $.ajax({
            type: "POST",
            url: 'Services.aspx/Get_Chart_Data_Report_Admin',
            data: '{mstkey: "PRODUCT_WISE", FromDate: "' + FromDate + '" , ToDate: "' + ToDate + '", Top: "' + Top + '", Type: "' + Type + '", CatId: "' + CatId + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnDetails_Pie_Chart_ProductWise,
            failure: function (response) { $('#LoaderImgProd').hide(); alert(response.d); }
        });
    }


    function OnDetails_Pie_Chart_ProductWise(data) {
        $('#LoaderImgProd').hide();
        if (data.d.length > 0) {
            var MainData = [];
            MainData.length = 0;
            let Total = 0;
            for (var j = 0; j < data.d.length; j++) {
                MainData.push({
                    name: data.d[j].ProductName, y: data.d[j].Val, z: data.d[j].Perc
                });
                Total += parseFloat(data.d[j].Val);
            }
            GetSalesChart_Pie_Chart_ProductWise(Total, MainData);
        }
    }


    function GetSalesChart_Pie_Chart_ProductWise(Total, MainData) {

        Highcharts.chart('container_Pie_Chart_ProductWise', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: ' Product Wise Total Sales: ' + Total.toFixed(2) + ' NOP', align: 'left'
            },
            tooltip: {
                headerFormat: '',
                pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b> <br> Value : <b>{point.y}</b> Perc: <b>{point.z}%</b><br/>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b> <br> Value : <b>{point.y}</b> Perc: <b>{point.z}%</b><br/>'
                    }
                }
            },
            series: [{
                name: 'Value',
                minPointSize: 10,
                innerSize: '20%',
                zMin: 0,
                colorByPoint: true,
                data: MainData
            }]
        });
    }

</script>

<style>
    .loader-data {
        width: 100%;
        text-align: center;
        position: fixed;
        z-index: 99999;
        right: -66px;
        top: 300px;
    }

    #container {
        height: 500px;
    }

    .highcharts_figure_Pie_Chart_ProductWise,
    .highcharts-data-table table {
        min-width: 320px;
        max-width: 700px;
        margin: 1em auto;
    }

    .highcharts-data-table table {
        font-family: Verdana, sans-serif;
        border-collapse: collapse;
        border: 1px solid #ebebeb;
        margin: 10px auto;
        text-align: center;
        width: 100%;
        max-width: 500px;
    }

    .highcharts-data-table caption {
        padding: 1em 0;
        font-size: 1.2em;
        color: #555;
    }

    .highcharts-data-table th {
        font-weight: 600;
        padding: 0.5em;
    }

    .highcharts-data-table td,
    .highcharts-data-table th,
    .highcharts-data-table caption {
        padding: 0.5em;
    }

    .highcharts-data-table thead tr,
    .highcharts-data-table tr:nth-child(even) {
        background: #f8f8f8;
    }

    .highcharts-data-table tr:hover {
        background: #f1f7ff;
    }
</style>
