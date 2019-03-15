function setRating(rating) {

  $('#ratingFormSubmit').click();
}

function showRating(rating, user_id) {
  $('#rating-section').load(window.location.href + " #rating-section" );
  $('#rating_alert').show();
}