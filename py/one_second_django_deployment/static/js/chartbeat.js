(function(){function f(){this.a=window._sf_async_config||{};this.v=i(this,this.z);this.e=[]}function i(a,c){return function(){c.apply(a,arguments)}}function j(){var a,c,b;a="";for(b=0;b<16;b++){c=Math.floor(Math.random()*36).toString(36);a+=c}return a}function l(a,c,b){a.a[c]=a.a[c]||b}
function m(a){if(!n("_SUPERFLY_nosample"))if(a.w)a.l();else{a.w=true;if(window._sf_async_config)a.l();else{a=i(a,a.l);if(typeof window.addEventListener!="undefined")window.addEventListener("load",a,false);else if(typeof document.addEventListener!="undefined")document.addEventListener("load",a,false);else typeof window.attachEvent!="undefined"&&window.attachEvent("onload",a)}}}
function o(a){a.h=0;a.k=0;a.s=p();a.m=true;a.i=null;a.o=72E5;for(var c=document.getElementsByTagName("script"),b=0;b<c.length;b++)if(c[b].src.match(/(chartbeat|chartbeatdev|chartbeat_raw).js/)){var d=c[b];break}if(d){b=d.src.split("?")[1];c={};if(b){if(b.charAt(0)=="?")b=b.substring(1);b=b.replace("+"," ");b=b.split(/[&;]/g);for(d=0;d<b.length;d++){var e=b[d].split("=");c[decodeURIComponent(e[0])]=decodeURIComponent(e[1])}}l(a,"uid",c.uid);l(a,"domain",c.domain)}c=window.location;l(a,"pingServer",
"ping.chartbeat.net");l(a,"title",document.title);l(a,"domain",c.host);a:{b=null;if(a.a.useCanonical){b=null;d=document.getElementsByTagName("link");for(e=0;e<d.length;++e)if(d[e].rel=="canonical"){b=d[e].href;b=b.substring(b.indexOf("/",9))}if(b=b){b=b;break a}}e=window.location;b=e.pathname+(e.search||"");b=b.replace(/PHPSESSID=[^&]+/,"");d=/&utm_[^=]+=[^&]+/ig;if(e=d.exec(e.search))b=b.replace(d,"");d=/\?utm_[^=]+=[^&]+(.*)/i;if(e=d.exec(b))b=b.replace(d,e[1]!=""?"?"+e[1]:"");b=b}l(a,"path",b);
b=parseInt(a.a.sessionLength,10);if(!isNaN(b))a.o=b*60*1E3;a.A=j(a);a.n=c.host;a.n=a.n.replace(/^www\./,"");a.a.domain=a.a.domain.replace(/^www\./,"");a.f=n("_chartbeat2");a.q=0;if(!a.f){a.f=n("_chartbeat");if(a.f)n("_chartbeat")&&q("_chartbeat","",-1);else{a.q=1;a.f=j(a)}}q("_chartbeat2",a.f,30);if(a.c)r(a.c);else a.c=new s}f.prototype.B=function(a,c){this.t=window.location.protocol+"//"+this.a.domain+this.a.path;this.a.path=a;if(c)this.a.title=c;window.clearInterval(this.j);o(this);m(this)};
f.prototype.u=function(a){this.i=a};f.prototype.l=function(){var a=window._sf_startpt,c=window._sf_endpt;if(typeof a=="number")this.r=typeof c=="number"?c-a:p()-a;this.j=window.setInterval(i(this,this.p),15E3);this.p()};f.prototype.z=function(){this.e.push(1);for(var a=0,c=0;c<this.e.length;++c)a+=this.e[c];if(a<3){this.m=true;t(this)}else{clearInterval(this.j);q("_SUPERFLY_nosample","1",0.0070)}};function t(a){var c=a.h;c=c?Math.min(c*2,16):1;a.h=c}
f.prototype.p=function(){var a;a:{a=this.c;for(var c=0;c<a.g.length;c++)if(a.b[a.d][a.g[c]]){a=true;break a}a=false}u(this.c);if(this.k<this.h&&!a)this.k++;else{if(a)this.h=0;else t(this);this.k=0;a=v(this);var b=c=0,d=0;if(w(this.c,"onkeydown"))b=1;else if(w(this.c,"onmousemove")||w(this.c,"onscroll"))c=1;else d=1;var e=this.a,g="",h="",k=window.location;if(this.m){this.m=false;if(this.t){g=this.t;h=true}else{g=document.referrer||"";h=g.indexOf("://"+k.host+"/")!=-1}g=(h?"&v=":"&r=")+encodeURIComponent(g);
h=e.title.slice(0,100);h="&i="+encodeURIComponent(h)}var z=this.r?"&b="+this.r:"",A=this.i?"&A="+this.i:"",B=e.sections?"&g0="+encodeURIComponent(e.sections):"",C=e.authors?"&g1="+encodeURIComponent(e.authors):"";this.e.push(0);this.e.length>18&&this.e.shift();var D=(k.protocol||"http:")+"//"+e.pingServer+"/ping?h="+encodeURIComponent(e.domain)+"&p="+encodeURIComponent(e.path)+"&u="+this.f+"&d=";k=k.host.replace(/^www\./,"");a=D+encodeURIComponent(k)+"&g="+e.uid+B+C+"&n="+this.q+"&c="+Math.round((p()-
this.s)/600)/100+"&x="+a+"&y="+(document.body.scrollHeight||0)+"&w="+(window.innerHeight||document.body.offsetHeight||0)+"&j="+Math.round((this.h+2)*15E3/1E3)+"&R="+c+"&W="+b+"&I="+d+g+z+A+"&t="+this.A+h+"&_";c=new Image(1,1);c.onerror=this.v;c.src=a;p()-this.s>=this.o&&window.clearInterval(this.j)}};
function v(){var a=window,c=document.body,b=document.documentElement;if(typeof a.pageYOffset=="number")return a.pageYOffset;else if(c&&c.scrollTop)return c.scrollTop;else if(b&&b.scrollTop)return b.scrollTop;return 0}function s(){this.g=[];x(this,window,"onscroll");x(this,document.body,"onkeydown");x(this,document.body,"onmousemove");r(this)}function r(a){a.b=[{},{},{},{}];a.d=0;u(a)}
function x(a,c,b){var d=c[b]||function(){};a.g.push(b);c[b]=function(e){d.apply(this,arguments);if(e&&b=="onkeydown"){var g=e.keyCode?e.keyCode:e.which;if(g==32||g>36&&g<41){a.b[a.d].onscroll++;return}}a.b[a.d][b]++}}function w(a,c){for(var b=0,d=0;d<a.b.length;d++)b+=a.b[d][c]||0;return b}function u(a){a.d=(a.d+1)%a.b.length;for(var c=0;c<a.g.length;c++)a.b[a.d][a.g[c]]=0}
function n(a){a=a+"=";for(var c=document.cookie.split(";"),b=0;b<c.length;b++){for(var d=c[b];d.charAt(0)==" ";)d=d.substring(1,d.length);if(d.indexOf(a)==0)return d.substring(a.length,d.length)}return null}function q(a,c,b){var d=new Date;d.setTime(p()+b*864E5);document.cookie=a+"="+c+("; expires="+d.toGMTString())+"; path=/"}function p(){return(new Date).getTime()}var y=new f;o(y);window.pSUPERFLY=y;f.prototype.virtualPage=f.prototype.B;f.prototype.activity=f.prototype.u;m(y);})();