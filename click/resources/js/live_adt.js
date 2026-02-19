	/*
	 *	HTML and JavaScript developed by Jake Jun.
	 *  email: hyun924@gmail.com 
	 *  facebook: www.facebook.com/hyun924
	 */

	var timer_winsz_check = null;
	var win_update = 0;
	var win_width = 0;
	var win_height = 0;
	var win_zoom_level = 1.0;
	var win_last_zoom_level = 1.0;

	var webmon_ctrl = true;
	var webmon = null;
	var bRet = true;

	function refresh() {
        //alert(window.detectZoom.zoom().toFixed(2));
        //alert(window.detectZoom.device().toFixed(2));
		if (win_last_zoom_level != window.detectZoom.zoom().toFixed(2))
		{
			win_last_zoom_level = window.detectZoom.zoom().toFixed(2);
			win_update = 1;
			
			/*
			if (window.detectZoom.zoom().toFixed(2) != 1.0)
				alert(zoom_warning_msg);
			*/
		}
    }

    $(document).ready(function () {
    	
    	//refresh();
    	//win_zoom_level = window.detectZoom.device().toFixed(2);
    	win_zoom_level = window.detectZoom.zoom().toFixed(2);
    	//$(window).on('resize', refresh);

    	//$(document).tooltip();
    	//$("#radioset_mainmenu").buttonset();
    	//$("#radioset_display_mode").buttonset();
    	//$("a").button();

    	var icons = {
    		header: "ui-icon-circle-plus",
    		activeHeader: "ui-icon-circle-arrow-e"
    	};
    	$(".accordion").accordion({
    		heightStyle: "content",
    		collapsible: true,
    		icons: icons
    	});
    	$(".accordion_close").accordion({
    		heightStyle: "content",
    		collapsible: true,
    		active: false,
    		icons: icons
    	});
    	
    	var leftmenu_status = true;
    	$("#menuhide_btn").click(function () {
    		$("#td_leftmenu").hide();
    		$("#leftmenu").hide("slide", { direction: "left" }, 500);
    		$("#menushow_btn").show("slide", { direction: "left" }, 500);

    		leftmenu_status = (leftmenu_status) ? false : true;

    		setTimeout(
		        function () {
		        	win_update = 1;
		        },
		        600
		    );

    	});

    	$("#menushow_btn").click(function () {
    		$("#td_leftmenu").show();
    		$("#leftmenu").show("slide", { direction: "left" }, 500);
    		$("#menushow_btn").hide("slide", { direction: "left" }, 500);

    		leftmenu_status = (leftmenu_status) ? false : true;

    		setTimeout(
		        function () {
		        	win_update = 1;
		        },
		        600
		    );
    	});

    	$(".mainmenu").click(function () {
    		var menu = $(this).attr("value");

    		switch (menu) {
    			case "Live": break;

    			case "Playback": onunload_body();
    				$("#radio2").removeAttr("checked");
    				$("#radio1").attr("checked", true);
    				document.location.href = "Playback_ADT.htm";
    				break;

    			case "Setup": onunload_body();
    				$("#radio3").removeAttr("checked");
    				$("#radio1").attr("checked", true);
    				document.location.href = "../cgi-bin/setup.cgi";
    				break;

    			default: break;
    		}
    	});

    	// 아래와 같이 사용 할 경우 IE6 에서 호환성 문제 발생.
    	//$( "input[name='display_mode']" ).bind( "click", onclick_resolution );

    	function onchanged_display_mode(mode) {
    		if (webmon_ctrl && webmon) {
    			// IE 오류 방지
    			setTimeout(
			        function () {
			        	webmon.ScreenMode(mode, -1);
			        },
			        10
			    );
    		}
    	}

    	$(".display_mode, .img_link_resolution").click(function () {
    		var mode = $(this).attr("value");

    		onchanged_display_mode(mode);

    		return mode;
    	});

    	$("#audio1, #audio2").click(function () {
    		if (webmon) {
    			$("#audio1").toggle();
    			$("#audio2").toggle();

    			set_audio_onoff();
    		}
    	});

    	$("#deinterlace1, #deinterlace2").click(function () {
    		if (webmon) {
    			$("#deinterlace1").toggle();
    			$("#deinterlace2").toggle();

    			set_deinterlace_onoff();
    		}
    	});

    	$("#live_connect").click(function () {

    		live_connect();

    	});

    	$("#live_disconnect").click(function () {
    		if ($("#conn_ch").val() < 0) {
    			webmon.DisconnectAll();
					webmon.P2PAgentDeinit();
    		} else {
    			var each_ch = $("#conn_ch").val();
    			webmon.Disconnect(each_ch);
    		}
    		set_play_pause(0);
    	});

    	$("#btn_play").click(function () {
    		if (webmon_ctrl && webmon) {
    			webmon.LivePause(0);
    			set_play_pause(1);
    		}
    	});
    	$("#btn_pause").click(function () {
    		if (webmon_ctrl && webmon) {
    			webmon.LivePause(1);
    			set_play_pause(0);
    		}
    	});

    	$("#preset_move").click(function () {

    	});

    	$("#aspect_ratio").click(function () {
    		if (webmon) {
    			webmon.SetOrgRatio();
    		}
    	});

        $("#capture_jpg").click(function () {
            if (webmon) {
                DoSnapshotImageAdmin("C:\\\\", "1234");
                // webmon.CaptureScreen(1, "C:\\abc\\Capture","", 0);
            }
        });

         $("#capture_bmp").click(function () {
            if (webmon) {
                webmon.CaptureScreen(2, "", "", 0);
            }
        });

    	$("#stream_change0").click(function () {
    		if (webmon) {
    			webmon.SetChangeStream(0);
    		}
    	});

    	$("#stream_change1").click(function () {
    		if (webmon) {
    			webmon.SetChangeStream(1);
    		}
    	});

    	$("#fullscreen").click(function () {
    		if (webmon) {
    			webmon.SetFullScreen();
    		}
    	});
		
			$("#btn_extra").click(function () {
    		if (webmon_ctrl && webmon) {
				webmon.ShowTimeline(1);
    		}
    	});

			$("#btn_extra1").click(function () {
				if (webmon_ctrl && webmon) {
					webmon.RunDevieSetup_AVR_0XM2X("101.79.62.183", "admin1", "11qqaa..", 3308,"");
					<!--webmon.RunVODBackup("D:\ArchiveData" ,"192.168.10.197" ,"192.168.10.197", "5050" ,"16", "admin" ,"1111", "1" ,"TCP");-->
				}
    	});


    	$("#logout").bind("click", onclick_logout);

    	$("#menushow_btn").hide();

    	$("#super").show();
    });

	function set_play_pause(mode) {
		if (mode == 1) { // play
			$("#play").hide();
			$("#pause").show();
		} else {
			$("#play").show();
			$("#pause").hide();
		}
	}

	function live_connect() {
		webmon.P2PAgentInit(8);
		var name = window.location.hostname;
		var server = $("#conn_server").val();
		var port = $("#conn_port").val();
		var each_ch = $("#conn_ch").val();
		var ret_intv = $("#reconn_interval").val();		
		var id = $("#conn_id").val();
		var pwd = $("#conn_pwd").val();

		if( server != ""){	
			dvr_netip = server;
		}

		if( dvr_port != ""){
			dvr_netport = port;
			webmon.SetBasePort(dvr_netport, dvr_netport);
		}
		
		if( id != ""){
			loginid = id;
			loginpwd =  pwd;
		}
		alert(name+"/"+dvr_netip+"/"+loginid+"/"+loginpwd+"/"+dvr_netport+"/"+name+"/"+each_ch);
		if (each_ch < 0) {
			webmon.DisconnectAll();
			webmon.SetAutoRecon(1, ret_intv);
			//webmon.LiveConnect(name, dvr_netip, loginid, loginpwd);//LiveConnectMac(name, dvr_netip, loginid, loginpwd, "90da6a00fa78");
			alert("###1");
			webmon.LiveConnectEx(name, dvr_netip, loginid, loginpwd, 0, 0);
			alert("###2");
			//CreateSiteWnd(0, 1); 
			//webmon.ScreenMode(4, -1);
			//webmon.SetFullScreen(); 

		} else {
			webmon.Disconnect(each_ch);
			webmon.SetAutoRecon(1, ret_intv);
			//webmon.ScreenMode(1, -1);
			webmon.LiveConnectEx(name, dvr_netip, loginid, loginpwd, 0, 0);
			alert("###2");
			webmon.LiveConnectEx(name, dvr_netip, loginid, loginpwd, 0, 1);
			alert("###2");
			webmon.LiveConnectEx(name, dvr_netip, loginid, loginpwd, 0, 2);

		}
		set_play_pause(1);
	}
	
	function ptz_control(action) {		
		if (webmon_ctrl)
			webmon.PTZControl(action);
	}
	
	
	function set_audio_onoff() {
		if (webmon_ctrl) {
			if ($("#audio2").is(":visible")) {
				webmon.SetAudioMute(1);
			} else {
				webmon.SetAudioMute(0);
			}
		}
	}

	function set_deinterlace_onoff() {
		if (webmon_ctrl) {
			if ($("#deinterlace2").is(":visible")) {
				webmon.SetDeinterlace(1);
			} else {
				webmon.SetDeinterlace(0);
			}
		}
	}

	function zoom_control(action) {
		if (webmon_ctrl) {
			webmon.PTZZoom(action);
		}
	}

	function focus_control(action) {
		if (webmon_ctrl) {
			webmon.PTZFocus(action);
		}
	}

	function set_preset_move(ch, preset_num) {
		if (webmon_ctrl) {
			webmon.PTZMovePreset(ch, preset_num);
		}
	}
	function preset_move() {
		if (webmon_ctrl) {
			var each_ch = $("#conn_ch").val();
			var preset = $("#preset").val();
			
			set_preset_move(each_ch, preset);
		}
	}
	
	function check_privateip(ip) {
		var parts = ip.split('.');
		
		if (parseInt(parts[0],10) == 10 ||
			(parseInt(parts[0],10) == 172 && (parseInt(parts[1],10) >= 16 && parseInt(parts[1], 10) <= 31)) ||
			(parseInt(parts[0],10) == 192 && parseInt(parts[1],10) == 168)) {
			return true;
		}

		return false;
	}
	
	function onload_body() {

		var hostname;

		if (webmon_ctrl) {
			hostname = window.location.hostname;

			if (hostname == "" || check_privateip(hostname)) {
				dvr_netip = dvr_ip;
				dvr_netport = dvr_port;

			} else {
				if (dvr_usep2p) {
					if (hostname == dvr_extip) {
						dvr_netip = dvr_extip;
						dvr_netport = dvr_extport;
						
					} else {
						dvr_netip = hostname;
						dvr_netport = dvr_port;
					}
					
				} else {
					dvr_netip = hostname;
					dvr_netport = dvr_port;
				}
			}
			
			// IE 오류 방지

			setTimeout(
		        function () {

		        	if (webmon == null)
		        		webmon = document.getElementById("WebMon1");

		        	try {

		        		if (webmon) {
		        			win_width = window.innerWidth;
		        			win_height = window.innerHeight;

		        			webmon.SetChLogo(chlogo_img);
		        			webmon.SetFuncHide(1, 1);
		        			webmon.CreateSiteWnd(cam_max, quad_max);
		        			webmon.SetPlayMode(1);
		        			webmon.SetAudioPlayMode(2);
		        			webmon.SetString(0, string_pos);
		        			//webmon.SetWindowSize(webmon_width, webmon_height);

		        			if (dvr_netport <= 0)
		        				dvr_netport = 9010;

		        			webmon.SetBasePort(dvr_netport, dvr_netport);
		        			webmon.SetPopupMenu(1);

		        			webmon.SetAutoRecon(1, 10);
		        			webmon.SetAudioMute(0);

		        			webmon.ScreenMode(screen_mode, -1);
		        			
		        			//$("#WebMon1").width(webmon_width);
		        			//$("#WebMon1").height(webmon_height);

							var version = webmon.GetVersion();

		        			if (bRet) {
		        				live_connect();
		        				bRet = false;
		        			}
		        			
		        			timer_winsz_check = setInterval(function () {

		        				change_webmon_size();

		        			}, 1000);
		        		}
		        	}
		        	catch (err) {
		        		webmon = null;
		        		webmon_ctrl = false;

		        		alert(unsupported_browser);

		        		onunload_body();
		        		document.location.href = "/cgi-bin/setup.cgi";
		        		return;
		        	}

		        },
		        10
		    );
			
		}
		
		var nAgt = navigator.userAgent;
		var ver_index = nAgt.indexOf("MSIE");
		if (ver_index != -1) {	//"Microsoft Internet Explorer";
			var index2 = nAgt.substring(ver_index + 5).indexOf(".");
			if (index2 != -1) {
				var ie_major_version = parseInt(nAgt.substring(ver_index + 5).substring(0, index2));
				if (ie_major_version < 9) {
					$("#logo_img").attr("style", "width: 296px;");
				}
			}
		}
		else {
			$.browser.safari = ($.browser.webkit && !(/chrome/.test(navigator.userAgent.toLowerCase())));
			if ($.browser.safari) {
				$("#logo_img").attr("style", "width: 294px;");
			} else {
				$("#logo_img").attr("style", "width: 298px;");
			}
			
			$("#td_show_menu").hide();
		}
	}
	
	function change_webmon_size() {
		if (!webmon_ctrl || !webmon) 
			return;
		
		//var zoomLevel = window.detectZoom.device().toFixed(2);
		var zoomLevel = window.detectZoom.zoom().toFixed(2);
		
		if (win_update == 1 || win_width != window.innerWidth || win_height != window.innerHeight || win_zoom_level != zoomLevel)
		{
			win_update = 0;
			
			win_width = window.innerWidth;
			win_height = window.innerHeight;
			win_zoom_level = zoomLevel;

			//webmon.SetWindowSize(webmon_width, webmon_height);
			
			//$("#WebMon1").width(webmon_width);
			//$("#WebMon1").height(webmon_height);
		}
	}
	
	function onunload_body(){
		if (!webmon_ctrl || !webmon) 
			return;

		webmon.DisconnectAll();
		webmon = null;
	}

	function onclick_logout() {
		onunload_body();
		document.location.href = "/cgi-bin/logout_proc.cgi";
	}
	
	//Select the Dialog Buttons
	function getDialogButton( button_name ) {
	  var buttons = $( '.ui-dialog-buttonpane button' );
	  for ( var i = 0; i < buttons.length; ++i ) {
	     var jButton = $( buttons[i] );
	     if ( jButton.text() == button_name )
	     {
	         return jButton;
	     }
	  }
	  return null;
	}
	//Button Controller for AJAX Loading:
	function setButton(sButtonName, sNewButtonName, bEnabled){
	    var btn = getDialogButton(sButtonName);
	    if (btn) {
	    	btn.find('.ui-button-text').html(sNewButtonName);
		    if (bEnabled) {
		        btn.removeAttr('disabled', 'true');
		        btn.removeClass( 'ui-state-disabled' );
		    } else {
		        btn.attr('disabled', 'true');
		        btn.addClass( 'ui-state-disabled' );
		    }
	    }
	}
	
