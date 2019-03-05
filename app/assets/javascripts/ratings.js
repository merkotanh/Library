function setRating(rating) {
  $('#ratingFormSubmit').click();
  $( "#rating-section" ).load(window.location.href + " #rating-section" );
}
function showRating(rating, user_id) {
  $( "#rating-section" ).load(window.location.href + " #rating-section" );
  alert("U v been voted already: ")
}