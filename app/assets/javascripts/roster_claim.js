$("#roster-button").on("submit", function(event) {
  event.preventDefault();

  var url = $(this).attr("href");
  var roster = $(this).parent().find("#roster-list");
  $.ajax({
    type: "POST",
    url: url,
    dataType: "json",
    success: function(response) {
      var id_name = response.name.first_name + '-' + response.name.last_name;
      var full_name = response.name.first_name + ' ' + response.name.last_name;
      if ($("#actual-button").val() === "Claim") {
        var $player = $("<li>", {
          id: id_name,
          text: full_name
        });
        roster.append($player);
        $("#actual-button").val(response.button_name);
      } else {
        $("#" + id_name).remove();
        $("#actual-button").val(response.button_name);
      }
    }
  });
});
