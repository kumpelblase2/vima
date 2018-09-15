$(document).ready(() => {
    $('.dropdown-trigger').click(event => {
        $(event.currentTarget.parentNode).toggleClass('is-active');
    });

    $(document).click(event => {
        if(!event.target.parentElement.className.includes("dropdown-trigger")) {
            $('.dropdown').removeClass('is-active');
        }
    });
});
