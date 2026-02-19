var CommonScript = function() {
    var __this = this;
    __this.userInfo = null;
    __this.userType = "guest";

    var __cfunc = {};

    var __cparam = {};
    __cparam.loadScriptStatus = {};
    __cparam.requestMap = {};
    __cparam.lastRequestSeq = -1;

    __this.createCookie = function (name, value, expiresAt) {
        var expires = "";
        var date = new Date();
        date.setTime(date.getTime() + expiresAt);
        expires = "; expires=" + date.toUTCString();
        document.cookie = name + "=" + value + expires + "; path=/";
    };

    __this.readCookie = function (name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0)
                return c.substring(nameEQ.length, c.length);
        }
        return null;
    };

    __this.eraseCookie = function (name) {
        __this.createCookie(name, "", -999999999999);
    };

    __this.apiGet = function (url, params, sendType, useAuth, callback) {
        if (__cparam.lastRequestSeq == -1) __cparam.lastRequestSeq = new Date().getTime();
        var executionId = __cparam.lastRequestSeq++;
        __cparam.requestMap["req-" + executionId] = {
            executionId: executionId, execution: __this.apiGet, url: url, params: params, sendType: sendType, useAuth: useAuth, callback: callback,
        };

        $.ajax({
            url: url,
            type: "GET",
            data: __this.transformParams(params),
            success: function (jsonResult) {
                delete __cparam.requestMap["req-" + executionId];
                if (callback) callback(jsonResult);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if (jqXHR.status == 401) {
                    delete __cparam.requestMap["req-" + executionId];
                    alert("인증이 만료 됐습니다. 다시 로그인해 주세요.");
                    location.href = "/page/index";
                    return;
                }

                __this.error(jqXHR.responseText);
                delete __cparam.requestMap["req-" + executionId];
            },
            beforeSend: function (xhr) {
                if (useAuth == true) {
                    var accessToken = __this.readCookie(NSCONFIG.context + ".access-token", "", 0);
                    if (__this.isEmpty(accessToken) == false)
                        xhr.setRequestHeader("Authorization", "Bearer " + accessToken);
                }
            }
        });
    };

    __this.apiPost = function (url, params, sendType, useAuth, callback) {
        if (__cparam.lastRequestSeq == -1) __cparam.lastRequestSeq = new Date().getTime();
        var executionId = __cparam.lastRequestSeq++;
        __cparam.requestMap["req-" + executionId] = {
            executionId: executionId, execution: __this.apiPost, url: url, params: params, sendType: sendType, useAuth: useAuth, callback: callback,
        };

        if (sendType === "form") {
        } else if (sendType === "json") {
            $.ajax({
                url: url,
                type: "POST",
                accept: "application/json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(params),
                dataType: "json",
                success: function (jsonResult) {
                    delete __cparam.requestMap["req-" + executionId];
                    if (callback) {
                        callback(jsonResult);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    if (jqXHR.status == 401) {
                        delete __cparam.requestMap["req-" + executionId];
                        alert("인증이 만료 됐습니다. 다시 로그인해 주세요.");
                        location.href = "/page/index";
                        return;
                    }

                    __this.error(jqXHR.responseText);
                    delete __cparam.requestMap["req-" + executionId];
                },
                beforeSend: function (xhr) {
                    if (useAuth == true) {
                        var accessToken = __this.readCookie(NSCONFIG.context + ".access-token", "", 0);
                        if (__this.isEmpty(accessToken) == false)
                            xhr.setRequestHeader("Authorization", "Bearer " + accessToken);
                    }
                }
            });
        } else if (sendType === "file") {
        }
    };

    __this.isScriptReady = function() {
        var keys = Object.keys(__cparam.loadScriptStatus);
        if (keys == null || keys.length === 0) return true;
        for (var i = 0; i < keys.length; i++) {
            if (__cparam.loadScriptStatus[keys[i]] === false)
                return false;
        }
        return true;
    };

    __this.loadScript = function (url, callback) {
        console.log('loading scripts... ' + url);
        __cparam.loadScriptStatus[url] = false;

        $.ajax({
            url: url + '?v=' + (new Date()).getTime(),
            dataType: 'script',
            success: function () {
                __cparam.loadScriptStatus[url] = true;
                if (callback) callback();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("code:" + jqXHR.status + "\nmessage:" + jqXHR.responseText + "\nerror:" + errorThrown);
            },
            async: true
        });
    };

    __this.loadStyleSheet = function (url) {
        console.log("loading stylesheet... " + url);
        $('head').append('<link rel="stylesheet" type="text/css" href="' + (url + "?v=" + new Date().getTime()) + '" />');
    };

    __this.B64 = {
        encode: function (s) {
            $.base64.utf8encode = true;
            $.base64.utf8decode = true;
            let encoded = $.base64('encode', s);
            return __this.isEmpty(encoded) ? "" : encoded;
        },
        decode : function (s) {
            $.base64.utf8encode = true;
            $.base64.utf8decode = true;
            let decoded = $.base64('decode', s);
            return __this.isEmpty(decoded) ? "" : decoded;
        }
    };

    __this.isEmpty = function (testVal) {
        if ((testVal == null || testVal === "null"
            || testVal === "undefined"
            || testVal.toString().trim() === "")) {
            return true;
        }
        return false;
    };

    __this.accessInitialize = function (callback) {
        __this.apiGet(NSCONFIG.envUrl, {}, "json", false, function (jsonResult) {
            __this.createCookie(NSCONFIG.context + ".env", JSON.stringify(jsonResult),30 * 24 * 60 * 60 * 1000);
            __this.verifyAccessToken(callback);
        });
    };

    __this.transformParams = function (params) {
        if (params === "undefined" || params === "null")
            return "";
        var paramsStr = "";
        var keys = Object.keys(params);
        for (var i = 0; i < keys.length; i++) {
            if (paramsStr != "") paramsStr += "&";
            paramsStr += (keys[i] + "=" + encodeURIComponent(params[keys[i]]));
        }

        if (paramsStr != "")
            return "&" + paramsStr;
        return paramsStr;
    };

    __this.verifyAccessToken = function (callback) {
        var verifyData = {};
        // verifyData.clientId = "wooriga";
        // verifyData.clientSecret = "a9bc523360d15a00b098253adeaa07f26c064b3ffd371eb7f3d47744d1484a78";
        if (location.pathname == "/page/index") {
            /* disable verify previous token */
            verifyData.accessToken = "";
        }
        else {
            verifyData.accessToken = __this.readCookie(NSCONFIG.context + ".access-token", "", 0);
        }
        verifyData.deviceOsType = "";
        verifyData.extras = {};

        // var envInfo = JSON.parse(__this.readCookie(NSCONFIG.context + ".env", "", 0));
        __this.apiPost(NSCONFIG.verifyUrl, verifyData, "json", false, function (jsonResult) {
            __this.createCookie(NSCONFIG.context + ".access-token", jsonResult.authentication.value, 12 * 60 * 60 * 1000);
            __this.createCookie(NSCONFIG.context + ".refresh-token", jsonResult.authentication.refreshToken.value, 30 * 24 * 60 * 60 * 1000);
            __this.createCookie(NSCONFIG.context + ".user-type", jsonResult.authentication.additionalInformation.userType, 12 * 60 * 60 * 1000);
            __this.createCookie(NSCONFIG.context + ".user-info", JSON.stringify(jsonResult.userInfo), 12 * 60 * 60 * 1000);

            console.log(jsonResult);
            __this.userInfo = jsonResult.userInfo;
            __this.userType = jsonResult.authentication.additionalInformation.userType;
            if (__this.isEmpty(__this.userType) == true) __this.userType = "guest";

            if (__this.userType == "guest") {
                var loginInfo = __this.readCookie(NSCONFIG.context + ".login-info", "");
                if (__this.isEmpty(loginInfo) == false) {
                    loginInfo = __this.B64.decode(loginInfo);
                    loginInfo = JSON.parse(loginInfo);
                    if (loginInfo.username && loginInfo.password) {
                        //__this.autoLogin(loginInfo, callback);
                        if (callback) callback();
                        return;
                    }
                }
                else {
                    console.log("auto login data missing...");
                }
            }

            if (callback) callback();
        });
    };

    return __this;
};

var NSCOMMON = new CommonScript();