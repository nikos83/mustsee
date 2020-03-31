var myOnload =   window.onload = (event) => {
  if (!(document.getElementById('new_film') === null )) {
    const form = document.getElementById('new_film');
    const fileInput = document.getElementById('film_cover_img');

    window.addEventListener('paste', e => {
      fileInput.files = e.clipboardData.files;
    });
  };
};
$(document).on('turbolinks:load', myOnload);
