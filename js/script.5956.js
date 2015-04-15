window.lazySizesConfig=window.lazySizesConfig||{},window.lazySizesConfig.lazyClass="js-lazyload",lazySizesConfig.preloadClass="js-lazypreload",lazySizesConfig.loadingClass="js-lazyloading",lazySizesConfig.loadedClass="js-lazyloaded",window.lazySizesConfig.preloadAfterLoad=!/mobi/i.test(navigator.userAgent),function(){"use strict";if(window.addEventListener){var a={nodeName:""},b=!!window.HTMLPictureElement,c=function(c){var d,e,f,g,h,i=c.target.querySelectorAll("img, iframe");for(d=0;d<i.length;d++)e=i[d].getAttribute("srcset")||"picture"==(i[d].parentNode||a).toLowerCase(),!b&&e&&lazySizes.uP(i[d]),i[d].complete||!e&&!i[d].src||(c.detail.firesLoad=!0,g&&h||(h=0,g=function(a){h--,a&&!(1>h)||f||(f=!0,c.detail.firesLoad=!1,lazySizes.fire(c.target,"_lazyloaded",{},!1,!0)),a&&a.target&&(a.target.removeEventListener("load",g),a.target.removeEventListener("error",g))},setTimeout(g,3500)),h++,i[d].addEventListener("load",g),i[d].addEventListener("error",g))};addEventListener("lazybeforeunveil",function(a){if(!a.defaultPrevented&&null!=a.target.getAttribute("data-noscript")){var b=a.target.querySelector('noscript, script[type*="html"]')||{},d=b.textContent||b.innerText;d&&(a.target.innerHTML=d,c(a))}})}}(),!function(a,b){var c=b(a,a.document);a.lazySizes=c,"object"==typeof module&&module.exports?module.exports=c:"function"==typeof define&&define.amd&&define(c)}(window,function(a,b){"use strict";if(b.getElementsByClassName){var c,d=b.documentElement,e=a.addEventListener,f=a.setTimeout,g=a.requestAnimationFrame||f,h=/^picture$/i,i=["load","error","lazyincluded","_lazyloaded"],j=function(a,b){var c=new RegExp("(\\s|^)"+b+"(\\s|$)");return a.className.match(c)&&c},k=function(a,b){j(a,b)||(a.className+=" "+b)},l=function(a,b){var c;(c=j(a,b))&&(a.className=a.className.replace(c," "))},m=function(a,b,c){var d=c?"addEventListener":"removeEventListener";c&&m(a,b),i.forEach(function(c){a[d](c,b)})},n=function(a,c,d,e,f){var g=b.createEvent("CustomEvent");return g.initCustomEvent(c,!e,!f,d),g.details=g.detail,a.dispatchEvent(g),g},o=function(b,d){var e;a.HTMLPictureElement||((e=a.picturefill||a.respimage||c.pf)?e({reevaluate:!0,reparse:!0,elements:[b]}):d&&d.src&&(b.src=d.src))},p=function(a,b){return getComputedStyle(a,null)[b]},q=function(a,b,d){for(d=d||a.offsetWidth;d<c.minSize&&b&&!a._lazysizesWidth;)d=b.offsetWidth,b=b.parentNode;return d},r=function(a){var b,d=0,e=function(){b=!1,d=Date.now(),a()},h=function(){f(e)},i=function(){g(h)};return function(){if(!b){var a=c.throttle-(Date.now()-d);b=!0,9>a&&(a=9),f(i,a)}}},s=function(){var i,q,s,u,v,w,x,y,z,A,B,C,D,E=/^img$/i,F=/^iframe$/i,G="onscroll"in a&&!/glebot/.test(navigator.userAgent),H=0,I=0,J=0,K=0,L=0,M=function(a){K--,a&&a.target&&m(a.target,M),(!a||0>K||!a.target)&&(K=0)},N=function(a,b){var c,d=a,e="hidden"!=p(a,"visibility");for(y-=b,B+=b,z-=b,A+=b;e&&(d=d.offsetParent);)e=(p(d,"opacity")||1)>0,e&&"visible"!=p(d,"overflow")&&(c=d.getBoundingClientRect(),e=A>c.left&&z<c.right&&B>c.top-1&&y<c.bottom+1);return e},O=function(){var a,b,d,e,f,g,h,j,k,l;if((v=c.loadMode)&&(a=i.length)){for(d=Date.now(),b=L,J++,D>I&&1>K&&J>4&&v>2?(I=D,J=0):I=I!=C&&v>1&&J>3?C:H;a>b;b++,L++)if(i[b]&&!i[b]._lazyRace)if(G){if((k=i[b].getAttribute("data-expand"))&&(h=1*k)||(h=I),!(K>6&&(!k||"src"in i[b])))if(l!==h&&(w=innerWidth+h,x=innerHeight+h,j=-1*h,l=h),e=i[b].getBoundingClientRect(),(B=e.bottom)>=j&&(y=e.top)<=x&&(A=e.right)>=j&&(z=e.left)<=w&&(B||A||z||y)&&(s&&3>K&&4>J&&!k&&v>2||N(i[b],h)))S(i[b],!1,e.width),L--,d++,g=!0;else{if(J&&Date.now()-d>3)return L++,void P();!g&&s&&!f&&3>K&&4>J&&v>2&&(q[0]||c.preloadAfterLoad)&&(q[0]||!k&&(B||A||z||y||"auto"!=i[b].getAttribute(c.sizesAttr)))&&(f=q[0]||i[b])}}else S(i[b]);f&&!g&&S(f)}L=0},P=r(O),Q=function(a){k(a.target,c.loadedClass),l(a.target,c.loadingClass),m(a.target,Q)},R=function(a,b){try{a.contentWindow.location.replace(b)}catch(c){a.setAttribute("src",b)}},S=function(a,b,d){var e,i,p,q,r,v,w,x,y,z,A,B=a.currentSrc||a.src,C=E.test(a.nodeName),D=a.getAttribute(c.sizesAttr)||a.getAttribute("sizes"),G="auto"==D;(!G&&s||!C||!B||a.complete||j(a,c.errorClass))&&(a._lazyRace=!0,g(function(){if(a._lazyRace&&delete a._lazyRace,l(a,c.lazyClass),(y=n(a,"lazybeforeunveil",{force:!!b})).defaultPrevented||(D&&(G?(t.updateElem(a,!0,d),k(a,c.autosizesClass)):a.setAttribute("sizes",D)),v=a.getAttribute(c.srcsetAttr),r=a.getAttribute(c.srcAttr),C&&(w=a.parentNode,x=h.test(w.nodeName||"")),z=y.detail.firesLoad||"src"in a&&(v||r||x),z&&(K++,m(a,M,!0),clearTimeout(u),u=f(M,2500),k(a,c.loadingClass),m(a,Q,!0))),x)for(e=w.getElementsByTagName("source"),i=0,p=e.length;p>i;i++)(A=c.customMedia[e[i].getAttribute("data-media")||e[i].getAttribute("media")])&&e[i].setAttribute("media",A),q=e[i].getAttribute(c.srcsetAttr),q&&e[i].setAttribute("srcset",q);v?a.setAttribute("srcset",v):r&&(F.test(a.nodeName)?R(a,r):a.setAttribute("src",r)),(v||x)&&o(a,{src:r}),(!z||a.complete&&B==(a.currentSrc||a.src))&&(z&&M(y),Q(y)),a=null}))},T=function(){var a,b=function(){c.loadMode=3,P()};s=!0,J+=8,c.loadMode=3,e("scroll",function(){3==c.loadMode&&(c.loadMode=2),clearTimeout(a),a=f(b,99)},!0)};return{_:function(){i=b.getElementsByClassName(c.lazyClass),q=b.getElementsByClassName(c.lazyClass+" "+c.preloadClass),C=c.expand,D=Math.round(C*c.expFactor),e("scroll",P,!0),e("resize",P,!0),a.MutationObserver?new MutationObserver(P).observe(d,{childList:!0,subtree:!0,attributes:!0}):(d.addEventListener("DOMNodeInserted",P,!0),d.addEventListener("DOMAttrModified",P,!0),setInterval(P,999)),e("hashchange",P,!0),["focus","mouseover","click","load","transitionend","animationend","webkitAnimationEnd"].forEach(function(a){b.addEventListener(a,P,!0)}),(s=/d$|^c/.test(b.readyState))?T():(e("load",T),b.addEventListener("DOMContentLoaded",P)),P()},checkElems:P,unveil:S}}(),t=function(){var a,d=function(a,b,c){var d,e,f,g,i=a.parentNode;if(i&&(c=q(a,i,c),g=n(a,"lazybeforesizes",{width:c,dataAttr:!!b}),!g.defaultPrevented&&(c=g.detail.width,c&&c!==a._lazysizesWidth))){if(a._lazysizesWidth=c,c+="px",a.setAttribute("sizes",c),h.test(i.nodeName||""))for(d=i.getElementsByTagName("source"),e=0,f=d.length;f>e;e++)d[e].setAttribute("sizes",c);g.detail.dataAttr||o(a,g.detail)}},f=function(){var b,c=a.length;if(c)for(b=0;c>b;b++)d(a[b])},g=r(f);return{_:function(){a=b.getElementsByClassName(c.autosizesClass),e("resize",g)},checkElems:g,updateElem:d}}(),u=function(){u.i||(u.i=!0,t._(),s._())};return function(){var b,d={lazyClass:"lazyload",loadedClass:"lazyloaded",loadingClass:"lazyloading",preloadClass:"lazypreload",errorClass:"lazyerror",autosizesClass:"lazyautosizes",srcAttr:"data-src",srcsetAttr:"data-srcset",sizesAttr:"data-sizes",minSize:40,customMedia:{},init:!0,expFactor:2,expand:374,loadMode:2,throttle:99};c=a.lazySizesConfig||a.lazysizesConfig||{};for(b in d)b in c||(c[b]=d[b]);a.lazySizesConfig=c,f(function(){c.init&&u()})}(),{cfg:c,autoSizer:t,loader:s,init:u,uP:o,aC:k,rC:l,hC:j,fire:n,gW:q}}}),function(){for(var a,b=function(){},c=["assert","clear","count","debug","dir","dirxml","error","exception","group","groupCollapsed","groupEnd","info","log","markTimeline","profile","profileEnd","table","time","timeEnd","timeStamp","trace","warn"],d=c.length,e=window.console=window.console||{};d--;)a=c[d],e[a]||(e[a]=b)}(),function(){var a,b;b=function(){var a,b,c;b={hidden:"visibilitychange",webkitHidden:"webkitvisibilitychange",mozHidden:"mozvisibilitychange",msHidden:"msvisibilitychange"};for(c in b)if(c in document){a=b[c];break}return function(b){return b&&document.addEventListener(a,b),!document[c]}}(),a=document.title,b(function(){document.title=b()?a:"Em and Mike's Wedding"})}.call(this);