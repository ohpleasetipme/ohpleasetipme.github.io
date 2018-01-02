function copy(text) {
  var textArea = document.createElement("textarea");
  textArea.style.position = 'fixed';
  textArea.style.top = 0;
  textArea.style.left = 0;
  textArea.style.width = '2em';
  textArea.style.height = '2em';
  textArea.style.padding = 0;
  textArea.style.border = 'none';
  textArea.style.outline = 'none';
  textArea.style.boxShadow = 'none';
  textArea.style.background = 'transparent';
  textArea.value = text;
  document.body.appendChild(textArea);

  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Copying text command was ' + msg);
  } catch (err) {
    console.log('Oops, unable to copy');
  }

  document.body.removeChild(textArea);
  $.notify("My address is in your clipboard! Thank you!", "success");
}

var local_info =
$.getJSON('//ipapi.co/json/', function(data) {
  return (JSON.stringify(data, null, 2));
});

// $.getJSON('https://ip-api.com/json?callback=?', function(data) {
//   console.log(JSON.stringify(data, null, 2));
// });

function sync_scroll () {
    $('html, body').animate({
         scrollTop: $("#end").offset().top
    }, 1);
}

function get_location () {
    return (local_info.responseJSON.city);
}

var btc_price = 0.;

function get_btc_info () {
    $.getJSON('//api.coindesk.com/v1/bpi/currentprice.json').then (function (json) { 
	btc_price = json.bpi.USD.rate_float; 
    });
}

function get_btc_price () {
    return btc_price;
}

function to_christmas () {
    var date1 = new Date();
    var date2 = new Date("12/25/2017");
    var timeDiff = date2.getTime() - date1.getTime();
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
    return diffDays;
}
