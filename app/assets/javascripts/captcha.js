//ロードされた際の処理として実施：
window.onload = function(){

  //HTML内に画像を表示
  
  //ボタンを押下した際にダウンロードする画像を作る
  html2canvas(document.body,{
    onrendered: function(canvas){
      //aタグのhrefにキャプチャ画像のURLを設定
      var imgData = canvas.toDataURL();
      document.getElementById("ss").href = imgData;
    }
  });

}

// $(function () {
//   $('#ss').hover(function() {
//     $(this).next('p').show();
//   }, function(){
//     $(this).next('p').hide();
//   });
// });