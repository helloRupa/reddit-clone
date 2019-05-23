document.getElementById('delete_user').onclick = () => {
    const modal = document.getElementById('delete-account');
    modal.classList.remove('hide');
};

document.getElementById('keep_account').onclick = () => {
    const modal = document.getElementById('delete-account');
    modal.classList.add('hide');
};