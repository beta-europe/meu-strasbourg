$(document).ready ->

  # collapsable menu
  $(".button-collapse").sideNav(edge: 'left')
  
  
  $('.slider').slider(full_width: true)
  $('.parallax').parallax()
  $('.modal-trigger').leanModal()
  $('.scrollspy').scrollSpy()
  
  # Detect touch screen and enable scrollbar if necessary
  is_touch_device = ->
    try
      document.createEvent("TouchEvent");
      return true
    catch error
      return false
      
  if is_touch_device()
    $('#nav-mobile').css( overflow: 'auto')