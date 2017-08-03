CroppingService.position = function(){
  $("img").click(function(e) {
    var parentOffset = $(this).parent().offset();

    var relX = e.pageX - parentOffset.left;
    var relY = e.pageY - parentOffset.top;

    document.getElementById('crop_x').value = relX;
    document.getElementById('crop_y').value = relY;

    alert("Selected point:\n" + "Left: " + relX + " Top: " + relY);
  });
}
