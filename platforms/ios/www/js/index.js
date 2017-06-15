/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        this.receivedEvent('deviceready');

        function init() {
            var userDetails = {
                clientId: "IKIA7B379B0114CA57FAF8E19F5CC5063ED2220057EF",
                clientSecret: "MiunSQ5S/N219UCVP1Lt2raPfwK9lMoiV/PdBX5v/R4=",
                paymentApi: "https://qa.interswitchng.com",
                passportApi: "https://qa.interswitchng.com/passport"
            };

            var initial = PaymentPlugin.init(userDetails);
        }
        var payWithCard = function() {
            var payWithCardRequest = {
                amount: "20", // Amount in Naira
                customerId: "1234567890", // Optional email, mobile no, BVN etc to uniquely identify the customer.
                currency: "NGN", // ISO Currency code
                description: "Purchase Phone" // Description of product to purchase
            };
            var payWithCardSuccess = function(response) {
                var purchaseResponse = JSON.parse(response);

                alert(purchaseResponse.message);
            }
            var payWithCardFail = function(response) {
                alert(response);
            }
            PaymentPlugin.payWithCard(payWithCardRequest, payWithCardSuccess, payWithCardFail);
        }

        init();


        document.getElementById('payButton').addEventListener('click', function() {
            payWithCard();
        })
    },

    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};

app.initialize();
