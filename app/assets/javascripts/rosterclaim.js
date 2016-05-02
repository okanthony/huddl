$("#roster-button").on("submit", function(event) {
  event.preventDefault();

var url = $(this).attr("href");
var roster = $(this).parent().find("#roster-list");

  var request = $.ajax({
    type: "POST",
    url: url,
    dataType: "json",
    success: function(response) {
      var player = document.createElement("li");
      player.appendChild(document.createTextNode(response.name.first_name + ' ' + response.name.last_name));
      roster[0].appendChild(player);
      document.getElementById("actual-button").value = response.button_name;
    }
  });
});
