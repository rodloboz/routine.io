var set_positions;

set_positions = function(){
    // loop through and give each task a data-pos
    // attribute that holds its position in the DOM
    $('.question-row').each(function(i){
        $(this).attr("data-pos",i+1);
        $(this).find('.question-position').text(i+1);
    });
}


set_positions();
$('#routine-questions').sortable({
  axis: 'y',
  placeholder: 'sortable-placeholder'
});
$('#routine-questions').sortable().bind('sortupdate', function(e, ui){
  // array to store new order
  updated_order = [];

  // set the updated positions
  set_positions();

  // populate the updated_order array with the new task positions
  $('.question-row').each(function(i){
      updated_order.push({ id: $(this).data("id"), position: i+1 });
  });

  routine = $("#routine-questions").data("routine");

  // send the updated order via ajax
  $.ajax({
      type: "POST",
      url: '/sort',
      data: { order: updated_order, routine_id: routine }
  });

});

if ($('.question-row').length == 0) {
  $('#preview-button').prop('disabled', true);
} else {
  $('#preview-button').prop('disabled', false);
};


