function setRating(rating) {
  $('#ratingFormSubmit').click();
  $( "#rating-section" ).load(window.location.href + " #rating-section" );
}
function showRating(rating) {
  $( "#rating-section" ).load(window.location.href + " #rating-section" );
  alert("U v been votes already")
}