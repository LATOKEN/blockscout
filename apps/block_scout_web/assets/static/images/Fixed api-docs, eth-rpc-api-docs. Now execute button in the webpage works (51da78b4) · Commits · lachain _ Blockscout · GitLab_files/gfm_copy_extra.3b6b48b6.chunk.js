(this.webpackJsonp=this.webpackJsonp||[]).push([[238],{CtRs:function(t,e,n){"use strict";n.r(e);var r=n("At76"),a=n("mffi");function o(t,e){var n=Object.keys(t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(t);e&&(r=r.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),n.push.apply(n,r)}return n}function s(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{};e%2?o(Object(n),!0).forEach((function(e){c(t,e,n[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(n,e))}))}return t}function c(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}const i=a.a.filter((function(t){return"node"===t.type})).reduce((function(t,e){let{name:n,schema:r}=e;return s(s({},t),{},{[n]:r})}),{}),l=a.a.filter((function(t){return"mark"===t.type})).reduce((function(t,e){let{name:n,schema:r}=e;return s(s({},t),{},{[n]:r})}),{});e.default=new r.Schema({nodes:i,marks:l})},LHPR:function(t,e,n){"use strict";n.r(e);var r=n("6GGm"),a=n("mffi");function o(t,e){var n=Object.keys(t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(t);e&&(r=r.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),n.push.apply(n,r)}return n}function s(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{};e%2?o(Object(n),!0).forEach((function(e){c(t,e,n[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(n,e))}))}return t}function c(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}const i=a.a.filter((function(t){return"node"===t.type})).reduce((function(t,e){let{name:n,toMarkdown:r}=e;return s(s({},t),{},{[n]:r})}),{}),l=a.a.filter((function(t){return"mark"===t.type})).reduce((function(t,e){let{name:n,toMarkdown:r}=e;return s(s({},t),{},{[n]:r})}),{});e.default=new r.a(i,l)},mffi:function(t,e,n){"use strict";var r=n("6GGm"),a=n("d9wy");var o=n("Nc6o");var s=n("G3fq"),c=n.n(s);const i=51;function l(t,e){var n=Object.keys(t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(t);e&&(r=r.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),n.push.apply(n,r)}return n}function u(t){for(var e=1;e<arguments.length;e++){var n=null!=arguments[e]?arguments[e]:{};e%2?l(Object(n),!0).forEach((function(e){d(t,e,n[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(n)):l(Object(n)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(n,e))}))}return t}function d(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}class g extends o.c{constructor(){super(),this.mediaType="",this.extraElementAttrs={}}get name(){return this.mediaType}get schema(){var t=this;return{attrs:{src:{},alt:{default:null}},group:"block",draggable:!0,parseDOM:[{tag:".".concat(this.mediaType,"-container"),skip:!0},{tag:".".concat(this.mediaType,"-container p"),priority:i,ignore:!0},{tag:"".concat(this.mediaType,"[src]"),getAttrs:function(t){return{src:t.src,alt:t.dataset.title}}}],toDOM:function(e){return[t.mediaType,u({src:e.attrs.src,controls:!0,"data-setup":"{}","data-title":e.attrs.alt},t.extraElementAttrs)]}}}toMarkdown(t,e){r.b.nodes.image(t,e),t.closeBlock(e)}}n("l9AF"),n("orcL");const p="plaintext";var m=n("0DeP");class f extends o.c{get name(){return"table_row"}get schema(){return{content:"table_cell+",parseDOM:[{tag:"tr"}],toDOM:function(){return["tr",0]}}}toMarkdown(t,e){const n=[];return t.flushClose(1),t.write("| "),e.forEach((function(r,a,o){o&&t.write(" | ");const{length:s}=t.out;t.render(r,e,o),n.push(t.out.length-s)})),t.write(" |"),t.closeBlock(e),n}}const w="center";var b=n("/lV4");e.a=[new class extends o.c{get name(){return"doc"}get schema(){return{content:"block+"}}},new class extends o.c{get name(){return"paragraph"}get schema(){return{content:"inline*",group:"block",parseDOM:[{tag:"p"}],toDOM:function(){return["p",0]}}}toMarkdown(t,e){r.b.nodes.paragraph(t,e)}},new class extends o.c{get name(){return"text"}get schema(){return{group:"inline"}}toMarkdown(t,e){r.b.nodes.text(t,e)}},new class extends a.a{toMarkdown(t,e){e.childCount&&r.b.nodes.blockquote(t,e)}},new class extends a.e{get schema(){return{content:"text*",marks:"",group:"block",code:!0,defining:!0,attrs:{lang:{default:p}},parseDOM:[{tag:"pre.code.highlight",preserveWhitespace:"full",getAttrs:function(t){const e=t.getAttribute("lang");return e&&""!==e?{lang:e}:{}}},{tag:"span.katex-display",preserveWhitespace:"full",contentElement:'annotation[encoding="application/x-tex"]',attrs:{lang:"math"}},{tag:"svg.mermaid",preserveWhitespace:"full",contentElement:"text.source",attrs:{lang:"mermaid"}},{tag:".md-suggestion",skip:!0},{tag:".md-suggestion-header",ignore:!0},{tag:".md-suggestion-diff",preserveWhitespace:"full",getContent:function(t,e){return[...t.querySelectorAll(".line_content.new span")].map((function(t){return e.text(t.innerText)}))},attrs:{lang:"suggestion"}}],toDOM:function(t){return["pre",{class:"code highlight",lang:t.attrs.lang},["code",0]]}}}toMarkdown(t,e){if(!e.childCount)return;const{textContent:n,attrs:{lang:r}}=e;r===p&&n.match(/^```/gm)?t.wrapBlock("    ",null,e,(function(){return t.text(n,!1)})):(t.write("```"),r!==p&&t.write(r),t.ensureNewLine(),t.text(n,!1),t.ensureNewLine(),t.write("```"),t.closeBlock(e))}},new class extends a.f{toMarkdown(t){t.atBlank()||t.write("  \n")}},new class extends a.g{toMarkdown(t,e){e.childCount&&r.b.nodes.heading(t,e)}}({maxLevel:6}),new class extends a.h{toMarkdown(t,e){r.b.nodes.horizontal_rule(t,e)}},new class extends a.i{get schema(){return{attrs:{src:{},alt:{default:null},title:{default:null}},group:"inline",inline:!0,draggable:!0,parseDOM:[{tag:"a.no-attachment-icon",priority:i,skip:!0},{tag:"img[src]",getAttrs:function(t){const e=t.src;return{src:e&&e!==m.b?e:t.dataset.src||"",title:t.getAttribute("title"),alt:t.getAttribute("alt")}}}],toDOM:function(t){return["img",t.attrs]}}}toMarkdown(t,e){r.b.nodes.image(t,e)}},new class extends o.c{get name(){return"table"}get schema(){return{content:"table_head table_body",group:"block",isolating:!0,parseDOM:[{tag:"table"}],toDOM:function(){return["table",0]}}}toMarkdown(t,e){t.renderContent(e),t.closeBlock(e)}},new class extends o.c{get name(){return"table_head"}get schema(){return{content:"table_header_row",parseDOM:[{tag:"thead"}],toDOM:function(){return["thead",0]}}}toMarkdown(t,e){t.flushClose(1),t.renderContent(e),t.closeBlock(e)}},new class extends o.c{get name(){return"table_body"}get schema(){return{content:"table_row+",parseDOM:[{tag:"tbody"}],toDOM:function(){return["tbody",0]}}}toMarkdown(t,e){t.flushClose(1),t.renderContent(e),t.closeBlock(e)}},new class extends f{get name(){return"table_header_row"}get schema(){return{content:"table_cell+",parseDOM:[{tag:"thead tr",priority:i}],toDOM:function(){return["tr",0]}}}toMarkdown(t,e){const n=super.toMarkdown(t,e);t.flushClose(1),t.write("|"),e.forEach((function(e,r,a){a&&t.write("|"),t.write(e.attrs.align===w?":":"-"),t.write(t.repeat("-",n[a])),t.write(e.attrs.align===w||"right"===e.attrs.align?":":"-")})),t.write("|"),t.closeBlock(e)}},new f,new class extends o.c{get name(){return"table_cell"}get schema(){return{attrs:{header:{default:!1},align:{default:null}},content:"inline*",isolating:!0,parseDOM:[{tag:"td, th",getAttrs:function(t){return{header:"TH"===t.tagName,align:t.getAttribute("align")||t.style.textAlign}}}],toDOM:function(t){return[t.attrs.header?"th":"td",{align:t.attrs.align},0]}}}toMarkdown(t,e){t.renderInline(e)}},new class extends o.c{get name(){return"emoji"}get schema(){return{inline:!0,group:"inline",attrs:{name:{},title:{},moji:{}},parseDOM:[{tag:"gl-emoji",getAttrs:function(t){return{name:t.dataset.name,title:t.getAttribute("title"),moji:t.textContent}}}],toDOM:function(t){return["gl-emoji",{"data-name":t.attrs.name,title:t.attrs.title},t.attrs.moji]}}}toMarkdown(t,e){t.write(":".concat(e.attrs.name,":"))}},new class extends o.c{get name(){return"reference"}get schema(){return{inline:!0,group:"inline",atom:!0,attrs:{className:{},referenceType:{},originalText:{default:null},href:{},text:{}},parseDOM:[{tag:"a.gfm:not([data-link=true])",priority:i,getAttrs:function(t){return{className:t.className,referenceType:t.dataset.referenceType,originalText:t.dataset.original,href:t.getAttribute("href"),text:t.textContent}}}],toDOM:function(t){return["a",{class:t.attrs.className,href:t.attrs.href,"data-reference-type":t.attrs.referenceType,"data-original":t.attrs.originalText},t.attrs.text]}}}toMarkdown(t,e){t.write(e.attrs.originalText||e.attrs.text)}},new class extends o.c{get name(){return"table_of_contents"}get schema(){return{group:"block",atom:!0,parseDOM:[{tag:"ul.section-nav",priority:i},{tag:"p.table-of-contents",priority:i}],toDOM:function(){return["p",{class:"table-of-contents"},Object(b.a)("Table of Contents")]}}}toMarkdown(t,e){t.write("[[_TOC_]]"),t.closeBlock(e)}},new class extends g{constructor(){super(),this.mediaType="video",this.extraElementAttrs={width:"400"}}},new class extends g{constructor(){super(),this.mediaType="audio"}},new class extends a.c{toMarkdown(t,e){r.b.nodes.bullet_list(t,e)}},new class extends a.m{toMarkdown(t,e){t.renderList(e,"   ",(function(){return"1. "}))}},new class extends a.l{toMarkdown(t,e){r.b.nodes.list_item(t,e)}},new class extends o.c{get name(){return"description_list"}get schema(){return{content:"(description_term+ description_details+)+",group:"block",parseDOM:[{tag:"dl"}],toDOM:function(){return["dl",0]}}}toMarkdown(t,e){t.write("<dl>\n"),t.wrapBlock("  ",null,e,(function(){return t.renderContent(e)})),t.flushClose(1),t.ensureNewLine(),t.write("</dl>"),t.closeBlock(e)}},new class extends o.c{get name(){return"description_term"}get schema(){return{content:"text*",marks:"",defining:!0,parseDOM:[{tag:"dt"}],toDOM:function(){return["dt",0]}}}toMarkdown(t,e){t.flushClose(t.closed&&t.closed.type===e.type?1:2),t.write("<dt>"),t.text(e.textContent,!1),t.write("</dt>"),t.closeBlock(e)}},new class extends o.c{get name(){return"description_details"}get schema(){return{content:"text*",marks:"",defining:!0,parseDOM:[{tag:"dd"}],toDOM:function(){return["dd",0]}}}toMarkdown(t,e){t.flushClose(1),t.write("<dd>"),t.text(e.textContent,!1),t.write("</dd>"),t.closeBlock(e)}},new class extends o.c{get name(){return"task_list"}get schema(){return{group:"block",content:"(task_list_item|list_item)+",parseDOM:[{priority:i,tag:"ul.task-list"}],toDOM:function(){return["ul",{class:"task-list"},0]}}}toMarkdown(t,e){t.renderList(e,"  ",(function(){return"* "}))}},new class extends o.c{get name(){return"ordered_task_list"}get schema(){return{group:"block",content:"(task_list_item|list_item)+",parseDOM:[{priority:i,tag:"ol.task-list"}],toDOM:function(){return["ol",{class:"task-list"},0]}}}toMarkdown(t,e){t.renderList(e,"   ",(function(){return"1. "}))}},new class extends o.c{get name(){return"task_list_item"}get schema(){return{attrs:{done:{default:!1}},defining:!0,draggable:!1,content:"paragraph block*",parseDOM:[{priority:i,tag:"li.task-list-item",getAttrs:function(t){const e=t.querySelector("input[type=checkbox].task-list-item-checkbox");return{done:e&&e.checked}}}],toDOM:t=>["li",{class:"task-list-item"},["input",{type:"checkbox",class:"task-list-item-checkbox",checked:t.attrs.done}],["div",{class:"todo-content"},0]]}}toMarkdown(t,e){t.write("[".concat(e.attrs.done?"x":" ","] ")),t.renderContent(e)}},new class extends o.c{get name(){return"summary"}get schema(){return{content:"text*",marks:"",defining:!0,parseDOM:[{tag:"summary"}],toDOM:function(){return["summary",0]}}}toMarkdown(t,e){t.write("<summary>"),t.text(e.textContent,!1),t.write("</summary>"),t.closeBlock(e)}},new class extends o.c{get name(){return"details"}get schema(){return{content:"summary block*",group:"block",parseDOM:[{tag:"details"}],toDOM:function(){return["details",{open:!0,onclick:"return false",tabindex:"-1"},0]}}}toMarkdown(t,e){t.write("<details>\n"),t.renderContent(e),t.flushClose(1),t.ensureNewLine(),t.write("</details>"),t.closeBlock(e)}},new class extends a.b{get toMarkdown(){return r.b.marks.strong}},new class extends a.j{get toMarkdown(){return r.b.marks.em}},new class extends a.n{get toMarkdown(){return{open:"~~",close:"~~",mixable:!0,expelEnclosingWhitespace:!0}}},new class extends o.b{get name(){return"inline_diff"}get schema(){return{attrs:{addition:{default:!0}},parseDOM:[{tag:"span.idiff.addition",attrs:{addition:!0}},{tag:"span.idiff.deletion",attrs:{addition:!1}}],toDOM:function(t){return["span",{class:"idiff left right ".concat(t.attrs.addition?"addition":"deletion")},0]}}}get toMarkdown(){return{mixable:!0,open:(t,e)=>e.attrs.addition?"{+":"{-",close:(t,e)=>e.attrs.addition?"+}":"-}"}}},new class extends a.k{get toMarkdown(){return{mixable:!0,open(t,e,n,a){const o=r.b.marks.link.open(t,e,n,a);return"<"===o?"":o},close(t,e,n,a){const o=r.b.marks.link.close(t,e,n,a);return">"===o?"":o}}}},new class extends a.d{get toMarkdown(){return r.b.marks.code}},new class extends o.b{get name(){return"math"}get schema(){return{parseDOM:[{tag:"code.code.math[data-math-style=inline]",priority:i},{tag:"span.katex",contentElement:'annotation[encoding="application/x-tex"]'}],toDOM:function(){return["code",{class:"code math","data-math-style":"inline"},0]}}}get toMarkdown(){return{escape:!1,open:(t,e,n,a)=>"$".concat(r.b.marks.code.open(t,e,n,a)),close:(t,e,n,a)=>"".concat(r.b.marks.code.close(t,e,n,a),"$")}}},new class extends o.b{get name(){return"inline_html"}get schema(){return{excludes:"",attrs:{tag:{},title:{default:null}},parseDOM:[{tag:"sup, sub, kbd, q, samp, var",getAttrs:function(t){return{tag:t.nodeName.toLowerCase()}}},{tag:"abbr",getAttrs:function(t){return{tag:"abbr",title:t.getAttribute("title")}}}],toDOM:function(t){return[t.attrs.tag,{title:t.attrs.title},0]}}}get toMarkdown(){return{mixable:!0,open:(t,e)=>"<".concat(e.attrs.tag).concat(e.attrs.title?' title="'.concat(t.esc(c()(e.attrs.title)),'"'):"",">"),close:(t,e)=>"</".concat(e.attrs.tag,">")}}}]}}]);
//# sourceMappingURL=gfm_copy_extra.3b6b48b6.chunk.js.map