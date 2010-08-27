jQuery.fn.imageSwap = function() {
  jQuery("a#forward_link").click(function(e) {
    e.preventDefault();

    var product_address = window.location.pathname;
    var set = jQuery(".main_image");
    var current_element = set.filter(":visible");

    current_element.css('display','none');

    var last_element = set.last();
    var first_element = set.first();

    if(current_element.attr('alt')==last_element.attr('alt'))
    {
      current_element = first_element;
    }
    else
    {
      current_element = current_element.next();
    }

    current_element.css('display','block')

    switch(current_element.attr('alt'))
    {
    case first_element.attr('alt'):
      var next_element = current_element.next();
      var previous_element = last_element;
      break;
    case last_element.attr('alt'):
      var next_element = first_element;
      var previous_element = current_element.prev();
      break;
    default:
      var next_element = current_element.next();
      var previous_element = current_element.prev();
    }

    jQuery("#image_number").text(current_element.attr("alt")+"/"+set.length);
    jQuery("a#forward_link").attr('href',product_address+"?image="+next_element.attr('alt'));
    jQuery("a#backward_link").attr('href',product_address+"?image="+previous_element.attr('alt'));

  });

  jQuery("a#backward_link").click(function(e) {
    e.preventDefault();

    var product_address = window.location.pathname;
    var set = jQuery(".main_image");
    var current_element = set.filter(":visible");

    current_element.css('display','none');

    var last_element = set.last();
    var first_element = set.first();

    if(current_element.attr('alt')==first_element.attr('alt'))
    {
      current_element = last_element;
    }
    else
    {
      current_element = current_element.prev();
    }

    current_element.css('display','block')

    switch(current_element.attr('alt'))
    {
    case first_element.attr('alt'):
      var next_element = current_element.next();
      var previous_element = last_element;
      break;
    case last_element.attr('alt'):
      var next_element = first_element;
      var previous_element = current_element.prev();
      break;
    default:
      var next_element = current_element.next();
      var previous_element = current_element.prev();
    }

    jQuery("#image_number").text(current_element.attr("alt")+"/"+set.length);
    jQuery("a#forward_link").attr('href',product_address+"?image="+next_element.attr('alt'));
    jQuery("a#backward_link").attr('href',product_address+"?image="+previous_element.attr('alt'));
  });
};

