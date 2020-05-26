$(document).on('turbolinks:load', function(){
  $(function(){

    function buildHTML(count) {
      var html = `<div class="preview-box-sub" id="preview-box-sub__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      
                      <div class="delete-box-sub" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }
    
    // 編集 sub
    if (window.location.href.match(/\/subs\/\d+\/edit/)){
      //登録済み画像のプレビュー表示欄の要素を取得する
      var prevContent = $('.label-content-sub').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content-sub').css('width', labelWidth);
      //プレビューにidを追加
      $('.preview-box-sub').each(function(index, box){
        $(box).attr('id', `preview-box-sub__${index}`);
      })
      //削除ボタンにidを追加
      $('.delete-box-sub').each(function(index, box){
        $(box).attr('id', `delete_btn_${index}`);
      })

      var count = $('.preview-box-sub').length;
      //プレビューが5あるときは、投稿ボックスを消しておく
      if (count == 5) {
        $('.label-content-sub').hide();
      }
    }




    function setLabel() {
      var prevContent = $('.label-content-sub').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content-sub').css('width', labelWidth);
    }

    $(document).on('change', '.hidden-field-sub', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      // $('.label-box').attr({id: `label-box--${id}`,for: `main_resipi_images_attributes_${id}_image`});
      $('.label-box-sub').attr({id: `label-box-sub--${id}`,for: `sub_resipi_images_attributes_${id}_image`});
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
        if ($(`#preview-box-sub__${id}`).length == 0) {
          var count = $('.preview-box-sub').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content-sub').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box-sub__${id} img`).attr('src', `${url}`);
        var count = $('.preview-box-sub').length;
        //プレビューが5個あったらラベルを隠す 
        if (count == 5) { 
          $('.label-content-sub').hide();
        }

        if ($(`#sub_resipi_images_attributes_${id}__destroy`)){
          $(`#sub_resipi_images_attributes_${id}__destroy`).prop('checked',false);
        }
        
        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        if(count < 5){
          //プレビューの数でラベルのオプションを更新する
          // $('.label-box').attr({id: `label-box--${count}`,for: `main_resipi_images_attributes_${count}_image`});
          $('.label-box-sub').attr({id: `label-box-sub--${count}`,for: `sub_resipi_images_attributes_${count}_image`});
          // $('.label-box-soop').attr({id: `label-box-soop--${count}`,for: `soop_resipi_images_attributes_${count}_image`});
        }
}
      
    });
    

    // 画像の削除
    $(document).on('click', '.delete-box-sub', function() {
      var count = $('.preview-box-sub').length;
      setLabel(count);
      //resipi_images_attributes_${id}_image から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box-sub__${id}`).remove();
       //削除用チェックボックスの有無で判定
       
      

      if ($(`#sub_resipi_images_attributes_${id}__destroy`).length == 0) {
        //フォームの中身を削除 
        $(`#sub_resipi_images_attributes_${id}_image`).val("");
        var count = $('.preview-box-sub').length;
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content-sub').show();
        }
        setLabel(count);
        if(id < 5){
          $('.label-box-sub').attr({id: `label-box-sub--${id}`,for: `sub_resipi_images_attributes_${id}_image`});
          
        }
      } else {
        //投稿編集時
        $(`#sub_resipi_images_attributes_${id}__destroy`).prop('checked',true);
       
        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.label-content-sub').show();
        }
        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        //削除したプレビューのidによって、ラベルのidを変更する
        if(id < 5){
          $('.label-box-sub').attr({id: `label-box-sub--${id}`,for: `sub_resipi_images_attributes_${id}_image`});
        }
      }

      

      
    });
  });
})