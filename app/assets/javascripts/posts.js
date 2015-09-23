PrivatePub.subscribe('/live-feed', function(data, channel){
  if( data === undefined ) return;

  var post = data.message;
  var id   = post.id;
  var body = post.body;

  $('#best_in_place_post_' + id + '_body').text(body);
  $('#post-' + id + ' .public-post-body').text(body);
});


$( document ).ready(function() {
  $(window).scroll(function(){
    if($(window).scrollTop() > $(document).height() - $(window).height() - 50){
      $.getScript($('.pagination .next_page').attr('href'));
    }
  })
});
