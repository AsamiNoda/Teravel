$(document).on('turbolinks:load', function(){
  const inputForm = $('#searching-form');
  const post = location.href;
  const searchResult = $('.result ul');

  function builtHTML(data){
    let html = `

    <div class="pull-left">

		<div>${data.body}</div>
		<div>${data.country_name}</div>
		<div>${data.name}</div>
		<a href="/tags/${data.id}/posts">${data.tag_name}</a>
    <a href="/posts/${data.id}">${data.body}</a>
    `
    searchResult.append(html);
  }

  function NoResult(message){
    let html = `
    <div>${message}</div>
    `
    searchResult.append(html);
  }

  // フォームに入力すると発火する
  inputForm.on('keyup', function(){
    const target = $(this).val();
    search(target);
  });

  // ajax処理
  function search(target){
    $.ajax({
      type: 'GET',
      url: '/',
      data: {keyword: target},
      dataType: 'json'
    })
    .done(function(data){
      searchResult.empty(); //再度検索した際に前のデータを消す処理
      if (data.length !== 0) {
        data.forEach(function(data) { //dataは配列型に格納されているのでEach文で回す
          builtHTML(data)
        });
      } else {
        NoResult('検索結果が見つかりませんでした')
      }
    })
    .fail(function(data){
      alert('非同期通信に失敗しました');
    })
  }
});
