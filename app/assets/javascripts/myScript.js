$(document).on('turbolinks:load', function () {
  // function hoge(){
  $('li').on('click', function(e) {
    //debugger;
    //activeの場合とdropdownの場合は何もしない
    if(!/active|dropdown/.test(this.className)){
    const targetClass = e.target.parentElement.className
    $('#myTabContent div').removeClass('active in');
    $('#'+ targetClass).addClass('active in');

    $('.nav-tabs li').removeClass('active');
    $(this).addClass("active")
    }
  });
});
$(document).on('turbolinks:load', function () {
  $('form').on('change', 'input[type="file"]', function(e) {
    $('#thumbnail').remove();
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(".preview");
        t = this;
    if(file.type.indexOf("image") < 0){
      return false;
    }
    reader.onload = (function(file) {
      return function(e) {

        $preview.empty();

        $preview.append($('<img>').attr({
                  src: e.target.result,
                  class: "imageSize_detailArticle",
                  title: file.name,
                  id:"preview"
              }));
      };

    })(file);
    reader.readAsDataURL(file);
  });

  $("#reset").on("click", function(){
    $("#preview").remove();
    $("#thumbnail").remove();
    $("#picture_image_cache").val('');
  });
});
