$(document).ready(function(){
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
