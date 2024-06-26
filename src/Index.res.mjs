// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Utils from "./Utils.res.mjs";
import * as React from "react";
import * as Sonner from "sonner";
import * as Js_dict from "rescript/lib/es6/js_dict.js";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as React$1 from "@vercel/analytics/react";

function $$default() {
  var shortURLBase = process.env.NEXT_PUBLIC_URL;
  var match = React.useState(function () {
        return "";
      });
  var setUrl = match[1];
  var url = match[0];
  var match$1 = React.useState(function () {
        return "";
      });
  var setShortUrl = match$1[1];
  var shortUrl = match$1[0];
  var match$2 = React.useState(function () {
        return "Copy";
      });
  var setCopyText = match$2[1];
  var match$3 = React.useState(function () {
        return false;
      });
  var setLoading = match$3[1];
  var onInput = function (e) {
    var value = e.currentTarget.value;
    setUrl(function (param) {
          return value;
        });
  };
  var copy = function (param) {
    Utils.copy(shortUrl);
    setCopyText(function (param) {
          return "Success";
        });
    setTimeout((function () {
            setCopyText(function (param) {
                  return "Copy";
                });
          }), 1000);
  };
  var shorten = async function (param) {
    if (url === "") {
      return ;
    }
    setLoading(function (param) {
          return true;
        });
    try {
      var res = await fetch("/api/code", {
            method: "POST",
            body: Caml_option.some(Belt_Option.getExn(JSON.stringify({
                          url: url
                        })))
          });
      var resData = await res.json();
      if (!Array.isArray(resData) && (resData === null || typeof resData !== "object") && typeof resData !== "number" && typeof resData !== "string" && typeof resData !== "boolean" || !(typeof resData === "object" && !Array.isArray(resData))) {
        Sonner.toast("server error");
      } else {
        var data = Belt_Option.getWithDefault(Js_dict.get(resData, "data"), null);
        var code = Belt_Option.getExn(Js_dict.get(resData, "code"));
        var msg = Belt_Option.getExn(Js_dict.get(resData, "msg"));
        var exit = 0;
        if (!Array.isArray(code) && (code === null || typeof code !== "object") && typeof code !== "number" && typeof code !== "string" && typeof code !== "boolean" || !(typeof code === "number" && !(!Array.isArray(msg) && (msg === null || typeof msg !== "object") && typeof msg !== "number" && typeof msg !== "string" && typeof msg !== "boolean" || typeof msg !== "string"))) {
          exit = 1;
        } else if (!Array.isArray(data) && (data === null || typeof data !== "object") && typeof data !== "number" && typeof data !== "string" && typeof data !== "boolean") {
          if (code === 2) {
            Sonner.toast(msg);
          } else {
            Sonner.toast("server error");
          }
        } else if (typeof data === "string") {
          exit = 1;
        } else {
          Sonner.toast("server error");
        }
        if (exit === 1) {
          if (!Array.isArray(data) && (data === null || typeof data !== "object") && typeof data !== "number" && typeof data !== "string" && typeof data !== "boolean" || typeof data !== "string") {
            Sonner.toast("server error");
          } else {
            setShortUrl(function (param) {
                  return shortURLBase + "/s/" + data;
                });
          }
        }
        
      }
    }
    catch (exn){
      Sonner.toast("server error");
    }
    return setLoading(function (param) {
                return false;
              });
  };
  var handleClick = function (param) {
    shorten();
  };
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsx(Sonner.Toaster, {
                      position: "top-center"
                    }),
                JsxRuntime.jsxs("div", {
                      children: [
                        JsxRuntime.jsx("h3", {
                              children: "Shorten your link",
                              className: "text-2xl font-semibold whitespace-nowrap leading-none tracking-tight"
                            }),
                        JsxRuntime.jsx("p", {
                              children: "Paste a link to shorten it and share it with others.",
                              className: "text-sm text-muted-foreground"
                            })
                      ],
                      className: "flex flex-col space-y-1.5 p-6"
                    }),
                JsxRuntime.jsxs("div", {
                      children: [
                        JsxRuntime.jsxs("div", {
                              children: [
                                JsxRuntime.jsx("input", {
                                      className: "flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 w-[300px] flex-1",
                                      id: "link",
                                      placeholder: "Enter a URL",
                                      value: url,
                                      onInput: onInput
                                    }),
                                JsxRuntime.jsx("button", {
                                      children: "Shorten",
                                      className: "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-primary text-primary-foreground hover:opacity-90 h-10 px-4 py-2",
                                      disabled: match$3[0],
                                      onClick: handleClick
                                    })
                              ],
                              className: "flex flex-row items-center space-x-4"
                            }),
                        JsxRuntime.jsxs("div", {
                              children: [
                                JsxRuntime.jsx("input", {
                                      className: "flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 w-[300px] flex-1",
                                      id: "shortened",
                                      placeholder: "shorten link",
                                      readOnly: true,
                                      value: shortUrl
                                    }),
                                JsxRuntime.jsx("button", {
                                      children: match$2[0],
                                      className: "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-primary text-primary-foreground hover:opacity-90 h-10 px-4 py-2",
                                      onClick: copy
                                    })
                              ],
                              className: "flex flex-row items-center space-x-2"
                            })
                      ],
                      className: "p-6 space-y-4"
                    }),
                JsxRuntime.jsx(React$1.Analytics, {})
              ],
              className: "rounded-lg my-20 mx-auto border bg-card text-card-foreground shadow-sm w-full max-w-lg"
            });
}

export {
  $$default as default,
}
/* Utils Not a pure module */
