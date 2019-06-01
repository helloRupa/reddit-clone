const input = document.getElementById('sub-choices');
const options = input.list.options;
const optionsArr = Array.from(options).map((el) => el.value);

input.oninput = (e) => {
    let value = e.target.value;
    let idx = optionsArr.indexOf(value);
    
    if(idx > -1) {
        const checkbox = document.getElementById(options[idx].dataset.subid);
        checkbox.checked = true;
        checkbox.parentElement.classList.remove('hide');
    }
};