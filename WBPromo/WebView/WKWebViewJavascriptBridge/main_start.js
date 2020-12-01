$WVmethods = {
    log: function log(str) {
        console.log(str)
    },
    appCallStack: {},
    setItem: function setItem(key, value) {
        function setupWKWebViewJavascriptBridge(callback) {
            if (window.WKWebViewJavascriptBridge) {
                return callback(WKWebViewJavascriptBridge);
            }
            if (window.WKWVJBCallbacks) {
                return window.WKWVJBCallbacks.push(callback);
            }
            window.WKWVJBCallbacks = [callback];
            window.webkit.messageHandlers.iOS_Native_InjectJavascript.postMessage(null)
        }
        setupWKWebViewJavascriptBridge(function(bridge) {
            bridge.callHandler('setItem', {
                'nameItem': key,
                'valueItem': value
            }, function(response) {
                console.log("Data saved!");
            });
        })
    },
    appCall: function appCall(method, arg1, arg2, cb) {
        let cbKey = Math.random().toString(36).substring(10);
        $WVmethods.appCallStack[cbKey] = cb;
        function setupWKWebViewJavascriptBridge(callback) {
            if (window.WKWebViewJavascriptBridge) {
                return callback(WKWebViewJavascriptBridge);
            }
            if (window.WKWVJBCallbacks) {
                return window.WKWVJBCallbacks.push(callback);
            }
            window.WKWVJBCallbacks = [callback];
            window.webkit.messageHandlers.iOS_Native_InjectJavascript.postMessage(null)
        }
        setupWKWebViewJavascriptBridge(function(bridge) {
            bridge.callHandler(method, {
                'nameItem': arg1
            }, function(response) {
                console.log("Response: ", response);
                $WVmethods.appCB(cbKey, response);
            });
        });
    },
    appCB: function appCB(cbKey, result) {
        if ($WVmethods.appCallStack[cbKey]) {
            $WVmethods.appCallStack[cbKey].call(this, result);
            delete $WVmethods.appCallStack[cbKey];
        }
    },
    getItem: function getItem(value) {
        return new Promise(function(resp) {
            $WVmethods.appCall('getItem', value, '', function(result) {
                resp(result)
            })
        })
    },
    filter: function filter(name, code='') {
        location.href = 'uniwebview://filter?name=' + name + '&code=' + encodeURIComponent(code)
    }
};
