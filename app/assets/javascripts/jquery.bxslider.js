$(document).ready(function(){
  $('.slider').bxSlider({
    mode: 'horizontal',
    randomStart: true,
    infiniteLoop: true,
    auto: true,
    speed: 2500,
    minSlides: 1, //最低限表示する数
    maxSlides: 3, //マックスで表示する数
    moveSlides: 1, //スライドをどのくらいの数を動かすか
    slideWidth: 300, //ひとつの要素の幅を指定

  });
});