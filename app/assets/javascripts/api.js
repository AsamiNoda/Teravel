//section 1
//APIを利用する際のURLになります
var KEY = gon.my_private_key
var url = 'https://vision.googleapis.com/v1/images:annotate?key='
var api_url = url + KEY

//section 2
//ページを読み込む際に動的にラベル検出結果表示用のテーブルを作成
$(function(){
    for (var i =0; i < 5; i++){
        $("#resultBox").append("<tr><td class='resultTableContent'></td></tr>")
    }
})

//section 3
//画面の表示内容をクリアする処理
function clear(){
    $("#resultBox tr td").text("")
}

//section 4
//画像がアップロードされた時点で呼び出される処理
$(document).on('change', 'input[type="file"]', function(evt) {
    getImageInfo(evt);
    clear();
    $(".resultArea").removeClass("hidden")
})

//section 5
//画像ファイルを読み込み、APIを利用するためのURLを組み立てる
function getImageInfo(evt){
    var file = evt.target.files;
    var reader = new FileReader();
    var dataUrl = "";
    reader.readAsDataURL(file[0]);
    reader.onload = function(){
        dataUrl = reader.result;
        makeRequest(dataUrl,getAPIInfo);
    }
}

//section 6
//APIへのリクエストに組み込むJsonの組み立て
function makeRequest(dataUrl,callback){
    var end = dataUrl.indexOf(",")
    var request = "{'requests': [{'image': {'content': '" + dataUrl.slice(end + 1) + "'},'features': {'type': 'LANDMARK_DETECTION','maxResults': 5,}}]}"
    callback(request)
}

//section 7
//通信を行う
function getAPIInfo(request){
    $.ajax({
        url : api_url,
        type : 'POST',
        async : true,
        cashe : false,
        data: request,
        dataType : 'json',
        contentType: 'application/json',
    }).done(function(result){
        showResult(result);
    }).fail(function(result){
        alert('failed to load the info');
    });
}

//section 8
//得られた結果を画面に表示する
function showResult(result){
    //ラベル検出結果の表示
    if(result.responses[0].landmarkAnnotations){
        for (var i = 0; i < result.responses[0].landmarkAnnotations.length;i++){
            // $("#resultBox tr:eq(" + i + ") td").text(result.responses[0].landmarkAnnotations[i].description)
            $("#resultBox").append("<tr><td class='resultTableContent'>" + result.responses[0].landmarkAnnotations[i].description)
        }
    }else{
        //テキストに関する結果が得られなかった場合、表示欄にはその旨を記す文字列を表示
        $("#resultBox").append("<tr><td class='resultTableContent'>結果は得られませんでした。</td></tr>")
    }
}