const input = document.getElementById('sub-choices');
const options = input.list.options;
const optionsArr = Array.from(options).map((el) => el.value.toLowerCase());
const addSubBtn = document.getElementById('add-sub');
const errorDiv = document.getElementById('no-match');

// input.oninput = (e) => {
//     let value = e.target.value;
//     let idx = optionsArr.indexOf(value);
    
//     if(idx > -1) {
//         const checkbox = document.getElementById(options[idx].dataset.subid);
//         checkbox.checked = true;
//         checkbox.parentElement.classList.remove('hide');
//     }
// };

addSubBtn.onclick = (e) => {
    let value = input.value.toLowerCase();
    let idx = optionsArr.indexOf(value);

    if(idx > -1) {
        const checkbox = document.getElementById(options[idx].dataset.subid);
        checkbox.checked = true;
        checkbox.parentElement.classList.remove('hide');
        input.value = '';
    }
    else {
        input.setCustomValidity('Sub does not exist');
        errorDiv.classList.remove('invisible');
    }

    e.preventDefault();
};

input.oninput = () => {
    input.setCustomValidity('');
    if(!errorDiv.classList.contains('invisible')) errorDiv.classList.add('invisible');
};