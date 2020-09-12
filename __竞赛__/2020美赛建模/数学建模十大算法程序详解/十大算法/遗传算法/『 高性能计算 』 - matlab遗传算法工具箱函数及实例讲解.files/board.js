if ((screen.width >800 )&&(screen.width<=1024)){SetCookie('screenmode','9');}
if (screen.width >1024 ){SetCookie('screenmode','12');}
function getCookieVal (offset) {var endstr=document.cookie.indexOf (";",offset);if (endstr==-1) endstr=document.cookie.length;return unescape(document.cookie.substring(offset, endstr));} 
function GetCookie (name){var arg=name+"=";var alen=arg.length;var clen=document.cookie.length;var i = 0;while (i<clen){var j=i+alen;if (document.cookie.substring(i,j)==arg) return getCookieVal (j);i = document.cookie.indexOf(" ",i)+1;if (i==0) break;} return null;} 
function SetCookie (name, value) { var argv = SetCookie.arguments;var argc = SetCookie.arguments.length;var expires = (argc > 2) ? argv[2] : null;var path = (argc > 3) ? argv[3] : null;var domain = (argc > 4) ? argv[4] : null;var secure = (argc > 5) ? argv[5] : false; document.cookie = name + "=" + escape (value) + ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) + ((path == null) ? "" : ("; path=" + path)) + ((domain == null) ? "" : ("; domain=" + domain)) + ((secure == true) ? "; secure" : ""); } 
function DeleteCookie (name) {var exp=new Date(); exp.setTime (exp.getTime()-1); var cval=GetCookie (name); document.cookie=name+"="+cval+"; expires="+exp.toGMTString();}
function MM_swapImgRestore() {var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;}
function MM_preloadImages() {var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array(); var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++) if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}}
function MM_findObj(n,d) {var p,i,x; if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) { d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);} if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;}
function MM_showHideLayers() {var i,p,v,obj,args=MM_showHideLayers.arguments;for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }obj.visibility=v; }}
function MM_swapImage() {var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3) if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}}
var currentpos,timer; 
function initialize() { timer=setInterval("scrollwindow()",10);} 
function sc(){clearInterval(timer);}
function scrollwindow() {currentpos=document.body.scrollTop;window.scroll(0,++currentpos);if (currentpos != document.body.scrollTop) sc();} 
document.onmousedown=sc
document.ondblclick=initialize
ie = (document.all)? true:false
if (ie){function ctlent(eventobject){if(event.ctrlKey && window.event.keyCode==13){this.document.FORM.submit();}}}
clckcnt = 0;
function n_display(t_id){var t_id;t_id.style.display="";} 
function clckcntr() {clckcnt++;if(clckcnt > 1) {if(clckcnt > 2) { return false; }alert('贴子已经发出了......\n\n' + '请等待片刻......\n\n' + '不要重复按提交键，谢谢！');return false;}return true;}
function PopWindow(){openScript('misc.cgi?action=newmsg',420,320);}
var nn = !!document.layers;
var ie = !!document.all;
if (nn) {netscape.security.PrivilegeManager.enablePrivilege("UniversalSystemClipboardAccess");  var fr=new java.awt.Frame();  var Zwischenablage = fr.getToolkit().getSystemClipboard();}
function h_display(t_id){var t_id;t_id.style.display="none";}
function copy(textarea){if (nn) {textarea.select();Zwischenablage.setContents(new java.awt.datatransfer.StringSelection(textarea.value), null);} else if (ie) {textarea.select();cbBuffer=textarea.createTextRange();cbBuffer.execCommand('Copy');}}
function paste(textarea){ if (nn) {var Inhalt=Zwischenablage.getContents(null); if (Inhalt!=null) textarea.value=Inhalt.getTransferData(java.awt.datatransfer.DataFlavor.stringFlavor);} else if (ie) {textarea.select(); cbBuffer=textarea.createTextRange(); cbBuffer.execCommand('Paste');}}
function openScript(url, width, height){var Win = window.open(url,"openScript",'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=yes,status=yes' );}
function runEx(){var winEx = window.open("", "winEx", "width=300,height=200,status=yes,menubar=yes,scrollbars=yes,resizable=yes"); winEx.document.open("text/html", "replace"); winEx.document.write(unescape(event.srcElement.parentElement.children[2].value)); winEx.document.close(); }
