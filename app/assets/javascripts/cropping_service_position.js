CroppingService.position = function(){
  $('img').click(function(e) {
    var parentOffset = $(this).parent().offset();

    var relX = e.pageX - parentOffset.left;
    var relY = e.pageY - parentOffset.top;

    alert("Left: " + relX + " Top: " + relY);
  });
}
