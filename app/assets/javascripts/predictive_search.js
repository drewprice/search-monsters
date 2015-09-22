var ready;
ready = function() {

   var usersSearch = new Bloodhound({
     remote: {url: "/users/autocomplete?query=%QUERY", wildcard: "%QUERY"},
     datumTokenizer: function(d) {
             return Bloodhound.tokenizers.whitespace(d.username); },
     queryTokenizer: Bloodhound.tokenizers.whitespace
   });

// initialize the bloodhound suggestion engine

var promise = usersSearch.initialize();

promise
.done(function() { console.log('success!'); })
.fail(function() { console.log('err!'); });

// instantiate the typeahead UI
$('.typeahead').typeahead({
hint: false,
highlight: true,
minLength: 0
},{
  name: 'peaches',
  display: 'username',
  source: usersSearch.ttAdapter()

});
}

$(document).ready(ready);
$(document).on('page:load', ready);
