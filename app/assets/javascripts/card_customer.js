$(function(){
  let btn = $('#token');
  // 登録ボタンが押されると発火
  btn.on('click',function(e){
    // submitのイベントを止める
    e.preventDefault();
    // 各入力内容を取得
    let card_number = $('#card_number').val();
    let cvv = $('#cvv').val();
    let exp_year = $('#exp_year').val();
    let exp_month = $('#exp_month').val();

    // if(card_number !==)

    // 入力された内容をハッシュオブジェクトとして定数card_infoに格納
    const card_info = {
      number: card_number,
      cvc: cvv,
      exp_year: exp_year,
      exp_month: exp_month
    };

    // トークン生成時に使うのパブリックキーを設定、このキーを元に暗号化されたTokenが作られる
    Payjp.setPublicKey('pk_test_65859f25420a5bca288f9588');
    // トークン取得のメソッドを実行
    Payjp.api_key = 'sk_test_dc189ea51b0a5fd7341509b9'
    // 決済に使うカード情報をもったトークンを生成している
    Payjp.createToken(card_info, function(status, response){
    // 無事にトークンが生成された場合
      if (status == 200) {
    // handle token object and send back to your server. You can get token id from "response.id".
        let token = response.id
        // サーバー側で利用できるようにtokenを埋め込んでいる
        $('.form-group').append(`<input type="hidden" name="token" value=${token}>`)
        // formを送信する
        $('.card-new-form').submit();
      } else {
        // handle error like displaying error message.
        let error_messages = '入力内容に不備があります';
        $('.errors').append(`<ul><li>${error_messages}</li></ul>`);
      }
    });
  });
});
