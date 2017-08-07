CroppingService.position = function(){
  $("img").click(function(e) {
    var offset = $(this).offset();

    var relX = Math.round(e.pageX - offset.left);
    var relY = Math.round(e.pageY - offset.top);

    alert("Selected point:\n" + "Left: " + relX + " Top: " + relY);

    window.location.href = window.location.href
      .replace( /[\?].*|$/, "?x=" + relX + "&y=" + relY );
  });
}
