$(function(){
  let cardNumber = $('#card_number').val();
  let cvv = $('#cvv').val();
  let exp_year = $('#exp_year').val();
  let exp_month = $('#exp_month').val();
  $('#card_number').blur(function(){
    if(!isNaN(cardNumber)){
      $(this).after('<div style="color: red"> 入力エラーがあります </div>');
    }
  });
  $('#cvv').blur(function(){
    if(!isNaN(cvv)){
      $(this).after('<div style="color: red"> 入力エラーがあります </div>');
    }
  });
  $('#exp_year').blur(function(){
    if(!isNaN(exp_year)){
      $(this).after('<div style="color: red"> 入力エラーがあります </div>');
    }
  });
  $('#exp_month').blur(function(){
    if(!isNaN(exp_month)){
      $(this).after('<div style="color: red"> 入力エラーがあります </div>');
    }
  });
});
