jQuery.fn.slideShow = function() {
  jQuery('#gallery').cycle({
    fx: 'fade',
    speed: 1500,
    timeout: 6000,
    pause: 1,
    width: 250,
    height: 400
  });
};

