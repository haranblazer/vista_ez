<link href="css/leaderboard1.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" rel="stylesheet" />
<div id="LoaderImg" class="loader-data" style="display: none;">
    <img src="../images/preloader.gif" alt="" style="height: 200px" />
</div>


<link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
<script> var $J = $.noConflict(true); </script>
<script type="text/javascript">

    $J(function () {
        BindLeaderBoard('ELITE_BUYER_CLUB');
    });


    function BindLeaderBoard(mstkey) {
        $.ajax({
            type: "POST",
            url: 'UserServices.aspx/GetLeaderBoard',
            data: '{mstkey: "' + mstkey + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                var Contents = '';
                for (var i = 0; i < data.d.length; i++) {
                    if (data.d[i].RNO == "2") {
                        $("#lbl_2_UserName").html( data.d[i].Appmstfname);
                        $("#lbl_2_Point").html(data.d[i].TotalBV);
                        if (data.d[i].imagename == "noimage.png") {
                            if (data.d[i].Gender == "0")
                                $("#div_img2").html("<img src='../images/leaderboard_gents.png' alt='' width='65px' height='65px' class='photo'>");
                            else
                                $("#div_img2").html("<img src='../images/leaderboard_girl.png' alt='' width='65px' height='65px' class='photo'>");
                        } else {
                            $("#div_img2").html("<img src='../images/KYC/ProfileImage/" + data.d[i].imagename + "' width='65px' height='65px' alt='' class='photo'>");
                        }

                    }
                    else if (data.d[i].RNO == "1") {
                        $("#lbl_1_UserName").html( data.d[i].Appmstfname);
                        $("#lbl_1_Point").html(data.d[i].TotalBV);

                        if (data.d[i].imagename == "noimage.png") {
                            if (data.d[i].Gender == "0")
                                $("#div_img1").html("<img src='../images/leaderboard_one_gents.png' width='75px' height='75px' alt='' class='photo'>");
                            else
                                $("#div_img1").html("<img src='../images/leaderboard_one_girl.png'  width='75px' height='75px' alt='' class='photo'>");
                        } else {
                            $("#div_img1").html("<img src='../images/KYC/ProfileImage/" + data.d[i].imagename + "'  width='75px' height='75px' alt='' class='photo'>");
                        }
                    }
                    else if (data.d[i].RNO == "3") {
                        $("#lbl_3_UserName").html(  data.d[i].Appmstfname);
                        $("#lbl_3_Point").html(data.d[i].TotalBV);
                        if (data.d[i].imagename == "noimage.png") {
                            if (data.d[i].Gender == "0")
                                $("#div_img3").html("<img src='../images/leaderboard_gents.png' width='65px' height='65px' alt='' class='photo'>");
                            else
                                $("#div_img3").html("<img src='../images/leaderboard_girl.png' width='65px' height='65px' alt='' class='photo'>");
                        } else {
                            $("#div_img3").html("<img src='../images/KYC/ProfileImage/" + data.d[i].imagename + "' width='65px' height='65px' alt='' class='photo'>");
                        }
                    }
                    else {
                        Contents += '<div class="others flex">';
                        Contents += '<div class="rank"> <i class="fas fa-caret-up"></i> <p class="num">' + data.d[i].RNO + '</p> </div>';
                        Contents += '<div class="info flex">';


                        if (data.d[i].imagename == "noimage.png") {
                            if (data.d[i].Gender == "0")
                                Contents += '<img src="../images/leaderboard_gents.png" width="50px" height="50px" alt="" class="p_img">';
                            else
                                Contents += '<img src="../images/leaderboard_girl.png" width="50px" height="50px" alt="" class="p_img">';
                        } else {
                            Contents += '<img src="../images/KYC/ProfileImage/' + data.d[i].imagename + '" width="50px" height="50px" alt="" class="p_img">';
                        }

                        Contents += '<p class="link">' + data.d[i].Appmstfname  + '</p>';
                        Contents += '<p class="points">' + data.d[i].TotalBV + '</p>';
                        Contents += '</div>';
                        Contents += '</div>';
                    }
                }

                $("#div_LeaderBoard").empty().append(Contents);
            },
            error: function (result) {
                $('#LoaderImg').hide();
                alert(result);
            }
        });

    }
</script>

<div class="card-header-large">
    <h3>Leaderboard </h3>
</div>

<div class="" id="user-activity1">
    <div class="card-header border-0 p-0 pb-4">
        <div class="card-action coin-tabs">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" onclick="BindLeaderBoard('ELITE_BUYER_CLUB')" data-bs-toggle="tab" href="#leaderboard1" role="tab" aria-selected="false">Elite Buyer's Club</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" onclick="BindLeaderBoard('ELITE_SPONSOR_CLUB')" data-bs-toggle="tab" href="#leaderboard1" role="tab" aria-selected="true">Elite Sponsor's Club</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" onclick="BindLeaderBoard('ELITE_BUYER_LADIES_CLUB')" data-bs-toggle="tab" href="#leaderboard1" role="tab" aria-selected="false">Elite Leading Ladies Club</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" onclick="BindLeaderBoard('ELITE_AROGYAM_SPONSOR_CLUB')" data-bs-toggle="tab" href="#leaderboard1" role="tab" aria-selected="false">Elite Arogyam Sponsor's Club</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="card-body p-0">
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade active show" id="leaderboard1">
                <div class="leader-card one row">


                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            2
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">
                                <div class="person second">
                                    <i class="fa fa-caret-up"></i>
                                    <div id="div_img2"></div>
                                    <p class="link text-white text-center"><span id="lbl_2_UserName"></span></p>
                                    <p class="points text-white text-center"><span id="lbl_2_Point"></span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num first2">
                            1
                        </div>
                        <div class="leaderboard-color">
                            <div class="profile">
                                <div class="person first">
                                    <i class="fa fa-crown"></i>
                                    <div id="div_img1"></div>
                                    <p class="link text-white text-center"><span id="lbl_1_UserName"></span></p>
                                    <p class="points text-white text-center"><span id="lbl_1_Point"></span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            3
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">
                                <div class="person third">
                                    <i class="fas fa-caret-up"></i>
                                    <div id="div_img3"></div>
                                    <p class="link text-white text-center"><span id="lbl_3_UserName"></span></p>
                                    <p class="points text-white text-center"><span id="lbl_3_Point"></span></p>
                                </div>
                            </div>
                        </div>
                    </div>




                    <div class="rest" id="div_LeaderBoard"></div>

                </div>
            </div>


            <%--  <div class="tab-pane fade " id="leaderboard2">
                <div class="leader-card one row">
                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            2
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">
                                <div class="person second">

                                    <i class="fa fa-caret-up"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="" class="photo">
                                    <p class="link text-white">@dorisklien</p>
                                    <p class="points text-white">8023</p>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num first2">
                            1
                        </div>
                        <div class="leaderboard-color">
                            <div class="profile">

                                <div class="person first">

                                    <i class="fa fa-crown"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/4140/4140048.png" alt="" class="photo main">
                                    <p class="link text-white">@sher234</p>
                                    <p class="points text-white">8122</p>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            3
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">

                                <div class="person third">

                                    <i class="fas fa-caret-up"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/2922/2922561.png" alt="" class="photo">
                                    <p class="link text-white">@lord_0980</p>
                                    <p class="points text-white">7884</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="rest">
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">4</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">5</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">6</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">7</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">8</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">9</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">10</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="leaderboard3">
                <div class="leader-card one row">
                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            2
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">
                                <div class="person second">
                                    <i class="fa fa-caret-up"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="" class="photo">
                                    <p class="link text-white">@dorisklien</p>
                                    <p class="points text-white">8023</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num first2">
                            1
                        </div>
                        <div class="leaderboard-color">
                            <div class="profile">
                                <div class="person first">
                                    <i class="fa fa-crown"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/4140/4140048.png" alt="" class="photo main">
                                    <p class="link text-white">@sher234</p>
                                    <p class="points text-white">8122</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            3
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">

                                <div class="person third">

                                    <i class="fas fa-caret-up"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/2922/2922561.png" alt="" class="photo">
                                    <p class="link text-white">@lord_0980</p>
                                    <p class="points text-white">7884</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="rest">
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">4</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">5</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">6</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">7</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">8</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">9</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">10</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="leaderboard4">
                <div class="leader-card one row">
                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            2
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">
                                <div class="person second">

                                    <i class="fa fa-caret-up"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="" class="photo">
                                    <p class="link text-white">@dorisklien</p>
                                    <p class="points text-white">8023</p>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num first2">
                            1
                        </div>
                        <div class="leaderboard-color">
                            <div class="profile">

                                <div class="person first">

                                    <i class="fa fa-crown"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/4140/4140048.png" alt="" class="photo main">
                                    <p class="link text-white">@sher234</p>
                                    <p class="points text-white">8122</p>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-4 p-1">
                        <div class="num second2">
                            3
                        </div>
                        <div class="leaderboard-color mt-5">
                            <div class="profile">

                                <div class="person third">

                                    <i class="fas fa-caret-up"></i>
                                    <img src="https://cdn-icons-png.flaticon.com/512/2922/2922561.png" alt="" class="photo">
                                    <p class="link text-white">@lord_0980</p>
                                    <p class="points text-white">7884</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="rest">
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">4</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">5</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">6</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">7</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">8</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">9</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>

                        <div class="others flex">
                            <div class="rank">
                                <i class="fas fa-caret-up"></i>
                                <p class="num">10</p>
                            </div>
                            <div class="info flex">
                                <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" alt="" class="p_img">
                                <p class="link">@adam56</p>
                                <p class="points">7861</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
    </div>
</div>

