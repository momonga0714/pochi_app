$(document).on('turbolinks:load', function(){
  $(function(){

    function buildHTML(count) {
      var html = `<div class="preview-box-soop" id="preview-box-soop__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      
                      <div class="delete-box-soop" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }
    // 編集 soop
    if (window.location.href.match(/\/soops\/\d+\/edit/)){
      //登録済み画像のプレビュー表示欄の要素を取得する
      var prevContent = $('.label-content-soop').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content-soop').css('width', labelWidth);
      //プレビューにidを追加
      $('.preview-box-soop').each(function(index, box){
        $(box).attr('id', `preview-box-soop__${index}`);
      })
      //削除ボタンにidを追加
      $('.delete-box-soop').each(function(index, box){
        $(box).attr('id', `delete_btn_${index}`);
      })

      var count = $('.preview-box-soop').length;
      //プレビューが5あるときは、投稿ボックスを消しておく
      if (count == 5) {
        $('.label-content-soop').hide();
      }
    }




    function setLabel() {
      var prevContent = $('.label-content-soop').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content-soop').css('width', labelWidth);
    }

    $(document).on('change', '.hidden-field-soop', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      // $('.label-box').attr({id: `label-box--${id}`,for: `main_resipi_images_attributes_${id}_image`});
      $('.label-box-soop').attr({id: `label-box-soop--${id}`,for: `soop_resipi_images_attributes_${id}_image`});
      // $('.label-box-soop').attr({id: `label-box-soop--${id}`,for: `soop_resipi_images_attributes_${id}_image`});
      
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var url = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box-soop__${id}`).length == 0) {
          var count = $('.preview-box-soop').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content-soop').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box-soop__${id} img`).attr('src', `${url}`);
        var count = $('.preview-box-soop').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          $('.label-content-soop').hide();
        }

        if ($(`#soop_resipi_images_attributes_${id}__destroy`)){
          $(`#soop_resipi_images_attributes_${id}__destroy`).prop('checked',false);
        }
        
        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          //プレビューの数でラベルのオプションを更新する
          
          $('.label-box-soop').attr({id: `label-box-soop--${count}`,for: `soop_resipi_images_attributes_${count}_image`});
         
        }
}
      
    });
    

    // 画像の削除
    $(document).on('click', '.delete-box-soop', function() {
      var count = $('.preview-box-soop').length;
      setLabel(count);
      //resipi_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box-soop__${id}`).remove();
       //削除用チェックボックスの有無で判定
       
      
      

      if ($(`#soop_resipi_images_attributes_${id}__destroy`).length == 0) {
        //フォームの中身を削除 
        $(`#soop_resipi_images_attributes_${id}_image`).val("");
        var count = $('.preview-box-soop').length;
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content-soop').show();
        }
        setLabel(count);
        if(id < 5){
          $('.label-box-soop').attr({id: `label-box-soop--${id}`,for: `soop_resipi_images_attributes_${id}_image`});
          
        }
      } else {
        //投稿編集時
        $(`#soop_resipi_images_attributes_${id}__destroy`).prop('checked',true);
       
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content-soop').show();
        }
        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        //削除したプレビューのidによって、ラベルのidを変更する
        if(id < 5){
          $('.label-box-soop').attr({id: `label-box-soop--${id}`,for: `soop_resipi_images_attributes_${id}_image`});
        }
      }

      


      
    });
  });
})