const searchBtn = document.getElementById('expand-search');
const searchForm = document.querySelector('form.search-form');
const menuBtn = document.getElementById('expand-menu');
const mobileMenu = document.getElementById('mobile-menu');

searchBtn.onclick = () => {
    searchForm.classList.toggle('show');
};

menuBtn.onclick = () => {
    mobileMenu.classList.toggle('hide');
};