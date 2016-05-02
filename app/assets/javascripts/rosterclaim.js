$("#roster-button").on("submit", function(event) {
  event.preventDefault();

var url = $(this).attr("href");
var roster = $(this).parent().find("#roster-list");
  if ($("#actual-button")[0].value === "Claim") {
    var request = $.ajax({
      type: "POST",
      url: url,
      dataType: "json",
      success: function(response) {
        var full_name = response.name.first_name + ' ' + response.name.last_name;
        var player = document.createElement("li");
        player.setAttribute("id", full_name);
        player.appendChild(document.createTextNode(full_name));
        roster[0].appendChild(player);
        document.getElementById("actual-button").value = response.button_name;
      }
    });
  } else {
    var request = $.ajax({
      type: "POST",
      url: url,
      dataType: "json",
      success: function(response) {
        document.getElementById(full_name).remove();
        document.getElementById("actual-button").value = response.button_name;
      }
    });
  }
});
