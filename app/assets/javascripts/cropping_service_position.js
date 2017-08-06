CroppingService.position = function(){
  $("img").click(function(e) {
    var parentOffset = $(this).parent().offset();

    var relX = e.pageX - parentOffset.left;
    var relY = e.pageY - parentOffset.top;

    alert("Selected point:\n" + "Left: " + relX + " Top: " + relY);

    window.location.href = window.location.href
      .replace( /[\?].*|$/, "?x=" + relX + "&y=" + relY );
  });
}
