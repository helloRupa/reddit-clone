const replyBtns = Array.from(document.getElementsByClassName('reply-btn'));
const showRepliesBtns = Array.from(document.getElementsByClassName('show-replies'));
const url = new URL(window.location.href);
const cId = url.searchParams.get('show_cid');

replyBtns.forEach((btn) => {
    btn.onclick = (e) => {
        const siblingId = e.target.id.replace('comment', 'form');
        document.getElementById(siblingId).classList.toggle('hide');
    };
});

showRepliesBtns.forEach((btn) => {
    btn.onclick = (e) => {
        const comments = Array.from(e.target.parentElement.getElementsByClassName('flat'));
        comments.forEach((c, idx) => {
            if(idx > 0) c.classList.toggle('hide');
        });
    };
});

if(cId) {
    const cDiv = document.getElementById(cId);

    if (cDiv.parentElement.classList.contains('flat')) {
        let parent = cDiv.parentElement;

        while(!parent.classList.contains('parent')){
            parent = parent.parentElement;
        }

        Array.from(parent.getElementsByClassName('flat')).forEach((c, idx) => {
            if(idx > 0) c.classList.toggle('hide');
        });
    }

    cDiv.scrollIntoView();
}

