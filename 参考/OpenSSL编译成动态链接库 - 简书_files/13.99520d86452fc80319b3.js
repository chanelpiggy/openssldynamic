(window.webpackJsonp=window.webpackJsonp||[]).push([[13],{BFo6:function(t,e,n){"use strict";n.r(e);var a=n("o0o1"),s=n.n(a),i=(n("ls82"),n("HaE+")),c=(n("tUrg"),n("q1tI")),o=n.n(c),r=n("NTd/"),u=n.n(r),l=n("g3DI"),_=n("f1tA"),p=n("G9T2"),E=n("9OZg"),f=n("Ds6n"),v=n.n(f),O=o.a.createElement,d=function(t){var e=t.slug,n=t.title,a=t.count,s=t.index+1,i="/p/".concat(e);Object(c.useEffect)(function(){M.$sensor.trackEvent(M.$sensor.events.PC_NOTE_PAGE_RIGHT_RECOMMEND_NOTE_IMPRESSION,{position:s,note_title:n})},[s,n]);var o=Object(c.useCallback)(function(){M.$sensor.trackEvent(M.$sensor.events.PC_NOTE_PAGE_RIGHT_RECOMMEND_NOTE_CLICK,{position:s})},[s]);return O("div",{className:v.a.item,role:"listitem"},O("div",{className:v.a.title,title:n},O(E.a,{className:v.a.link,to:i,onClick:o,openNewTab:!0},n)),O("div",{className:v.a.count},u.a.get("common.read")," ",a.toLocaleString()))};e.default=Object(_.a)(function(t){var e=t.slug,n=Object(c.useState)([]),a=n[0],o=n[1];return Object(c.useEffect)(function(){!function(){var t=Object(i.a)(s.a.mark(function t(){var n,a;return s.a.wrap(function(t){for(;;)switch(t.prev=t.next){case 0:return t.prev=0,t.next=3,Object(l.r)(e);case 3:n=t.sent,a=n.data,window.requestAnimationFrame(function(){o(a)}),t.next=10;break;case 8:t.prev=8,t.t0=t.catch(0);case 10:case"end":return t.stop()}},t,null,[[0,8]])}));return function(){return t.apply(this,arguments)}}()()},[e]),M.$sensor.trackEvent(M.$sensor.events.PC_NOTE_REC_NOTES_STATUS,{position:"rec_right",show:a.length?1:0}),0===a.length?null:O(p.a,{position:"right"},O(p.b,{className:v.a.header},O("span",null,u.a.get("sideList.title"))),a.map(function(t,e){var n=t.id,a=t.slug,s=t.title,i=t.views_count;return O(d,{key:n,slug:a,title:s,count:i,index:e})}))})},Ds6n:function(t,e,n){t.exports={header:"QHRnq8",item:"cuOxAY",title:"_3L5YSq",link:"_1-HJSV",count:"_19haGh"}}}]);