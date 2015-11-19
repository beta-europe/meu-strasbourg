---
#
# Use the widgets beneath and the content will be
# inserted automagically in the webpage. To make
# this work, you have to use › layout: frontpage
#
layout: frontpage
header:
  image_fullwidth: header-meu2015.jpg
widget1:
  title: Model European Union
  url: 'http://domain.de/must-be-absolut-url-like-this-one/'
  image: /images/cards-placards.jpg
  text: |
    Participate in one of the most realistic EU politics simulations in the role
    of a member of the parliament, an interpreter, the press, etc.
widget2:
  title: City of Strasbourg
  url: 'http://domain.de/must-be-absolut-url-like-this-one/'
  image: /images/cards-city.jpg
  text: |
    The conference will take place in Strasbourg. Find out more about the truly
    European city you are going to explore during your stay.
widget3:
  title: "Partners"
  url: 'http://domain.de/must-be-absolut-url-like-this-one/'
  image: /images/cards-parliament.jpg
  text: |
    Our conference would not be possible without the support of our numerous
    partners, supporters and sponsors. Get to known them and learn how to join
    our project.
#
# Use the call for action to show a button on the frontpage
#
# To make internal links, just use a permalink like this
# url: /getting-started/
#
# To style the button in different colors, use no value
# to use the main color or success, alert or secondary.
# To change colors see sass/_01_settings_colors.scss
#
callforaction:
  url: https://tinyletter.com/feeling-responsive
  text: Inform me about new updates and features ›
  style: alert
permalink: /index.html
---
<div id="videoModal" class="reveal-modal large" data-reveal="">
  <div class="flex-video widescreen vimeo" style="display: block;">
    <iframe width="1280" height="720" src="https://www.youtube.com/embed/3b5zCFSmVvU" frameborder="0" allowfullscreen></iframe>
  </div>
  <a class="close-reveal-modal">&#215;</a>
</div>
