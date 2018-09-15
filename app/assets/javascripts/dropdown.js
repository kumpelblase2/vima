$(document).ready(() => {
    $('.dropdown-trigger').click(event => {
        $(event.currentTarget.parentNode).toggleClass('is-active');
    });

    $(document).click(event => {
        const dropdownParent = $(event.target).parentsUntil('.dropdown');
        if(dropdownParent.get(dropdownParent.length - 1) === document.children[0]) {
            $('.dropdown').removeClass('is-active');
        }
    });
});
