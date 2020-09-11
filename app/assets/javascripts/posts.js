// $(function() {
// var search_list = $(".contents.row");

//   function appendPost(post) {
//     if(post.user_sign_in && post.user_sign_in.id == post.user_id){
//       var current_user = `<li>
//                             <a href="/posts/${post.id}/edit" data-method="get" >編集</a>
//                           </li>
//                           <li>
//                             <a href="/posts/${post.id}" data-method="delete" >削除</a>
//                           </li>`
//     } else {
//       var current_user = ""
//     }

//     var html = `<div class="content_post" style="background-image: url(${post.post_image});">
//                   <div class="more">
//                     <span><img src="/assets/arrow_top.png"></span>

//                   </div>
//                   <p>${post.body}</p><br>
//                   <span class="name">
//                     <a href="/users/${post.user_id}">
//                       <span>投稿者</span>${post.name}
//                     </a>
//                   </span>
//                 </div>`
//     search_list.append(html);
//   }

//   $(".search-input").on("keyup", function() {
//     var input = $(".search-input").val();
//     $.ajax({
//       type: 'GET',
//       url: '/posts/search',
//       data: { keyword: input },
//       dataType: 'json'
//     })
//     .done(function(posts) {
//       $(".contents.row").empty();
//       if (posts.length !== 0) {
//         posts.forEach(function(post){
//           appendPost(post);
//         });
//       }
//       else {
//         appendErrMsgToHTML("一致するポストがありません");
//       }
//     })
//     .fail(function() {
//       alert('error');
//     });   
//   });
// });