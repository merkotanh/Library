function addHistoryToBook(history_html){
  $("#history-section").append(history_html)
};

document.addEventListener("turbolinks:load", function(){
    $('.expand-description').on('click', function(){
    $('.special-text').toggleClass('-expanded');
    
    if ($('.special-text').hasClass('-expanded')) {
      $('.expand-description').html('hide content');
    } else {
      $('.expand-description').html('read more');
    }
  });

  $('.expand-history').on('click', function(){
    $('#history-section').toggleClass('-expanded');
    
    if ($('#history-section').hasClass('-expanded')) {
      $('.expand-history').html('hide content');
    } else {
      $('.expand-history').html('read more');
    }
  });

  $('.expand-comments').on('click', function(){
    $('#comments-section').toggleClass('-expanded');
    
    if ($('#comments-section').hasClass('-expanded')) {
      $('.expand-comments').html('hide content');
    } else {
      $('.expand-comments').html('read more');
    }
  });
});