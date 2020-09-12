function openchromeless(theURL,wname,W,H,CLOSEdwn,CLOSEup,CLOSEovr,NONEgrf,CLOCKgrf,winTIT,winREALtit,winBORDERCOLOR,winBORDERCOLORsel,winBGCOLOR) {
var windowW=W;var windowH=H;var windowX=Math.ceil((window.screen.width-windowW)/2);var windowY=Math.ceil((window.screen.height-windowH)/2);
if (navigator.appName=="Microsoft Internet Explorer" && parseInt(navigator.appVersion)>=4) isie=true
else isie=false
if (isie) {H=H+22+10+2;W=W+10+10+2;}
s=",width="+W+",height="+H;
if (isie && (navigator.userAgent.toLowerCase().indexOf("win")!=-1) ) {
var dowin=theURL != "" ? true : false;
var chromeTIThtml='\n'+
'<html><head>'+'\n'+
'<style type="text/css">'+'\n'+
'#mywinTITLE{position:absolute;left:0px;top:0px;width:100%;height:22px;z-index:1;background-color:'+winBGCOLOR+';clip:rect(0,100%,22,0);}'+'\n'+
'#mywindow{position:absolute;left:0px;top:0px;width:100%;height:22px;z-index:2;clip:rect(0,100%;22,0);}'+ '\n'+
'#mywindowCLOSE{position:absolute;left:-22px;top:-22px;width:11px;height:11px;z-index:3;clip:rect(0,11,11,0);}'+'\n'+
'#myCLOCKgrf{position:absolute;left:-22px;top:-22px;width:11px;height:11px;z-index:3;clip:rect(0,11,11,0);}'+ '\n'+
'</style>'+'\n'+
'<script language="javascript">'+'\n'
chromeTIThtml=chromeTIThtml+
'theURL="'+theURL+'"'+'\n'+
'CLOSEdwn="'+CLOSEdwn+'"'+'\n'+
'CLOSEup="'+CLOSEup+'"'+'\n'+
'CLOSEovr="'+CLOSEovr+'"'+'\n'+
'CLOCKgrf="'+CLOCKgrf+'"'+'\n'+
'winBORDERCOLOR="'+winBORDERCOLOR+'"'+'\n'+
'winBORDERCOLORsel="'+winBORDERCOLORsel+'"'+'\n'+
'winBGCOLOR="'+winBGCOLOR+'"'+'\n'
chromeTIThtml=chromeTIThtml+
'var windowCLOSEIMGdwn=new Image();windowCLOSEIMGdwn.src=CLOSEdwn;var windowCERRARImg_d=new Image();windowCERRARImg_d.src=CLOSEup;var windowCERRARImg_o=new Image();windowCERRARImg_o.src=CLOSEovr;var CLOCKgrfImg=new Image();CLOCKgrfImg.src=CLOCKgrf;'+'\n'+
'function mouseSTATUS() {this.x=null;this.y=null;this.bt="up";this.oldx=null;this.oldy=null;this.dx=null;this.dy=null;this.screeny=null;this.screenx=null;this.element=null;this.event=null;}var mouse = new mouseSTATUS();'+'\n'+
'function actualizateMouseSTATUS(e){if (!e) var e=event;if ((e.type=="mousedown"||e.type=="mouseup")&&e.button!=1) return true;var x=e.x+document.body.scrollLeft;var y=e.y+document.body.scrollTop;mouse.x=x;mouse.y=y;if (e.type=="mousedown") mouse.bt="down";else if (e.type=="mouseup") mouse.bt="up";if (window.event) {mouse.screenx=window.event.screenX;mouse.screeny=window.event.screenY;}else{mouse.screenx=-1;mouse.screeny=-1;}}'+'\n'+
'function initMouseEvents() {document.onmousedown=actualizateMouseSTATUS;document.onmousemove=actualizateMouseSTATUS;document.onmouseup=actualizateMouseSTATUS;document.onselectstart=selectstart;document.ondragstart=new Function("actualizateMouseSTATUS(event);return false;");document.oncontextmenu=new Function("return false;")}'+'\n'+
'function selectstart(){if (event.srcElement.tagName!="INPUT"&&event.srcElement.tagName!="TEXTAREA") {return false;}else{mouse.bt="up"; return true;}}initMouseEvents();var mywindowbt="up";var wincloseSTATUS="up";var ofx=0;var ofy=0;var opx=0;var opy=0;var px=0;var py=0;var wcpx1=-1,wcpy1=-1;var wcpx2=-1,wcpy2=-1;var wclosechanged = false;'+'\n'+
'function initToMoveWin(){if (wincloseSTATUS=="up"&&(mywindowbt=="up"||mywindowbt=="over")){if (parent.mainloaded) document.all["myCLOCKgrf"].style.visibility="hidden";document.all["myCLOCKgrf"].style.pixelLeft=document.body.clientWidth-36;document.all["myCLOCKgrf"].style.pixelTop=5;wcpx1=document.all["mywindowCLOSE"].style.pixelLeft=document.body.clientWidth-21;wcpy1=document.all["mywindowCLOSE"].style.pixelTop=5;wcpx2=wcpx1+11-1;wcpy2=wcpy1+11-1;if (mouse.x>=wcpx1&&mouse.x<=wcpx2&&mouse.y>=wcpy1&&mouse.y<=wcpy2){if (wclosechanged==false){document.all["mywindowCLOSE"].document.images["closewin"].src=windowCERRARImg_o.src;wclosechanged=true}} else if (wclosechanged==true) {document.all["mywindowCLOSE"].document.images["closewin"].src=windowCERRARImg_d.src;wclosechanged = false}}if (mouse.y<=22&&mouse.y>=1&&mywindowbt=="up"&&mouse.bt=="up"){mywindowbt="over"}else if ((mouse.y>22||mouse.y<1)&&mywindowbt=="over"&&mouse.bt=="up"){mywindowbt="up"}else if (mouse.y<=22&&mouse.y>=1&&mywindowbt=="over"&&mouse.bt=="down"){self.window.focus();if (mouse.x>=wcpx1&&mouse.x<=wcpx2&&mouse.y>=wcpy1&&mouse.y<=wcpy2){wincloseSTATUS="down";document.all["mywindowCLOSE"].document.images["closewin"].src=windowCLOSEIMGdwn.src;}else{parent.bordeT.document.bgColor=winBORDERCOLORsel;parent.bordeB.document.bgColor=winBORDERCOLORsel;parent.bordeL.document.bgColor=winBORDERCOLORsel;parent.bordeR.document.bgColor=winBORDERCOLORsel;ofx=mouse.x;ofy=mouse.y;opx=mouse.x;opy=mouse.y;}mywindowbt="down";}else if (mouse.bt=="up"&&mywindowbt=="down") {mywindowbt="up";ofx=0;ofy=0;opx=0;opy=0;if (mouse.x>=wcpx1&&mouse.x<=wcpx2&&mouse.y>=wcpy1&&mouse.y<=wcpy2&&wincloseSTATUS=="down") {top.window.close()}wincloseSTATUS="up";if (document.all["mywinTITLE"]) {parent.bordeT.document.bgColor=winBORDERCOLOR;parent.bordeB.document.bgColor=winBORDERCOLOR;parent.bordeL.document.bgColor=winBORDERCOLOR;parent.bordeR.document.bgColor=winBORDERCOLOR}}else if (mywindowbt=="down"&&wincloseSTATUS=="up") {var m_scrx=mouse.screenx;var m_scry=mouse.screeny;opx=px+ofx-m_scrx;opy=py+ofy-m_scry;px=m_scrx-ofx;py=m_scry-ofy;top.window.moveTo(px,py);}setTimeout("initToMoveWin()",20);}</script></head>'+'\n'+
'<body TOPMARGIN=0 LEFTMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 scroll=no style="border: 0px solid '+winBORDERCOLOR+'; overflow: hidden; margin: 0pt;" bgcolor='+winBGCOLOR+'>'+'\n'+
'<div id=mywindow><img src="'+NONEgrf+'" width=100% height=22></div><div id=mywinTITLE>'+ '<table width=100% height=22 border=0 cellpadding=0 cellspacing=0><tr><td valign=middle align=left>'+winTIT+'</td></tr></table></div><div id=mywindowCLOSE><img name=closewin src="'+CLOSEup+'" border=0 width=11 height=11></div><div id=myCLOCKgrf><img name=clockwin src="'+CLOCKgrf+'" border=0 width=11 height=11></div>'+'\n'+
'</body>'+'\n'+
'<script>initToMoveWin();</script>'+'\n'+
'</html>'+'\n'
var chromeFRMhtml = '' +
'<HTML><HEAD><TITLE>'+ winREALtit +'</TITLE></HEAD>'+'\n'+
'<script>'+'\n'+
'mainloaded=false'+'\n'+
'function generatetitle() {if( window.frames["frmTIT"]&&window.frames["bordeL"]&&window.frames["bordeB"]&&window.frames["bordeR"]&&window.frames["noneL"]&&window.frames["noneR"]&&window.frames["noneB"]) {frmTIT.document.open();frmTIT.document.write("'+ quitasaltolinea(chromeTIThtml) +'");frmTIT.document.close();noneL.document.bgColor="'+winBGCOLOR+'";noneR.document.bgColor="'+winBGCOLOR+'";noneB.document.bgColor="'+winBGCOLOR+'";bordeL.document.bgColor="'+winBORDERCOLOR+'";bordeR.document.bgColor="'+winBORDERCOLOR+'";bordeB.document.bgColor="'+winBORDERCOLOR+'";bordeT.document.bgColor="'+winBORDERCOLOR+'";} else {setTimeout("generatetitle()",200)}}generatetitle()'+'\n'+
'</script>'+'\n'+
'<frameset border=0 framespacing=0 frameborder=0 rows="22,100%,10" onload="mainloaded=true" onreadystatechange="generatetitle()"><frame name=frmTIT src="about:blank" scrolling=no noresize><frameset border=0 framespacing=0 frameborder=0 cols="10,1,100%,1,10"><frame name=noneL src="about:blank" scrolling=no noresize><frame name=bordeL src="about:blank" scrolling=no noresize><frameset border=0 framespacing=0 frameborder=0 rows="1,100%,1"><frame name=bordeT src="about:blank" scrolling=no noresize><frame name=main   src="'+theURL+'"><frame name=bordeB src="about:blank" scrolling=no noresize></frameset><frame name=bordeR src="about:blank" scrolling=no noresize><frame name=noneR src="about:blank" scrolling=no noresize></frameset><frame name=noneB src="about:blank" scrolling=no noresize></frameset>'+'\n'+
'</HTML>'
splashWin=window.open("",wname,"fullscreen=1,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0"+s);splashWin.resizeTo(Math.ceil(W),Math.ceil(H));splashWin.moveTo(Math.ceil(windowX),Math.ceil(windowY));splashWin.document.open();splashWin.document.write( chromeFRMhtml );splashWin.document.close();}else{var splashWin=window.open(theURL,wname,"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1"+s,true);}splashWin.focus();}
function quitasaltolinea(txt) {
var salida=txt.toString()
var re=/\\/g;var salida=salida.replace(re,"\\\\");var re=/\//g;var salida=salida.replace(re,"\\\/");var re=/\"/g;var salida=salida.replace(re,"\\\"");var re=/\'/g;var salida=salida.replace(re,"\\\'");var re=/\n/g;var salida=salida.replace(re,"\\n");var re=/  /g;var salida=salida.replace(re,"");var re=/\t/g;var salida=salida.replace(re,"");var re=/\r/g;var salida=salida.replace(re,"");
return salida
}
