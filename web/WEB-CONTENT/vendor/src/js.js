const openPopupButton = document.getElementById('openPopupButton');
const popup = document.getElementById('popup');

openPopupButton.addEventListener('click', function() {
    popup.style.opacity = '1';
    popup.style.visibility = 'visible';
});

document.querySelector('.popup__close').addEventListener('click', function() {
    popup.style.opacity = '0';
    popup.style.visibility = 'hidden';
});