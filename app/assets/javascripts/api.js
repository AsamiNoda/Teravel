var KEY = gon.my_private_key
var url = 'https://vision.googleapis.com/v1/images:annotate?key='
var api_url = url + KEY


$(function(){
    for (var i =0; i < 5; i++){
        $("#resultBox").append("<tr><td class='resultTableContent'></td></tr>")
    }
})


function clear(){
    $("#resultBox tr td").text("")
}


$(document).on('change', 'input[type="file"]', function(evt) {
    getImageInfo(evt);
    clear();
    $(".resultArea").removeClass("hidden")
})


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


function makeRequest(dataUrl,callback){
    var end = dataUrl.indexOf(",")
    var request = "{'requests': [{'image': {'content': '" + dataUrl.slice(end + 1) + "'},'features': {'type': 'LANDMARK_DETECTION','maxResults': 5,}}]}"
    callback(request)
}


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


function showResult(result){

    if(result.responses[0].landmarkAnnotations){
        for (var i = 0; i < result.responses[0].landmarkAnnotations.length;i++){
            // $("#resultBox tr:eq(" + i + ") td").text(result.responses[0].landmarkAnnotations[i].description)
            $("#resultBox").append("<tr><td class='resultTableContent'>" + result.responses[0].landmarkAnnotations[i].description)
        }
    }else{
        $("#resultBox").append("<tr><td class='resultTableContent'>結果は得られませんでした。</td></tr>")
    }
}