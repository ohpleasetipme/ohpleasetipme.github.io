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

var local_info = $.getJSON('http://ip-api.com/json?callback=?', function(data) {
  console.log(JSON.stringify(data, null, 2));
});

function get_location () {
    return (local_info.responseJSON.city + " in " + local_info.responseJSON.country);
}

function get_btc_price () {
$.ajax({
        async: true,
        type: "GET",
        url: "https://www.bitstamp.net/api/ticker/",
        success: function(result) {
          data = result.last;
          document.getElementById("btc").innerHTML = data;
          }
});
}
