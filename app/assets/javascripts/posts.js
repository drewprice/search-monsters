PrivatePub.subscribe('/live-feed', function(data, channel) {
  if (data === undefined) return;

  var post = data.message;
  var id = post.id;
  var body = post.body;

  $('#best_in_place_post_' + id + '_body').text(body);
  $('#post-' + id + ' .public-post-body').text(body);
});


$(document).ready(function() {
  $('.best_in_place').best_in_place();

  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href')

      if (url && ($(window).scrollTop() > $(document).height() - $(window).height() - 50)) {
        alert('yeeeees!');
        $('.pagination').html('<p class="loading">Fetching more pokestuff</p>')
        $.getScript(url);
      }
    });
  }
});
