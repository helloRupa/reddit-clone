const modal = document.getElementById('delete-account');
const overlay = document.getElementById('overlay');
const body = document.body;

document.getElementById('delete_user').onclick = () => {
    overlay.classList.remove('hide');
    modal.classList.remove('hide');
    body.classList.add('no-scroll');
};

document.getElementById('keep_account').onclick = () => {
    overlay.classList.add('hide');
    modal.classList.add('hide');
    body.classList.remove('no-scroll');
};