<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{common/layout/base-login-layout}">

<th:block layout:fragment="css">
    <style type="text/css">
        .logo-deco {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 50%;
            top: -75%;
            border: none;
            outline: none;
            opacity: 0.1;
            transform: scaleX(2) scaleY(2);
            z-index: 1;
        }
        .login-container {
            width: 100%;
            height: 100%;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            position: absolute;
            z-index: 2;
            background : linear-gradient(45deg, #22367a 25%, #2659dd 75%);
        }

        .login-container::before,
        .login-container::after{
            content: "";
            display: block;
            position: fixed;
            bottom: -5vh;
            left: -5vw;
            width: 110vw;
            height: 110vh;
            pointer-events: none;
            transform: scale(1);
            z-index: -1;
        }

        .login-container::before{
            background-image: url("/assets/images/overlay.png"), linear-gradient(45deg, #22367a 25%, #2659dd 75%);
            background-size: 256px, cover;
            background-position: center center;
            background-repeat: repeat no-repeat;
        }

        .login-container::after{
            background-image: url("/assets/images/svgs/bg.svg");
            background-size: cover;
            background-position: top;
            background-repeat: no-repeat;
            transition: filter .5s ease,opacity 1s ease;
        }
        .login-container .login-box {
            /*width: calc(55%);*/
            /*height: 500px;*/
            display: flex;
            align-items: center;
            box-shadow: 0px 14px 16.83px 0.17px rgb(0 0 0 / 20%);
            border-radius: 0.75rem;
        }
        .login-container .login-box .login-form {
            display: flex;
            height: 580px;
            width: 100%;
            min-width: 450px;
            background-color: #ffffff;
            border-radius: 0.75rem;
            box-sizing: border-box;
            padding: 0px 40px;
            flex-direction: row;
            align-items: center;
        }
        .login-container .login-box .login-form .login-action {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }
        .login-container .login-box .login-form .login-action .find-pass {
            font-size: 0.8rem;
            font-weight: 400;
            color: #3a3a3a;
        }
        .btn-login{
            color: #fff !important;
            background-color: #0d6efd !important;
            border-color: #0d6efd !important;
            letter-spacing: 2.5px;
            font-size: 14px;
            padding: 8px 10px;
            border-radius: 5px;
            width: 100%;
        }
    </style>
</th:block>

<th:block layout:fragment="script">
    <script type="text/javascript" th:inline="javascript">
        function onFrontScriptReady() {
            console.log("front script ready...");
            $(".btn-login").click(function () {
                doLogin();
            });
            $('#password').keypress(function(event){
                if ( event.which == 13 ) {
                    $('.btn-default').click();
                    return false;
                }
            });
        }
        function doLogin() {
            var sendData = {};
            var username = $("#username").val();
            // var subStringPosition = username.indexOf("@")+1;

            sendData.username = username;
            sendData.password = $("#password").val();
            sendData.provider = "lululab";
            sendData.appVersion = "";
            sendData.providerPayload = "{}";
            console.log(sendData);

            NSCOMMON.apiPost(NSCONFIG.loginUrl, sendData, "json", true, function (loginResult) {
                NSCOMMON.createCookie(NSCONFIG.context + ".access-token",
                    loginResult.authentication.value, 12 * 60 * 60 * 1000);
                NSCOMMON.createCookie(NSCONFIG.context + ".refresh-token",
                    loginResult.authentication.refreshToken.value, 30 * 24 * 60 * 60 * 1000);
                NSCOMMON.createCookie(NSCONFIG.context + ".user-type",
                    loginResult.authentication.additionalInformation.userType, 12 * 60 * 60 * 1000);
                NSCOMMON.createCookie(NSCONFIG.context + ".user-info",
                    JSON.stringify(loginResult.userInfo), 12 * 60 * 60 * 1000);

                NSCOMMON.userInfo = loginResult.userInfo;
                NSCOMMON.userType = loginResult.authentication.additionalInformation.userType;

                console.log(loginResult);

                // keep login info
                NSCOMMON.createCookie(NSCONFIG.context + ".login-info",
                    NSCOMMON.B64.encode(JSON.stringify(sendData)), 30 * 24 * 60 * 60 * 1000);

                location.href = "/page/dashboard";
            });
        }

        // function doLogin() {
        //     var sendData = {};
        //     sendData.header = {};
        //     sendData.body = {};
        //     sendData.body.userId = $("#userId").val();
        //     sendData.body.userPw = $("#userPw").val();
        //
        //     console.log(sendData);
        //
        //     NSCOMMON.apiPost(NSCONFIG.loginUrl, sendData, "json", false, function(jsonResult) {
        //         console.log(jsonResult);
        //     });
        // }
    </script>
</th:block>

<div class="login-main" layout:fragment="content">
    <div class="login-container">
        <div class="login-box">
            <div class="login-form">
                <div style="display: flex; padding-right: 40px;">
                    <img src="/assets/images/logo/severance_logo_vertical.jpeg" alt="severance" style="width: 220px;">
                    <img src="/assets/images/logo/lululab_logo_vertical.jpeg" alt="lululab" style="width: 220px;">
                </div>
                <div style="width: 300px;height: 220px; display: flex;flex-direction: column;justify-content: space-between;margin-right: 40px;">
                    <span class="margin-double-top" style="font-size: 36px;font-weight: bold;color: #22367a;display: block; margin: 0 auto; letter-spacing: 4px;">Login</span>
                    <div class="input-box w100 margin-base-top" style="display: flex;align-items: center;">
<!--                        <span class="placeholder" style="margin: 0 80px 0 0;">ID</span>-->
                        <input type="text" id="username" placeholder="User ID" style="border: 1px solid #acacac; box-sizing: border-box; width: 100%; height: 38px; border-radius: 5px; padding: 0 10px; font-size: 14px;"/>
                    </div>
                    <div class="input-box w100 margin-base-top margin-double-bottom" style="display: flex;align-items: center;">
<!--                        <span class="placeholder" style="margin: 0 17px 0 0;">PASSWORD</span>-->
                        <input type="password" id="password" placeholder="Password" style="border: 1px solid #acacac; box-sizing: border-box; width: 100%; height: 38px; border-radius: 5px; padding: 0 10px; font-size: 14px;"/>
                    </div>
                    <!--                <div class="input-box w100 margin-base-top margin-double-bottom">-->
                    <!--                    <span class="placeholder">PROVIDER</span><input type="text" id="provider" />-->
                    <!--                </div>-->
                    <div class="login-action">
                        <button type="button" class="btn-login">Login</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!--    <section class="sign-in">-->
<!--        <div class="container">-->
<!--            <div class="signin-content">-->
<!--                <div class="signin-image">-->
<!--                    <figure>-->
<!--                        <img src="/assets/images/logo/severance_logo_vertical.jpeg" alt="severance" style="width: 220px;">-->
<!--                        <img src="/assets/images/logo/lululab_logo_vertical.jpeg" alt="lululab" style="width: 220px">-->
<!--                    </figure>-->
<!--                    <a href="" class="signup-image-link">계정 만들기</a>-->
<!--                </div>-->
<!--                <div class="signin-form">-->
<!--                    <h2 class="form-title">로그인</h2>-->
<!--                    <form class="register-form" id="login-form">-->
<!--                        <div class="form-group">-->
<!--                            <div class="">-->
<!--                                <input id="userId" type="text" placeholder="User Name" class="form-control"> </div>-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <input id="userPw" type="password" placeholder="Password" class="form-control">-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <input type="checkbox" name="remember-me" id="remember-me" class="agree-term">-->
<!--                            <label for="remember-me" class="label-agree-term"><span><span></span></span>자동 저장</label>-->
<!--                        </div>-->
<!--                        <div class="form-group form-button">-->
<!--                            <button class="btn-default" id="signin">로그인</button>-->
<!--                        </div>-->
<!--                    </form>-->
<!--                    <div class="social-login">-->
<!--                        <span class="social-label">Or login with</span>-->
<!--                        <ul class="socials">-->
<!--                            <li><a href="#"><i class="display-flex-center fa-brands fa-facebook-f"></i></a></li>-->
<!--                            <li><a href="#"><i class="display-flex-center fa-brands fa-twitter"></i></a></li>-->
<!--                            <li><a href="#"><i class="display-flex-center fa-brands fa-google"></i></a></li>-->
<!--                        </ul>-->
<!--                    </div>-->
<!--                </div>-->
<!--            </div>-->
<!--        </div>-->
<!--    </section>-->
</div>

</html>