const replyBtns = Array.from(document.getElementsByClassName('reply-btn'));
const showRepliesBtns = Array.from(document.getElementsByClassName('show-replies'));

replyBtns.forEach((btn) => {
    btn.onclick = (e) => {
        const siblingId = e.target.id.replace('comment', 'form');
        document.getElementById(siblingId).classList.toggle('hide');
        // e.preventDefault();
    };
});

showRepliesBtns.forEach((btn) => {
    btn.onclick = (e) => {
        const comments = Array.from(e.target.parentElement.getElementsByClassName('indent'));
        comments.forEach((c, idx) => {
            if(idx > 0) c.classList.toggle('hide');
        });
    };
});