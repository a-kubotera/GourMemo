$(document).on('turbolinks:load', function () {

  $(document).bind('ajaxError', 'form#user_modal', function(event, jqxhr, settings, exception){

    // note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

  });

});

(function($) {

  $.fn.modal_success = function(){
    // close modal
    this.modal('hide');

    // clear form input elements
    // todo/note: handle textarea, select, etc
    this.find('form input[type="text"]').val('');

    // clear error state
    this.clear_previous_errors();
  };

  $.fn.render_form_errors = function(errors){

    $form = this;
    this.clear_previous_errors();
    model = errors.target

    // エラーが発生した場合、以下の処理が走る
    $.each(errors, function(field, messages){
      $input = $('[name="' + model + '[' + field + ']"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block').html(messages);
    });

  };

  $.fn.clear_previous_errors = function(){
    $('.form-group.has-error').each(function(){
      $('.help-block').html('');
      $(this).removeClass('has-error');
    });
  }

}(jQuery));
