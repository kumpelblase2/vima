$(document).ready(() => {
    $('.dropdown-trigger').click(event => {
        $(event.currentTarget.parentNode).toggleClass('is-active');
    });
});
