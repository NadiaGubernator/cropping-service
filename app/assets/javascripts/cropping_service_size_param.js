CroppingService.sizeParam = function(){
  $(":radio").click(function(e) {
    var cropSize = $(":radio:checked").val();

    var params_string = '';

    if (cropSize != undefined) {
      params_string = "&size=" + cropSize;
    }

    window.location.href = window.location.href
      .replace( /[\&][/size/].*|$/, params_string );
  });
}
