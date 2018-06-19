$(document).on('turbolinks:load', function () {
  $(document).bind('ajaxError', 'form#user_modal', function (event, jqxhr) {
    if (jqxhr.responseText !== undefined) { // 写真をセットした場合, responseTextが undefind
      $(event.data).render_form_errors($.parseJSON(jqxhr.responseText));
    }
  });
});

(function ($) {
  // Json型のエラー情報({name:"message",・・})から、該当箇所にClassとメッセージをセットするプラグイン
  $.fn.render_form_errors = function(errors){
    // 全エラーを一旦削除
    this.clear_previous_errors();
    model = errors.target
    $.each(errors, function (field, messages) {
      $input = $('[name="' + model + '[' + field + ']"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block').html(messages);
    });
  };
  $.fn.clear_previous_errors = function(){
    $('.form-group.has-error').each(function () {
      // メッセージをすべて削除
      $('.help-block').html('');
      // has-errorをすべて削除
      $(this).removeClass('has-error');
    });
  }
}(jQuery));
