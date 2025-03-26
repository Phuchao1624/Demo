/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// JS/header.js
document.addEventListener('DOMContentLoaded', function () {
    let lastScrollTop = 0;
    const navbar = document.querySelector('.navbar');

    window.addEventListener('scroll', function () {
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        if (scrollTop > lastScrollTop) {
            // Cuộn xuống: ẩn navbar
            navbar.classList.add('hide');
        } else {
            // Cuộn lên: hiện navbar
            navbar.classList.remove('hide');
        }
        lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
    });
});