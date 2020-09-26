$(function() {

//一致する結果がいた場合の処理
var search_list = $(".search-result");

function appendTag(tag) {
    let html = `
      <a href="tags/${tag.id}/posts" class="btn btn-default">${tag.tag_name}</a>
    `
    search_list.append(html);
  }

//一致する結果がなかった場合の処理
  function addNoTag() {
    let html = `
      <div class=>
        <p>検索結果はありませんでした。</p>
      </div>
    `;
//作ったhtmlを入れる
    search_list.append(html);
  }
//検索欄に文字入力されるたびに処理を行う
  $(".search-input").on("keyup", function() {

//検索欄に入力された文字をvalで取得し変数inputに代入
      let input = $(".search-input").val();
      $.ajax({
      type: "GET", //httpメソッド(今回はget)
      url: "/", //送る先のurl

//keyを自分で決め(今回は"keyword"と定義)valueには先ほど検索欄から取得し代入したinputの値を使う
      data: { keyword: input },
      dataType: "json"
    })


//jbuilderファイルで作った配列を引数にしdone関数を起動
.done(function(tags) {

//if,else if,elseどの場合においても、処理後は、すでに検索欄に出力されている情報を削除する。
        search_list.empty();

//検索に一致するユーザーが０じゃない場合(いる場合)
        if (tags.length !== 0) {

//usersという配列をforEachで分解し、タグごとにaddTag関数に飛ばす(処理は後ほど)
          tags.forEach(function(tag) {
            appendTag(tag);
          });

//入力欄に文字が入力されてない場合処理を終了
        } else if (input.length == 0) {
          return false;

//検索に一致するタグがいない場合はaddNoTagに飛ばす
        } else {
          addNoTag("一致する項目はありません");
        }
      })
.fail(function() {
        alert("通信エラーです。検索結果を表示できません。");
      });

  });
});


