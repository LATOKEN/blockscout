(this.webpackJsonp=this.webpackJsonp||[]).push([[11],{Gs6c:function(t,e,u){"use strict";u("jaBk");var a=u("2ibD"),i=u("z/4y");e.a=new class extends i.a{constructor(){super(),this.pendingRequests={}}override(t,e){this.internalStorage[t]=e}retrieve(t,e){var u=this;if(this.hasData(t)&&!e)return Promise.resolve(this.get(t));let i=this.pendingRequests[t];return i||(i=a.a.get(t).then((function(e){let{data:a}=e;u.internalStorage[t]=a,delete u.pendingRequests[t]})).catch((function(e){const a=new Error("".concat(t,": ").concat(e.message));throw a.textStatus=e.message,delete u.pendingRequests[t],a})),this.pendingRequests[t]=i),i.then((function(){return u.get(t)}))}}},Jn9D:function(t,e,u){"use strict";u.d(e,"b",(function(){return j}));u("z4I3"),u("jaBk"),u("Ag57"),u("GzNv"),u("QifN"),u("S26F"),u("TZoF"),u("pBsb"),u("Ch9p"),u("Jh6P"),u("orcL");var a=u("05sH"),i=u.n(a),n=u("TKCn"),s=u.n(n),r=u("G3fq"),l=u.n(r),c=u("EmJ/"),o=u.n(c),p=(u("uK44"),u("tDP3")),A=u("2ibD"),h=u("/lV4"),d=u("NY3P"),F=u("uyVa"),g=u("Gs6c"),D=u("NmEs"),m=u("bOix");var f={unicodeLetters:"\\u0041-\\u005A\\u0061-\\u007A\\u00AA\\u00B5\\u00BA\\u00C0-\\u00D6\\u00D8-\\u00F6\\u00F8-\\u02C1\\u02C6-\\u02D1\\u02E0-\\u02E4\\u02EC\\u02EE\\u0370-\\u0374\\u0376\\u0377\\u037A-\\u037D\\u0386\\u0388-\\u038A\\u038C\\u038E-\\u03A1\\u03A3-\\u03F5\\u03F7-\\u0481\\u048A-\\u0527\\u0531-\\u0556\\u0559\\u0561-\\u0587\\u05D0-\\u05EA\\u05F0-\\u05F2\\u0620-\\u064A\\u066E\\u066F\\u0671-\\u06D3\\u06D5\\u06E5\\u06E6\\u06EE\\u06EF\\u06FA-\\u06FC\\u06FF\\u0710\\u0712-\\u072F\\u074D-\\u07A5\\u07B1\\u07CA-\\u07EA\\u07F4\\u07F5\\u07FA\\u0800-\\u0815\\u081A\\u0824\\u0828\\u0840-\\u0858\\u08A0\\u08A2-\\u08AC\\u0904-\\u0939\\u093D\\u0950\\u0958-\\u0961\\u0971-\\u0977\\u0979-\\u097F\\u0985-\\u098C\\u098F\\u0990\\u0993-\\u09A8\\u09AA-\\u09B0\\u09B2\\u09B6-\\u09B9\\u09BD\\u09CE\\u09DC\\u09DD\\u09DF-\\u09E1\\u09F0\\u09F1\\u0A05-\\u0A0A\\u0A0F\\u0A10\\u0A13-\\u0A28\\u0A2A-\\u0A30\\u0A32\\u0A33\\u0A35\\u0A36\\u0A38\\u0A39\\u0A59-\\u0A5C\\u0A5E\\u0A72-\\u0A74\\u0A85-\\u0A8D\\u0A8F-\\u0A91\\u0A93-\\u0AA8\\u0AAA-\\u0AB0\\u0AB2\\u0AB3\\u0AB5-\\u0AB9\\u0ABD\\u0AD0\\u0AE0\\u0AE1\\u0B05-\\u0B0C\\u0B0F\\u0B10\\u0B13-\\u0B28\\u0B2A-\\u0B30\\u0B32\\u0B33\\u0B35-\\u0B39\\u0B3D\\u0B5C\\u0B5D\\u0B5F-\\u0B61\\u0B71\\u0B83\\u0B85-\\u0B8A\\u0B8E-\\u0B90\\u0B92-\\u0B95\\u0B99\\u0B9A\\u0B9C\\u0B9E\\u0B9F\\u0BA3\\u0BA4\\u0BA8-\\u0BAA\\u0BAE-\\u0BB9\\u0BD0\\u0C05-\\u0C0C\\u0C0E-\\u0C10\\u0C12-\\u0C28\\u0C2A-\\u0C33\\u0C35-\\u0C39\\u0C3D\\u0C58\\u0C59\\u0C60\\u0C61\\u0C85-\\u0C8C\\u0C8E-\\u0C90\\u0C92-\\u0CA8\\u0CAA-\\u0CB3\\u0CB5-\\u0CB9\\u0CBD\\u0CDE\\u0CE0\\u0CE1\\u0CF1\\u0CF2\\u0D05-\\u0D0C\\u0D0E-\\u0D10\\u0D12-\\u0D3A\\u0D3D\\u0D4E\\u0D60\\u0D61\\u0D7A-\\u0D7F\\u0D85-\\u0D96\\u0D9A-\\u0DB1\\u0DB3-\\u0DBB\\u0DBD\\u0DC0-\\u0DC6\\u0E01-\\u0E30\\u0E32\\u0E33\\u0E40-\\u0E46\\u0E81\\u0E82\\u0E84\\u0E87\\u0E88\\u0E8A\\u0E8D\\u0E94-\\u0E97\\u0E99-\\u0E9F\\u0EA1-\\u0EA3\\u0EA5\\u0EA7\\u0EAA\\u0EAB\\u0EAD-\\u0EB0\\u0EB2\\u0EB3\\u0EBD\\u0EC0-\\u0EC4\\u0EC6\\u0EDC-\\u0EDF\\u0F00\\u0F40-\\u0F47\\u0F49-\\u0F6C\\u0F88-\\u0F8C\\u1000-\\u102A\\u103F\\u1050-\\u1055\\u105A-\\u105D\\u1061\\u1065\\u1066\\u106E-\\u1070\\u1075-\\u1081\\u108E\\u10A0-\\u10C5\\u10C7\\u10CD\\u10D0-\\u10FA\\u10FC-\\u1248\\u124A-\\u124D\\u1250-\\u1256\\u1258\\u125A-\\u125D\\u1260-\\u1288\\u128A-\\u128D\\u1290-\\u12B0\\u12B2-\\u12B5\\u12B8-\\u12BE\\u12C0\\u12C2-\\u12C5\\u12C8-\\u12D6\\u12D8-\\u1310\\u1312-\\u1315\\u1318-\\u135A\\u1380-\\u138F\\u13A0-\\u13F4\\u1401-\\u166C\\u166F-\\u167F\\u1681-\\u169A\\u16A0-\\u16EA\\u16EE-\\u16F0\\u1700-\\u170C\\u170E-\\u1711\\u1720-\\u1731\\u1740-\\u1751\\u1760-\\u176C\\u176E-\\u1770\\u1780-\\u17B3\\u17D7\\u17DC\\u1820-\\u1877\\u1880-\\u18A8\\u18AA\\u18B0-\\u18F5\\u1900-\\u191C\\u1950-\\u196D\\u1970-\\u1974\\u1980-\\u19AB\\u19C1-\\u19C7\\u1A00-\\u1A16\\u1A20-\\u1A54\\u1AA7\\u1B05-\\u1B33\\u1B45-\\u1B4B\\u1B83-\\u1BA0\\u1BAE\\u1BAF\\u1BBA-\\u1BE5\\u1C00-\\u1C23\\u1C4D-\\u1C4F\\u1C5A-\\u1C7D\\u1CE9-\\u1CEC\\u1CEE-\\u1CF1\\u1CF5\\u1CF6\\u1D00-\\u1DBF\\u1E00-\\u1F15\\u1F18-\\u1F1D\\u1F20-\\u1F45\\u1F48-\\u1F4D\\u1F50-\\u1F57\\u1F59\\u1F5B\\u1F5D\\u1F5F-\\u1F7D\\u1F80-\\u1FB4\\u1FB6-\\u1FBC\\u1FBE\\u1FC2-\\u1FC4\\u1FC6-\\u1FCC\\u1FD0-\\u1FD3\\u1FD6-\\u1FDB\\u1FE0-\\u1FEC\\u1FF2-\\u1FF4\\u1FF6-\\u1FFC\\u2071\\u207F\\u2090-\\u209C\\u2102\\u2107\\u210A-\\u2113\\u2115\\u2119-\\u211D\\u2124\\u2126\\u2128\\u212A-\\u212D\\u212F-\\u2139\\u213C-\\u213F\\u2145-\\u2149\\u214E\\u2160-\\u2188\\u2C00-\\u2C2E\\u2C30-\\u2C5E\\u2C60-\\u2CE4\\u2CEB-\\u2CEE\\u2CF2\\u2CF3\\u2D00-\\u2D25\\u2D27\\u2D2D\\u2D30-\\u2D67\\u2D6F\\u2D80-\\u2D96\\u2DA0-\\u2DA6\\u2DA8-\\u2DAE\\u2DB0-\\u2DB6\\u2DB8-\\u2DBE\\u2DC0-\\u2DC6\\u2DC8-\\u2DCE\\u2DD0-\\u2DD6\\u2DD8-\\u2DDE\\u2E2F\\u3005-\\u3007\\u3021-\\u3029\\u3031-\\u3035\\u3038-\\u303C\\u3041-\\u3096\\u309D-\\u309F\\u30A1-\\u30FA\\u30FC-\\u30FF\\u3105-\\u312D\\u3131-\\u318E\\u31A0-\\u31BA\\u31F0-\\u31FF\\u3400-\\u4DB5\\u4E00-\\u9FCC\\uA000-\\uA48C\\uA4D0-\\uA4FD\\uA500-\\uA60C\\uA610-\\uA61F\\uA62A\\uA62B\\uA640-\\uA66E\\uA67F-\\uA697\\uA6A0-\\uA6EF\\uA717-\\uA71F\\uA722-\\uA788\\uA78B-\\uA78E\\uA790-\\uA793\\uA7A0-\\uA7AA\\uA7F8-\\uA801\\uA803-\\uA805\\uA807-\\uA80A\\uA80C-\\uA822\\uA840-\\uA873\\uA882-\\uA8B3\\uA8F2-\\uA8F7\\uA8FB\\uA90A-\\uA925\\uA930-\\uA946\\uA960-\\uA97C\\uA984-\\uA9B2\\uA9CF\\uAA00-\\uAA28\\uAA40-\\uAA42\\uAA44-\\uAA4B\\uAA60-\\uAA76\\uAA7A\\uAA80-\\uAAAF\\uAAB1\\uAAB5\\uAAB6\\uAAB9-\\uAABD\\uAAC0\\uAAC2\\uAADB-\\uAADD\\uAAE0-\\uAAEA\\uAAF2-\\uAAF4\\uAB01-\\uAB06\\uAB09-\\uAB0E\\uAB11-\\uAB16\\uAB20-\\uAB26\\uAB28-\\uAB2E\\uABC0-\\uABE2\\uAC00-\\uD7A3\\uD7B0-\\uD7C6\\uD7CB-\\uD7FB\\uF900-\\uFA6D\\uFA70-\\uFAD9\\uFB00-\\uFB06\\uFB13-\\uFB17\\uFB1D\\uFB1F-\\uFB28\\uFB2A-\\uFB36\\uFB38-\\uFB3C\\uFB3E\\uFB40\\uFB41\\uFB43\\uFB44\\uFB46-\\uFBB1\\uFBD3-\\uFD3D\\uFD50-\\uFD8F\\uFD92-\\uFDC7\\uFDF0-\\uFDFB\\uFE70-\\uFE74\\uFE76-\\uFEFC\\uFF21-\\uFF3A\\uFF41-\\uFF5A\\uFF66-\\uFFBE\\uFFC2-\\uFFC7\\uFFCA-\\uFFCF\\uFFD2-\\uFFD7\\uFFDA-\\uFFDC"};function C(t,e){var u=Object.keys(t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(t);e&&(a=a.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),u.push.apply(u,a)}return u}function B(t){for(var e=1;e<arguments.length;e++){var u=null!=arguments[e]?arguments[e]:{};e%2?C(Object(u),!0).forEach((function(e){E(t,e,u[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(u)):C(Object(u)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(u,e))}))}return t}function E(t,e,u){return e in t?Object.defineProperty(t,e,{value:u,enumerable:!0,configurable:!0,writable:!0}):t[e]=u,t}function b(t){return t.replace(/<(?:.|\n)*?>/gm,"")}function y(t){return"".concat(t.name.replace(/ /g,"")," ").concat(t.username)}function v(t){return t.map((function(t){let e="";if(null==t.username)return t;e=t.name,t.count&&!t.mentionsDisabled&&(e+=" (".concat(t.count,")"));const u=t.avatar_url||t.username.charAt(0).toUpperCase(),a="Group"===t.type?"rect-avatar":"",i='<img src="'.concat(t.avatar_url,'" alt="').concat(t.username,'" class="avatar ').concat(a,' avatar-inline center s26"/>'),n='<div class="avatar '.concat(a,' center avatar-inline s26">').concat(u,"</div>"),s=t.mentionsDisabled?Object(D.W)("notifications-off","s16 vertical-align-middle gl-ml-2"):"";return{username:t.username,avatarTag:1===u.length?n:i,title:b(e),search:b(y(t)),icon:s,availability:null==t?void 0:t.availability}}))}const j={emojis:!0,members:!0,issues:!0,mergeRequests:!0,epics:!0,milestones:!0,labels:!0,snippets:!0,vulnerabilities:!0};class w{constructor(){let t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{};this.dataSources=t,this.cachedData={},this.isLoadingData={},this.previousQuery=""}setup(t){let e=arguments.length>1&&void 0!==arguments[1]?arguments[1]:j;this.input=t||o()(".js-gfm-input"),this.enableMap=e,this.setupLifecycle()}setupLifecycle(){var t=this;this.input.each((function(e,u){const a=o()(u);a.hasClass("js-gfm-input-initialized")||(a.off("focus.setupAtWho").on("focus.setupAtWho",t.setupAtWho.bind(t,a)),a.on("change.atwho",(function(){return u.dispatchEvent(new Event("input"))})),a.on("inserted-commands.atwho",a.trigger.bind(a,"keyup")),a.on("clear-commands-cache.atwho",(function(){return t.clearCache()})),a.addClass("js-gfm-input-initialized"))}))}setupAtWho(t){this.enableMap.emojis&&this.setupEmoji(t),this.enableMap.members&&this.setupMembers(t),this.enableMap.issues&&this.setupIssues(t),this.enableMap.milestones&&this.setupMilestones(t),this.enableMap.mergeRequests&&this.setupMergeRequests(t),this.enableMap.labels&&this.setupLabels(t),this.enableMap.snippets&&this.setupSnippets(t),t.filter('[data-supports-quick-actions="true"]').atwho({at:"/",alias:"commands",searchKey:"search",limit:100,skipSpecialCharacterTest:!0,skipMarkdownCharacterTest:!0,data:w.defaultLoadingData,displayTpl(t){const e=[];if(w.isLoading(t))return w.Loading.template;let u='<li class="<%- className %>"><span class="name">/${name}</span>';return t.aliases.length>0&&(u+=' <small class="aliases">(or /<%- aliases.join(", /") %>)</small>'),t.params.length>0&&(u+=' <small class="params"><%- params.join(" ") %></small>'),t.warning&&t.icon&&"confidential"===t.icon?u+='<small class="description gl-display-flex gl-align-items-center">'.concat(Object(D.W)("eye-slash","s16 gl-mr-2"),"<em><%- warning %></em></small>"):t.warning?u+='<small class="description"><em><%- warning %></em></small>':""!==t.description&&(u+='<small class="description"><em><%- description %></em></small>'),u+="</li>",t.warning&&e.push("has-warning"),i()(u)(B(B({},t),{},{className:e.join(" ")}))},insertTpl(t){let e="/${name} ",u=null;return t.params.length>0&&([[u]]=t.params,/^[@%~]/.test(u)&&(e+="<%- referencePrefix %>")),i()(e,{interpolate:/<%=([\s\S]+?)%>/g})({referencePrefix:u})},suffix:"",callbacks:B(B({},this.getDefaultCallbacks()),{},{beforeSave:t=>w.isLoading(t)?t:o.a.map(t,(function(t){let e=t.name;return t.aliases.length>0&&(e="".concat(e," ").concat(t.aliases.join(" "))),{name:t.name,aliases:t.aliases,params:t.params,description:t.description,warning:t.warning,icon:t.icon,search:e}})),matcher(t,e){const u=/(?:^|\n)\/([A-Za-z_]*)$/gi.exec(e);return u?u[1]:null}})})}setupEmoji(t){const e=this.fetchData.bind(this);t.atwho({at:":",displayTpl:w.Emoji.templateFunction,insertTpl:w.Emoji.insertTemplateFunction,skipSpecialCharacterTest:!0,data:w.defaultLoadingData,callbacks:B(B({},this.getDefaultCallbacks()),{},{matcher(t,e){const u=new RegExp("(?:[^".concat(f.unicodeLetters,"0-9:]|\n|^):([^:]*)$"),"gi").exec(e);return u&&u.length?u[1]:null},filter(t,u){return w.isLoading(u)?(e(this.$inputor,this.at),u):w.Emoji.filter(t)},sorter(t,e){return this.setting.highlightFirst=this.setting.alwaysHighlightFirst||t.length>0,w.isLoading(e)?(this.setting.highlightFirst=!1,e):0===t.length?e:w.Emoji.sorter(e)}})})}setupMembers(t){const e=this.fetchData.bind(this),u={ASSIGN:"/assign",UNASSIGN:"/unassign",ASSIGN_REVIEWER:"/assign_reviewer",UNASSIGN_REVIEWER:"/unassign_reviewer",REASSIGN:"/reassign",CC:"/cc"};let a=[],i=[],n="";t.atwho({at:"@",alias:"users",displayTpl(t){let e=w.Loading.template;const{avatarTag:u,username:a,title:i,icon:n,availability:s}=t;return null!=a&&(e=w.Members.templateFunction({avatarTag:u,username:a,title:i,icon:n,availabilityStatus:s&&Object(d.a)(s)?'<span class="gl-text-gray-500"> '.concat(Object(h.e)("UserAvailability|(Busy)"),"</span>"):""})),e},insertTpl:"${atwho-at}${username}",limit:10,searchKey:"search",alwaysHighlightFirst:!0,skipSpecialCharacterTest:!0,data:w.defaultLoadingData,callbacks:B(B({},this.getDefaultCallbacks()),{},{beforeSave:v,matcher(t,e){var s,r,l,c,o,p;const A=e.split(/\n+/g).pop().split(w.regexSubtext);n=A.find((function(t){return Object.values(u).includes(t)?t:null})),a=(null===(s=F.a.singleton)||void 0===s?void 0:null===(r=s.store)||void 0===r?void 0:null===(l=r.assignees)||void 0===l?void 0:l.map(y))||[],i=(null===(c=F.a.singleton)||void 0===c?void 0:null===(o=c.store)||void 0===o?void 0:null===(p=o.reviewers)||void 0===p?void 0:p.map(y))||[];const h=w.defaultMatcher(t,e,this.app.controllers);return h&&h.length?h[1]:null},filter(t,s,r){return w.isLoading(s)?(e(this.$inputor,this.at),s):s===w.defaultLoadingData?o.a.fn.atwho.default.callbacks.filter(t,s,r):n===u.ASSIGN?s.filter((function(t){return!a.includes(t.search)})):n===u.UNASSIGN?s.filter((function(t){return a.includes(t.search)})):n===u.ASSIGN_REVIEWER?s.filter((function(t){return!i.includes(t.search)})):n===u.UNASSIGN_REVIEWER?s.filter((function(t){return i.includes(t.search)})):s},sorter(t,e){return this.setting.highlightFirst=this.setting.alwaysHighlightFirst,w.isLoading(e)?(this.setting.highlightFirst=!1,e):t?w.Members.sort(t,e):e}})})}setupIssues(t){t.atwho({at:"#",alias:"issues",searchKey:"search",displayTpl(t){let e=w.Loading.template;return null!=t.title&&(e=w.Issues.templateFunction(t)),e},data:w.defaultLoadingData,insertTpl:w.Issues.insertTemplateFunction,skipSpecialCharacterTest:!0,callbacks:B(B({},this.getDefaultCallbacks()),{},{beforeSave:t=>o.a.map(t,(function(t){return null==t.title?t:{id:t.iid,title:b(t.title),reference:t.reference,search:"".concat(t.iid," ").concat(t.title)}}))})})}setupMilestones(t){t.atwho({at:"%",alias:"milestones",searchKey:"search",insertTpl:"${atwho-at}${title}",displayTpl(t){let e=w.Loading.template;return null!=t.title&&(e=w.Milestones.templateFunction(t.title,t.expired)),e},data:w.defaultLoadingData,callbacks:B(B({},this.getDefaultCallbacks()),{},{beforeSave(t){const e=o.a.map(t,(function(t){if(null==t.title)return t;const e=t.due_date?Object(m.U)(t.due_date):null,u=!!e&&Date.now()>e.getTime();return{id:t.iid,title:b(t.title),search:t.title,expired:u,dueDate:e}}));return"object"==typeof e[0]?e.sort((function(t,e){return t.expired?1:e.expired?-1:t.dueDate?e.dueDate?t.dueDate-e.dueDate:-1:1})):e}})})}setupMergeRequests(t){t.atwho({at:"!",alias:"mergerequests",searchKey:"search",displayTpl(t){let e=w.Loading.template;return null!=t.title&&(e=w.Issues.templateFunction(t)),e},data:w.defaultLoadingData,insertTpl:w.Issues.insertTemplateFunction,skipSpecialCharacterTest:!0,callbacks:B(B({},this.getDefaultCallbacks()),{},{beforeSave:t=>o.a.map(t,(function(t){return null==t.title?t:{id:t.iid,title:b(t.title),reference:t.reference,search:"".concat(t.iid," ").concat(t.title)}}))})})}setupLabels(t){const e=this,u=this.fetchData.bind(this),a="/label",i="/unlabel",n="/relabel";let s="";t.atwho({at:"~",alias:"labels",searchKey:"search",data:w.defaultLoadingData,displayTpl(t){let e=w.Labels.templateFunction(t.color,t.title);return w.isLoading(t)&&(e=w.Loading.template),e},insertTpl:"${atwho-at}${title}",limit:20,callbacks:B(B({},this.getDefaultCallbacks()),{},{beforeSave:t=>w.isLoading(t)?t:o.a.map(t,(function(t){return{title:b(t.title),color:t.color,search:t.title,set:t.set}})),matcher(t,r){const l=r.split(/\n+/g).pop().split(w.regexSubtext);s=l.find((function(t){return t===a||t===n||t===i?t:null}));const c=e.cachedData[t];if(c){if(!r.includes(t))return null;const e=r.split(t).pop();if(c.find((function(t){return t.title.startsWith(e)})))return e}else u(this.$inputor,this.at);const o=w.defaultMatcher(t,r,this.app.controllers);return o&&o.length?o[1]:null},filter(t,e,n){return w.isLoading(e)?(u(this.$inputor,this.at),e):e===w.defaultLoadingData?o.a.fn.atwho.default.callbacks.filter(t,e,n):s===a?e.filter((function(t){return!t.set})):s===i?e.filter((function(t){return t.set})):e}})})}setupSnippets(t){t.atwho({at:"$",alias:"snippets",searchKey:"search",displayTpl(t){let e=w.Loading.template;return null!=t.title&&(e=w.Issues.templateFunction(t)),e},data:w.defaultLoadingData,insertTpl:"${atwho-at}${id}",callbacks:B(B({},this.getDefaultCallbacks()),{},{beforeSave:t=>o.a.map(t,(function(t){return null==t.title?t:{id:t.id,title:b(t.title),search:"".concat(t.id," ").concat(t.title)}}))})})}getDefaultCallbacks(){const t=this;return{sorter(t,e,u){return this.setting.highlightFirst=this.setting.alwaysHighlightFirst||t.length>0,w.isLoading(e)?(this.setting.highlightFirst=!1,e):o.a.fn.atwho.default.callbacks.sorter(t,e,u)},filter(e,u,a){return w.isLoading(u)?(t.fetchData(this.$inputor,this.at),u):w.isTypeWithBackendFiltering(this.at)&&t.previousQuery!==e?(t.fetchData(this.$inputor,this.at,e),t.previousQuery=e,u):o.a.fn.atwho.default.callbacks.filter(e,u,a)},beforeInsert(t){let e=t.substring(1);const u=t.charAt();if(t&&!this.setting.skipSpecialCharacterTest){const t="~"===u?/\W|^\d+$/:/\W/;e&&t.test(e)&&(e='"'.concat(e,'"'))}return this.setting.skipMarkdownCharacterTest||(e=e.replace(/(~~|`|\*)/g,"\\$1").replace(/(\b)(_+)/g,"$1\\$2").replace(/(_+)(\b)/g,"\\$1$2")),"".concat(u).concat(e)},matcher(t,e){const u=w.defaultMatcher(t,e,this.app.controllers);return u?u[1]:null},highlighter(t,e){if(!e)return t;const u=e.replace(/[.+]/,"\\$&"),a=new RegExp(">\\s*([^<]*?)(".concat(u,")([^<]*)\\s*<"),"ig");return t.replace(a,(function(t,e,u,a){return"> ".concat(e,"<strong>").concat(u,"</strong>").concat(a," <")}))}}}fetchData(t,e,u){var a=this;if(this.isLoadingData[e])return;this.isLoadingData[e]=!0;const i=this.dataSources[w.atTypeMap[e]];w.isTypeWithBackendFiltering(e)?A.a.get(i,{params:{search:u}}).then((function(u){let{data:i}=u;a.loadData(t,e,i)})).catch((function(){a.isLoadingData[e]=!1})):this.cachedData[e]?this.loadData(t,e,this.cachedData[e]):"emojis"===w.atTypeMap[e]?this.loadEmojiData(t,e).catch((function(){})):i?g.a.retrieve(i,!0).then((function(u){a.loadData(t,e,u)})).catch((function(){a.isLoadingData[e]=!1})):this.isLoadingData[e]=!1}loadData(t,e,u){return this.isLoadingData[e]=!1,this.cachedData[e]=u,t.atwho("load",e,u),t.trigger("keyup")}async loadEmojiData(t,e){await p.initEmojiMap(),this.loadData(t,e,["loaded"]),w.glEmojiTag=p.glEmojiTag}clearCache(){this.cachedData={}}destroy(){this.input.each((function(t,e){o()(e).atwho("destroy")}))}static isLoading(t){let e=t;t&&t.length>0&&([e]=t);const u=w.defaultLoadingData[0];return e&&(e===u||e.name===u)}static defaultMatcher(t,e,u){const a=Object.keys(u).join("|").replace(/[$]/,"\\$&").replace(/([[\]:])/g,"\\$1"),i=Object.keys(u).join(""),n=e.split(w.regexSubtext).pop(),s=t.replace(/[-[\]/{}()*+?.\\^$|]/g,"\\$&"),r=decodeURI("%C3%80"),l=decodeURI("%C3%BF");return new RegExp("^(?:\\B|[^a-zA-Z0-9_`".concat(i,"]|\\s)").concat(s,"(?!").concat(a,")((?:[A-Za-z").concat(r,"-").concat(l,"0-9_'.+-:]|[^\\x00-\\x7a])*)$"),"gi").exec(n)}}w.regexSubtext=new RegExp(/\s+/g),w.defaultLoadingData=["loading"],w.atTypeMap={":":"emojis","@":"members","#":"issues","!":"mergeRequests","&":"epics","~":"labels","%":"milestones","/":"commands","[vulnerability:":"vulnerabilities",$:"snippets"},w.typesWithBackendFiltering=["vulnerabilities"],w.isTypeWithBackendFiltering=function(t){return w.typesWithBackendFiltering.includes(w.atTypeMap[t])},w.glEmojiTag=null,w.Emoji={insertTemplateFunction:t=>":".concat(t.emoji.name,":"),templateFunction(t){if(w.isLoading(t))return w.Loading.template;const e=l()(t.fieldValue);return w.glEmojiTag?"<li>".concat(e," ").concat(w.glEmojiTag(t.emoji.name),"</li>"):"<li>".concat(e,"</li>")},filter:t=>0===t.length?Object.values(p.getAllEmoji()).map((function(t){return{emoji:t,fieldValue:t.name}})).slice(0,20):p.searchEmoji(t),sorter:t=>p.sortEmoji(t)},w.Members={templateFunction(t){let{avatarTag:e,username:u,title:a,icon:i,availabilityStatus:n}=t;return"<li>".concat(e," ").concat(u," <small>").concat(l()(a)).concat(n,"</small> ").concat(i,"</li>")},nameOrUsernameStartsWith:(t,e)=>t.search.split(" ").some((function(t){return t.toLowerCase().startsWith(e)})),nameOrUsernameIncludes:(t,e)=>t.search.toLowerCase().includes(e),sort(t,e){const u=t.toLowerCase(),{nameOrUsernameStartsWith:a,nameOrUsernameIncludes:i}=w.Members;return s()(e.filter((function(t){return i(t,u)})),(function(t){return a(t,u)?-1:0}))}},w.Labels={templateFunction:(t,e)=>'<li><span class="dropdown-label-box" style="background: '.concat(l()(t),'"></span> ').concat(l()(e),"</li>")},w.Issues={insertTemplateFunction:t=>t.reference||"${atwho-at}${id}",templateFunction(t){let{id:e,title:u,reference:a}=t;return"<li><small>".concat(a||e,"</small> ").concat(l()(u),"</li>")}},w.Milestones={templateFunction:(t,e)=>"<li>".concat(e?Object(h.f)(Object(h.a)("%{milestone} (expired)"),{milestone:l()(t)}):l()(t),"</li>")},w.Loading={template:'<li style="pointer-events: none;"><span class="spinner align-text-bottom mr-1"></span>Loading...</li>'};e.a=w},uK44:function(t,e,u){"use strict";u("EmJ/"),u("6IOw"),u("OmYI")},unPA:function(t,e,u){"use strict";u("S26F"),u("orcL");var a=u("EmJ/"),i=u.n(a),n=(u("uK44"),u("Jn9D"));function s(t,e){var u=Object.keys(t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(t);e&&(a=a.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),u.push.apply(u,a)}return u}function r(t){for(var e=1;e<arguments.length;e++){var u=null!=arguments[e]?arguments[e]:{};e%2?s(Object(u),!0).forEach((function(e){l(t,e,u[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(u)):s(Object(u)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(u,e))}))}return t}function l(t,e,u){return e in t?Object.defineProperty(t,e,{value:u,enumerable:!0,configurable:!0,writable:!0}):t[e]=u,t}u.d(e,"b",(function(){return n.b}));e.a=class extends n.a{constructor(){super(...arguments),l(this,"setupAutoCompleteEpics",(function(t,e){t.atwho({at:"&",alias:"epics",searchKey:"search",displayTpl(t){let e=n.a.Loading.template;return null!=t.title&&(e=n.a.Issues.templateFunction(t)),e},data:n.a.defaultLoadingData,insertTpl:n.a.Issues.insertTemplateFunction,skipSpecialCharacterTest:!0,callbacks:r(r({},e),{},{beforeSave:t=>i.a.map(t,(function(t){return null==t.title?t:{id:t.iid,reference:t.reference,title:t.title.replace(/<(?:.|\n)*?>/gm,""),search:"".concat(t.iid," ").concat(t.title)}}))})})})),l(this,"setupAutoCompleteVulnerabilities",(function(t,e){t.atwho({at:"[vulnerability:",suffix:"]",alias:"vulnerabilities",searchKey:"search",displayTpl(t){let e=n.a.Loading.template;return null!=t.title&&(e=n.a.Issues.templateFunction(t)),e},data:n.a.defaultLoadingData,insertTpl:n.a.Issues.insertTemplateFunction,skipSpecialCharacterTest:!0,callbacks:r(r({},e),{},{beforeSave:t=>t.map((function(t){return null==t.title?t:{id:t.id,title:t.title.replace(/<(?:.|\n)*?>/gm,""),reference:t.reference,search:"".concat(t.id," ").concat(t.title)}}))})})}))}setupAtWho(t){this.enableMap.epics&&this.setupAutoCompleteEpics(t,this.getDefaultCallbacks()),this.enableMap.vulnerabilities&&this.setupAutoCompleteVulnerabilities(t,this.getDefaultCallbacks()),super.setupAtWho(t)}}}}]);
//# sourceMappingURL=commons-pages.groups.epics.index-pages.groups.epics.new-pages.groups.epics.show-pages.groups.iterati-d5792e22.de30b03b.chunk.js.map