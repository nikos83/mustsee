
var myOnload =   window.onload = (event) => {
  window.vid = document.getElementById('mustsee-video');
  window.getName = document.querySelector('.film-name').textContent;
  if (!(localStorage.getItem(window.getName) ===  null)) {
    window.vid.currentTime = localStorage.getItem(window.getName);
  }
  window.vid .onpause = function() {onPauseFunction()};

  function onPauseFunction() {
    localStorage.setItem(window.getName, window.vid.currentTime);
  }
};
$(document).on('turbolinks:load', myOnload);
