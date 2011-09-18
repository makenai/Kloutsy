$(document).ready(function() {

  var TOPICS_URL = 'http://api.klout.com/1/users/topics.json?callback=?&key=YOUR KEY HERE&users=';

  $('a.tweets').click( function(e) {
    e.preventDefault();
    var user = $(this).data('user');
    $(this).parent().addClass('embiggen').append('<div id="' + user + 'Tweets"></div>').end().remove();
    new TWTR.Widget({
      version: 2,
      type: 'profile',
      id: user + 'Tweets',
      rpp: 4,
      interval: 30000,
      width: 250,
      height: 300,
      theme: {
        shell: {
          background: '#333333',
          color: '#ffffff'
        },
        tweets: {
          background: '#000000',
          color: '#ffffff',
          links: '#4aed05'
        }
      },
      features: {
        scrollbar: false,
        loop: false,
        live: false,
        hashtags: true,
        timestamp: true,
        avatars: false,
        behavior: 'all'
      }
    }).render().setUser(user).start();
  });

  $('.klout-topics').each( function(i,div) {
    var user = $(div).data('user');
    $.getJSON( TOPICS_URL + user, function(data) {
      var html = '';
      $(data.users[0].topics).each(function(i,topic) {
        html += topic + ', ';
      });
      $(div).html( html );      
    });
  });

});