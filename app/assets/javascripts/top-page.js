(function() {
  'use strict';
  document.addEventListener("DOMContentLoaded", function(e) {
    var menuSecond = document.getElementsByClassName('menu__second');
    var profile = document.querySelectorAll('.mypage-lists li a');

    for (var i = 0; i < menuSecond.length; i++) {
      (function(n) {
        menuSecond.item(n).addEventListener('mouseover', function() {
          menuSecond.item(n).previousElementSibling.classList.add('category-active');
        });

        menuSecond.item(n).addEventListener('mouseout', function() {
          menuSecond.item(n).previousElementSibling.classList.remove('category-active');
        });
      })(i);
    };

    profile.forEach(pf => {
      pf.addEventListener('mouseover', function() {
        pf.lastElementChild.firstElementChild.classList.add('list-arrow-hover');
      });

      pf.addEventListener('mouseout', function() {
        pf.lastElementChild.firstElementChild.classList.remove('list-arrow-hover');
      });
    });
  });

})();

