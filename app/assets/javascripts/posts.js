PrivatePub.subscribe('/live-feed', function(data, channel){
  if( data.message === undefined ) return;

  var post = data.message;
  var id   = post.id;
  var body = post.body;

  $('#best_in_place_post_' + id + '_body').text(body);
  $('#post-' + id + ' .public-post-body').text(body);
});
