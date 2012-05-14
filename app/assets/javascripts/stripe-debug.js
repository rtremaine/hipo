(function(stripe) {
  function trim(str) {
    return str.replace(/^\s+|\s+$/g,"");
  }

  function stripSpacesAndDashes(str) {
    return str.replace(/\s+|-/g,"");
  }

  function reverse(str) {
    return str.split('').reverse().join('');
  }

  function luhnCheck(num) {
    if (num.match(/^[0-9]+$/) === null)
      return false;

    var reverseNum = reverse(num);
    var index;
    var sum = 0;
    var weight;
    for (index = 0; index < reverseNum.length; ++index) {
      weight = parseInt(reverseNum.charAt(index), 10);
      if (index % 2 != 0)
        weight *= 2;

      sum += (weight < 10) ? weight : weight - 9;
    }

    return (sum != 0 && sum % 10 == 0) 
  };

  var cardTypes = null;
  function setupCardTypes() {
    cardTypes = {};
    for (var i = 40; i <= 49; ++i) {
      cardTypes[i] = 'Visa';
    }
    
    for (var i = 50; i <= 59; ++i) {
      cardTypes[i] = 'MasterCard';
    }

    cardTypes[34] = cardTypes[37] = 'American Express';
    cardTypes[60] = cardTypes[62] = cardTypes[64] = cardTypes[65] = 'Discover';
    cardTypes[35] = 'JCB';
    cardTypes[30] = cardTypes[36] = cardTypes[38] = cardTypes[39] = 'Diners Club'
  };

  var transport = {};
  // Add JSON support if browser doesn't have it.
if (typeof window !== 'undefined' && !window['JSON']) {
  window['JSON'] = {};
}

(function () {
  if (typeof JSON.parse !== 'function') {
    JSON.parse = function (text, reviver) {
      var cx = new RegExp('[\\u0000\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]', "g");
      var j;

      function walk(holder, key) {
        var k, v, value = holder[key];
        if (value && typeof value === 'object') {
          for (k in value) {
            if (Object.hasOwnProperty.call(value, k)) {
              v = walk(value, k);
              if (v !== undefined) {
                value[k] = v;
              } else {
                delete value[k];
              }
            }
          }
        }
        return reviver.call(holder, key, value);
      }
      text = String(text);
      cx.lastIndex = 0;
      if (cx.test(text)) {
        text = text.replace(cx, function (a) {
          return '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
        });
      }
      if (/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@').replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']').replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {
        j = eval('(' + text + ')');
        return typeof reviver === 'function' ? walk({
          '': j
        }, '') : j;
      }
      throw new SyntaxError('JSON.parse');
    };
  }
}())

var createTransport = function(xd) {
  if (typeof xd === 'undefined') {
    var xd = {};
    var createXD = function(serializer) {
  if (typeof serializer === 'undefined') {
    var serializer = {};
    var createSerializer = function() {
  var serializer = {};
  serializer['serialize'] = function(obj, prefix) {
    var str = [];

    for(var prop in obj) {
      if (obj.hasOwnProperty(prop)) {
        var key = prefix ? prefix + "[" + prop + "]" : prop;
        var value = obj[prop];
        str.push(typeof value == "object" ?
        serializer['serialize'](value, key) :
        encodeURIComponent(key) + "=" + encodeURIComponent(value));
      }
    }
    return str.join("&");
  };

  serializer['deserialize'] = function(message) {
    var deserializedObject = {};
    var components = message.split('&');
    var componentLength = components.length;
    var subparts = null;
    var parts = null;

    for (var i = 0; i < componentLength; ++i) {
      parts = components[i].split('=');
      parts[0] = decodeURIComponent(parts[0]);
      parts[1] = decodeURIComponent(parts[1]);
      subparts = parts[0].match(/\[\w+\]/g);

      if (subparts === null) {
        deserializedObject[parts[0]] = parts[1];
      }
      else {
        var key = parts[0].substr(0, parts[0].indexOf('['))
        if (typeof deserializedObject[key] === 'undefined')
        deserializedObject[key] = {};
        var ref = deserializedObject[key];
        var subpartsLength = subparts.length;

        for (var j = 0; j < subpartsLength - 1; ++j) {
          key = subparts[j].substr(1, subparts[j].length - 2);
          if (typeof ref[key] === 'undefined')
          ref[key] = {};
          ref = ref[key];
        }
        var lastPart = subparts[subpartsLength - 1];
        key = lastPart.substr(1, lastPart.length - 2);
        ref[key] = parts[1];
      }
    }
    return deserializedObject;
  }
  return serializer;
}

if (typeof serializer !== 'undefined')
  serializer = createSerializer();
else
  exports['createSerializer'] = createSerializer;
  }

  var xd = {}
  xd['postMessage'] = function(message, targetOrigin, targetURL, target) {
    // It would make more sense to do this check on target than on 
    // window, but Firefox 2 does not let the parent window check the type
    // of the iframe's postMessage property
    if (typeof window === 'undefined')
      return;

    var serializedMessage = serializer['serialize'](message);
    if (typeof window['postMessage'] === 'undefined') 
      // We can't access target['location'] directly, so we have to hackily make
      // the URL what we know it to be here
      target['location']['href'] = targetURL + '#' + (+new Date) + (Math.floor(Math.random() * 1000)) + '&' + serializedMessage;
    else 
      target['postMessage'](serializedMessage, targetOrigin);
  },

  xd['receiveMessage'] = function(callback, sourceOrigin) {
    if (typeof window === 'undefined') 
      return;

    if (window['postMessage']) {
      attachedCallback = function(e) {
	      if (e.origin !== sourceOrigin)
          return false;
	      
	      callback(serializer['deserialize'](e['data']));
      }
      if (window['addEventListener']) {
	      window['addEventListener']('message', attachedCallback, false);
      }
      else {
	      window['attachEvent']('onmessage', attachedCallback);
      }
    }
    else {
      var lastHash = window.location.hash;
      var intervalId = setInterval(function() {
	      var hash = window.location.hash;
	      var re = /^#?\d+&/;
	      if (hash !== lastHash && re.test(hash)) {
          lastHash = hash;
          window.location.hash = '';
          callback(serializer['deserialize'](hash.replace(re, '')));
	      }
      }, 100);
    }
  }
  return xd;
}


if (typeof xd !== 'undefined') 
  xd = createXD();
else
  exports['createXD'] = createXD;
  }

  var tunnel = null;
  var pendingCallQueue = [];
  var messageCount = 0;
  var sentCalls = {};
  var timeouts = {};
  var initializedOnce = false;
  var stripeFrameId;

  var tunnelURL;
  function loadAPITunnel() {
    tunnel = null;

    var body = document.getElementsByTagName("body")[0];
    var tunnelIframe = document.createElement('iframe');
    stripeFrameId = 'stripeFrame' + (new Date().getTime());
    tunnelURL = transport['apiURL'] + '/js/v1/apitunnel.html';
    var url = tunnelURL + '#' + encodeURIComponent(window.location.href);
    tunnelIframe.setAttribute('src', url);
    tunnelIframe.setAttribute('name', stripeFrameId);
    tunnelIframe.setAttribute('id', stripeFrameId);
    tunnelIframe.setAttribute('frameborder', '0');
    tunnelIframe.setAttribute('scrolling', 'no');
    tunnelIframe.setAttribute('allowtransparency', 'true');
    tunnelIframe.setAttribute('width', 0);
    tunnelIframe.setAttribute('height', 0);
    tunnelIframe.setAttribute('style', 'position:absolute;top:0;left:0;width:0;height:0');

    var loadFunc = function() {
      tunnel = window.frames[stripeFrameId];
      consumeCallQueue();
    };

    // #IECOMPAT uses attachEvent
    if (tunnelIframe['attachEvent'])
      tunnelIframe.attachEvent("onload", loadFunc);
    else
      tunnelIframe.onload = loadFunc;
    
    body.appendChild(tunnelIframe);
  };

  function consumeCallQueue() {
    if (!tunnel)
      return;

    var pendingCount = pendingCallQueue.length;
    if (pendingCount > 0) {
      for (var i = 0; i < pendingCount; ++i) {
        var message = pendingCallQueue[i]['message'];
        var id = message['id'];

        sentCalls[id] = pendingCallQueue[i]['callback'];
        xd.postMessage(message, transport['apiURL'], tunnelURL, tunnel);

        timeouts[id] = window.setTimeout(function(id) {
          sentCalls[id](504, {'error' : {'message' : 'There was an error processing your card'}});
          delete sentCalls[id];
          delete timeouts[id];
        }, 60*1000, id)
      }

      pendingCallQueue = [];
    }
  }

  var transport = {};
  transport['apiURL'] = 'https://api.stripe.com';
  // Not sure how to test this without making it an interface method
  transport['onMessage'] = function(message) {
    var id = message['id'];
    var response = null;
    if (message['response'] === null || message['response'] === "")
      response = {'error' : {'message' : 'There was an error processing your card'}};
    else
      response = JSON.parse(message['response']);
    sentCalls[id](parseInt(message['status']), response);
    window.clearTimeout(timeouts[id])
    delete sentCalls[id];
    delete timeouts[id];
  }

  var assignedCallback = false;
  var initializeTransport = function() {
    loadAPITunnel();

    if (!assignedCallback) {
      xd['receiveMessage'](transport['onMessage'], transport['apiURL']);
      assignedCallback = true;
    }
  }

  transport['init'] = function() {
    if (stripeFrameId && document.getElementById(stripeFrameId))
      return;

    // Try our best to load the API Tunnel onload.  Worst case, it'll be loaded when
    // the first API call gets made
    if (typeof document !== 'undefined' && document && document.body)
      initializeTransport();
    else if (typeof window !== 'undefined' && window && !initializedOnce) {
      if (window.addEventListener)
        window.addEventListener('load', initializeTransport, false);
      else if (window.attachEvent)
        window.attachEvent('onload', initializeTransport);
    }

    initializedOnce = true;
  },

  transport['callAPI'] = function(httpMethod, url, params, key, callback) {
    if (httpMethod !== 'POST' && httpMethod !== 'GET' && httpMethod !== 'DELETE')
      throw 'You can only call the API with POST, GET or DELETE';

    transport['init']()

    var messageID = (messageCount++).toString();
    var url = '/v1/' + url;
    var message = {
      'id' : messageID,
      'method' : httpMethod,
      'url' : url,
      'params' : params,
      'key' : key
    };

    pendingCallQueue.push({
      'message' : message,
      'callback' : callback
    });

    consumeCallQueue();
  }

  return transport;
}

if (typeof transport !== 'undefined')
  transport = createTransport();
else
  exports['createTransport'] = createTransport;;

  stripe['transport'] = transport;

  stripe['validateCardNumber'] = function(num) {
    num = stripSpacesAndDashes(num);
    return num.length >= 10 && num.length <= 16 && luhnCheck(num);
  };

  stripe['cardType'] = function(num) {
    if (!cardTypes)
      setupCardTypes();

    var type = cardTypes[num.substr(0, 2)];
    return typeof type === 'undefined' ? 'Unknown' : type;
  }

  stripe['validateCVC'] = function(num) {
    num = trim(num);
    return (num.match(/^[0-9]+$/) !== null) && num.length >= 3 && num.length <= 4;
  };

  stripe['validateExpiry'] = function(expMonth, expYear) {
    expMonth = trim(expMonth);
    expYear = trim(expYear);
    var currentTime = new Date();
    return ((expMonth.match(/^[0-9]+$/) !== null) && (expYear.match(/^[0-9]+$/) !== null) && expYear > currentTime.getFullYear() || (expYear == currentTime.getFullYear() && expMonth >= currentTime.getMonth() + 1))
  };

  function assertPublishableKey() {
    if (!stripe['publishableKey'])
      throw "No Publishable API Key: Call Stripe.setPublishableKey to provide your key."
  }

  function convertParams(cardInfo) {
    var paramsToConvert = {'expMonth' : 'exp_month',
                           'expYear' : 'exp_year',
                           'addressLine1' : 'address_line_1',
                           'addressLine2' : 'address_line_2',
                           'addressZip' : 'address_zip',
                           'addressState' : 'address_state',
                           'addressCountry' : 'address_country'};

    for (convertibleParam in paramsToConvert) {
      if (paramsToConvert.hasOwnProperty(convertibleParam)) {
        if (cardInfo.hasOwnProperty(convertibleParam)) {
          cardInfo[paramsToConvert[convertibleParam]] = cardInfo[convertibleParam];
          delete cardInfo[convertibleParam];
        }
      }
    }
  }
  
  stripe['createToken'] = function(cardInfo, amount, callback) {
    if (typeof amount === 'function') {
      callback = amount;
      amount = 0;
    }
    assertPublishableKey();
    convertParams(cardInfo);
    stripe['transport']['callAPI']('POST', 'tokens', {'card' : cardInfo, 'amount' : amount}, stripe['publishableKey'], callback);
  };


  stripe['getToken'] = function(stripeToken, callback) {
    assertPublishableKey();
    stripe['transport']['callAPI']('GET', 'tokens/' + stripeToken, {}, stripe['publishableKey'], callback);
  };

  stripe['setPublishableKey'] = function(key) {
    stripe['publishableKey'] = key;
  }

  transport['init']();
})(typeof exports !== 'undefined' && exports !== null ? exports : window['Stripe'] = {})
