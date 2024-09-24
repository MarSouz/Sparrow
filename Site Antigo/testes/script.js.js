// script.js

// Função para manipular o slider
document.addEventListener('DOMContentLoaded', function() {
    const sliderItems = document.querySelectorAll('.slider-item');
    const nextButton = document.querySelector('.next');
    const prevButton = document.querySelector('.prev');
    let currentIndex = 0;

    function showSliderItem(index) {
        sliderItems.forEach((item, i) => {
            if (i === index) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        });
    }

    nextButton.addEventListener('click', function() {
        currentIndex = (currentIndex + 1) % sliderItems.length;
        showSliderItem(currentIndex);
    });

    prevButton.addEventListener('click', function() {
        currentIndex = (currentIndex - 1 + sliderItems.length) % sliderItems.length;
        showSliderItem(currentIndex);
    });

    showSliderItem(currentIndex); // Mostrar o primeiro item
});

// Função para controlar o preloader
window.addEventListener('load', function() {
    const preloader = document.querySelector('.preloader');
    preloader.style.display = 'none';
});

// Função para alternar a exibição do menu de navegação
const menuToggle = document.getElementById('menu-toggle');
menuToggle.addEventListener('change', function() {
    const navOverlay = document.querySelector('.nav-overlay');
    if (menuToggle.checked) {
        navOverlay.style.display = 'block';
    } else {
        navOverlay.style.display = 'none';
    }
});
