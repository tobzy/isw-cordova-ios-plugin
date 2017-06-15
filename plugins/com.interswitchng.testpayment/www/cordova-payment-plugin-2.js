var exec = require('cordova/exec');


function paymentAction (action) {
  return function (arg, successCallback, failCallback) {
    var argsArray =  (Array.isArray(arg)) ? arg : [arg];
    
    if(successCallback) {
      exec(successCallback, failCallback, "PaymentPlugin", action, argsArray);
    } else {
      exec(function(response) {}, failCallback, "PaymentPlugin", action, argsArray);
    }
  }
}

var PaymentPlugin = {};
PaymentPlugin.SAFE_TOKEN_RESPONSE_CODE = "T0";
PaymentPlugin.CARDINAL_RESPONSE_CODE = "S0";
PaymentPlugin.init = paymentAction("Init");

// Using Payment SDK UI
PaymentPlugin.pay = paymentAction("Pay");
PaymentPlugin.payWithCard = paymentAction("PayWithCard");

// Without using Payment SDK UI
// PaymentPlugin.makePayment = paymentAction("MakePayment");


module.exports = PaymentPlugin;
