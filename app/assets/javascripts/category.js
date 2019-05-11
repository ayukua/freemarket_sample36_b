$(function() {
  $("#product_parent_category_id").change(function(event, template) {
    var val = $("#product_parent_category_id").val();
    var template = $(`#child${val}th`);
    console.log(template);
    $(this).nextAll().remove();
    $(this).parent().append(template.html());
  });

  $(document).on('change', '.childCategory', function(event, template) {
    var val = $('.childCategory').val();
    var template = $(`#grandchild${val}th`);
    console.log(template);
    $(this).nextAll().remove();
    $(this).parent().append(template.html());
  });
});
