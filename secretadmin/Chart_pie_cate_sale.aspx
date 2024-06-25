<%--<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>--%>

<%--<script src="../JsChart/highcharts.js"></script> 
<script src="../JsChart/exporting.js"></script>
<script src="../JsChart/export-data.js"></script> 
<script src="../JsChart/accessibility.js"></script>--%>


<div class="row">
    <div class="col-md-2">
        <select id="ddl_TopCate" class="form-control">
            <option value="5">Top 5</option>
            <option value="10">Top 10</option>
            <option value="20">Top 20</option>
            <option value="30">Top 30</option>
            <option value="50">Top 50</option>
            <option value="99999">All</option>
        </select>
    </div>
    <div class="col-md-2">
        <select id="ddl_CateType" class="form-control">
            <option value="QTY">Qty</option>
            <option value="AMT">Amount</option>
            <option value="RPV">RPV</option>
        </select>
    </div>
    <div class="col-md-2">
        <input type="text" id="txtFromDateCate" class="form-control" title="dd/mm/yyyy" placeholder="From Date" />
    </div>

    <div class="col-md-2">
        <input type="text" id="txtToDateCate" class="form-control" title="dd/mm/yyyy" placeholder="To Date" />
    </div>

    <div class="col-md-2">
        <button type="button" title="Search" class="btn btn-primary" onclick="Details_Pie_Chart_CateWise()">Search</button>
    </div>


</div>
<div class="clearfix"></div>

<div id="LoaderImgCate" class="loader-data" style="display: none;">
    <img src="../images/preloader.gif" alt="" style="height: 200px" />
</div>

<figure class="highcharts_figure_Pie_Chart_CateWise">
    <div id="container_Pie_Chart_CateWise"></div>
</figure>


<%--<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
<script src="datepick/jquery.datepick.js" type="text/javascript"></script>
<link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
<script> var $JD = $.noConflict(true); </script>
<script type="text/javascript">
    $JD(function () {
        $JD('#txtFromDateCate').datepick({ dateFormat: 'dd/mm/yyyy' });
        $JD('#txtToDateCate').datepick({ dateFormat: 'dd/mm/yyyy' });

        var d = new Date();

        $JD('#txtFromDateCate').val("01/" + (d.getMonth() + 1) + "/" + d.getFullYear());
        $JD('#txtToDateCate').val(d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear());
         
    });


    function Pie_Chart_CateWise() { 
        if ($('#txtFromDateCate').val() == "") {
            alert('Please Select From Date');
            return false;
        }
        if ($('#txtToDateCate').val() == "") {
            alert('Please Select To Date');
            return false;
        }
        let FromDate = dateFormate($('#txtFromDateCate').val());
        let ToDate = dateFormate($('#txtToDateCate').val());
        let Type = $('#ddl_CateType').val();
        $('#LoaderImgCate').show();
        let Top = $('#ddl_TopCate').val();
        $.ajax({
            type: "POST",
            url: 'Services.aspx/Get_Chart_Data_Report_Admin',
            data: '{mstkey: "CATEGORY_WISE", FromDate: "' + FromDate + '" , ToDate: "' + ToDate + '", Top: "' + Top + '", Type: "' + Type + '", CatId: "0"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnDetails_Pie_Chart_CateWise,
            failure: function (response) { $('#LoaderImgCate').hide(); alert(response.d); }
        });
    }


    function OnDetails_Pie_Chart_CateWise(data) {
      

        $('#LoaderImgCate').hide();
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
            GetSalesChart_Pie_Chart_CateWise(Total, MainData);
        }
    }


    function GetSalesChart_Pie_Chart_CateWise(Total, MainData) {
       
        Highcharts.chart('container_Pie_Chart_CateWise', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: ' Category Wise Total Sales: ' + Total.toFixed(2) + ' NOP', align: 'left'
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




    <%--
        Highcharts.chart('highcharts_figure_Pie_Chart_CateWise', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: { text: 'Category Wise Total Sales: ' + Total.toFixed(2) + ' INR', align: 'left' },
            tooltip: {
                headerFormat: '',
                pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b> <br> NOP : <b>{point.y}</b> Perc: <b>{point.z}%</b><br/>'
            },

            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b> <br> NOP : <b>{point.y}</b> Perc: <b>{point.z}%</b><br/>'
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

    } --%>


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

    .highcharts_figure_Pie_Chart_CateWise,
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

