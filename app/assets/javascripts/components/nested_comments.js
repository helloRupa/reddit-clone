const replyBtns = Array.from(document.getElementsByClassName('reply-btn'));

replyBtns.forEach((btn) => {
    btn.onclick = (e) => {
        const siblingId = e.target.id.replace('comment', 'form');
        document.getElementById(siblingId).classList.toggle('hide');
        e.preventDefault();
    };
});