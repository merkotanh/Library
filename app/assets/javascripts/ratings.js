function setRating(rating) {
  $('#ratingFormSubmit').click();
}

function showRating(rating, user_id) {
  $('#rating-section').load(window.location.href + " #rating-section" );
  alert("U v been voted already: ")
}