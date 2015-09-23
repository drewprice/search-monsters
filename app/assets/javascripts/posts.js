PrivatePub.subscribe('/live-feed', function(data, channel){
  if( data === undefined ) return;

  var post = data.message;
  var id   = post.id;
  var body = post.body;

  $('#best_in_place_post_' + id + '_body').text(body);
  $('#post-' + id + ' .public-post-body').text(body);
});


$( document ).ready(function() {
  if ($('.pagination').length){
    $(window).scroll(function(){
      url = $('.pagination .next_page').attr('href')
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50){
        $('.pagination').text('Fetching more pokestuff')
        $.getScript(url);
      }
    })
  }
});
