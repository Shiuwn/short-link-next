// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Caml_int32 from "rescript/lib/es6/caml_int32.js";

function copy(text) {
  var el = document.createElement("textarea");
  el.value = text;
  var body = document.body;
  body.appendChild(el);
  el.select();
  document.execCommand("copy");
  el.remove();
}

var index_map = new Map();

var base_char = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

var base_len = base_char.length;

function parse_index(base) {
  var len = base_char.length;
  var b = base;
  var code = "";
  for(var _for = 0; _for <= 3; ++_for){
    var index = Caml_int32.mod_(b, len);
    code = code + base_char[index];
    b = Caml_int32.div(b, len);
  }
  return code;
}

function seek(base) {
  var index = -1;
  if (base <= 0 || base >= (base_len - 1 | 0)) {
    return -1;
  }
  var $$break = false;
  for(var i = base_len - 1 | 0; i >= 0; --i){
    if (!$$break) {
      if (index >= 0) {
        $$break = true;
      } else {
        var match = index_map.get(i);
        index = match !== undefined ? -1 : i;
      }
    }
    
  }
  return index;
}

function gen_code() {
  var base = Math.random() * Math.pow(base_len, 4) | 0;
  var match = index_map.get(base);
  if (match === undefined) {
    return parse_index(base);
  }
  var index = seek(base);
  if (index < 0) {
    return "";
  } else {
    return parse_index(index);
  }
}

function log_err(err) {
  console.log(err);
}

function now() {
  return (Date.now() | 0) / 1000 | 0;
}

var limit_count = 4;

export {
  copy ,
  index_map ,
  base_char ,
  limit_count ,
  base_len ,
  parse_index ,
  seek ,
  gen_code ,
  log_err ,
  now ,
}
/* index_map Not a pure module */
