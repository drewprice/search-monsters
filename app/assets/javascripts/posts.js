PrivatePub.subscribe('/live-feed', function(data, channel){
  if( data === undefined ) return;

  var post = data.message;
  var id   = post.id;
  var body = post.body;

  $('#best_in_place_post_' + id + '_body').text(body);
  $('#post-' + id + ' .public-post-body').text(body);
});


$( document ).ready(function() {
  if ( $('.pagination').length ){
    $(window).scroll(function(){
      url = $('.pagination .next_page').attr('href')

      if (url && ( $(window).scrollTop() > $(document).height() - $(window).height() - 500) ){
        $('.pagination')
          .html('<p class="loading">Fetching more pokestuff</p>')
          .hide()
          .fadeIn('fast', function(){
            $(this).fadeOut();
          });

        $.getScript(url);
      }
    });
  }
});
