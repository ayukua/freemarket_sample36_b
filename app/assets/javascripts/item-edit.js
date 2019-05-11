document.addEventListener('DOMContentLoaded', function() {
  if (window.location.href.match(/\/products\/\d+\/edit/)) {
    var inputFile0 = document.getElementById('product_images_attributes_0_image');
    var imagesLists = document.getElementById('images-lists');
    var postArea = document.getElementsByClassName('post-images')[0];
    var imagesContainer = document.getElementById('item-images-container');
    var imagesLists2 = document.getElementById('images-lists2');
    var imagesContainer2 = document.getElementById('item-images-container2');
    var imagePostClearfix = document.getElementById('images-post-clearfix');
    var erasingSentence = document.getElementById('erasing-sentence');
    var countLists = document.querySelectorAll('#images-lists > li');
    var countLists2 = document.querySelectorAll('#images-lists2 > li');
    var labels = document.querySelectorAll('label[class="edit-label"]');
    var numForDataList = 0;

    for (var i = 0; i < labels.length; i++) {
      labels[i].nextElementSibling.remove();
      labels[i].remove();
    }

    if (countLists2.length > 0) {
      imagesLists2.classList.remove('hidden');
      imagesContainer2.classList.remove('hidden');
    };

    for (var i = 0; i < countLists.length; i++) {
      countLists[i].setAttribute('data-list', `${numForDataList}`);
      numForDataList++;
    }

    for (var i = 0; i < countLists2.length; i++) {
      countLists2[i].setAttribute('data-list', `${numForDataList}`);
      numForDataList++;
    }

    var num = countLists.length + countLists2.length;
    var labelNum = countLists.length + countLists2.length;
    var newEditLabel = document.createElement('label');
    newEditLabel.setAttribute("for", `product_images_attributes_${num}_image`);
    newEditLabel.classList.add('current');
    newEditLabel.innerHTML = `
    <input type="file" name="product[images_attributes][${num}][image]" id="product_images_attributes_${num}_image">
    <div id="have-${num}-item" class="post-images">
      <h4 id="erasing-sentence">
        ドラッグアンドドロップ
        <br>
        クリックしてファイルをアップロード
      </h4>
    </div>`
    var imagePostClearfix = document.getElementById('images-post-clearfix');
    imagePostClearfix.appendChild(newEditLabel);
    var newEditInput = document.getElementById(`product_images_attributes_${num}_image`);
    newEditInput.addEventListener('change', AddInputFile, false);

    function AddInputFile(evt) {
      var files = evt.target.files;
      for (var i = 0, f; f = files[i]; i++) {
        if (!f.type.match('image.*')) {
          continue;
        }
        var reader = new FileReader();

        reader.onload = (function(theFile) {
          return function(e) {
            console.log(numForDataList);
            num++;
            labelNum++;
            numForDataList++;
            document.querySelector(`label[for='product_images_attributes_${numForDataList - 1}_image']`).classList.add('hidden');
            document.querySelector(`label[for='product_images_attributes_${numForDataList - 1}_image']`).classList.remove('current');
            var newLabel = document.createElement('label');
            newLabel.setAttribute('for', `product_images_attributes_${labelNum}_image`);
            newLabel.classList.add('current');
            newLabel.innerHTML = `
    <input type="file" name="product[images_attributes][${labelNum}][image]" id="product_images_attributes_${labelNum}_image">
    <div id="have-${num}-item" class="post-images">
      <h4 id="erasing-sentence">
        ドラッグアンドドロップ
        <br>
        クリックしてファイルをアップロード
      </h4>
    </div>`
            imagePostClearfix.appendChild(newLabel);
            document.getElementById(`product_images_attributes_${labelNum}_image`).addEventListener('change', AddInputFile, false);
            function createList() {
              console.log(numForDataList);
              var li = document.createElement('li');
              li.setAttribute('data-list', `${numForDataList - 1}`);
              var figure = document.createElement('figure');
              figure.classList.add('item-figure');
              var img = document.createElement('img');
              img.src = e.target.result;
              img.classList.add('item-image');
              img.title = escape(theFile.name);
              var clearfixDiv = document.createElement('div');
              clearfixDiv.classList.add('clearfix');
              var edit = document.createElement('a');
              var remove = document.createElement('a');
              edit.setAttribute("id", "edit");
              remove.setAttribute("id", "remove");
              edit.textContent = "編集";
              remove.textContent = "削除";
              li.appendChild(figure);
              figure.appendChild(img);
              li.appendChild(clearfixDiv);
              clearfixDiv.appendChild(edit);
              clearfixDiv.appendChild(remove);
              console.log(num);
              remove.addEventListener('click', function() {
                var getNum = this.parentNode.parentNode.getAttribute('data-list');
                this.parentNode.parentNode.remove();
                this.parentNode.remove();
                this.remove();
                document.querySelector(`label[for='product_images_attributes_${getNum}_image']`).remove();
                num--;
                document.getElementById(`have-${num + 1}-item`).setAttribute('id', `have-${num}-item`);
                imagePostClearfix.appendChild(newLabel);
                var newInput = document.getElementById(`product_images_attributes_${labelNum}_image`);
                newInput.addEventListener('change', AddInputFile, false);
                if ( num < 6 ) {
                  imagesLists2.classList.add('hidden');
                  imagesContainer2.classList.add('hidden');
                }
              }, false);
              return li;
            };
            if ( num <= 5 ) {
              var list = createList();
              imagesLists.appendChild(list);
            }else if ( num == 6 ) {
              imagesLists2.classList.remove('hidden');
              imagesContainer2.classList.remove('hidden');
              var list = createList();
              imagesLists2.appendChild(list);
            }else if ( num > 6 ) {
              var list = createList();
              imagesLists2.appendChild(list);
            }
          };
        })(f);
        reader.readAsDataURL(f);
      }
    }

    var editRemove = document.querySelectorAll('.clearfix > .remove');
    for (var i = 0; i < editRemove.length; i++) {
      editRemove[i].addEventListener('click', function() {
        var checkBoxNum = this.parentNode.parentNode.getAttribute('data-list');
        var checkBox = document.querySelector(`input[id='product_images_attributes_${checkBoxNum}__destroy']`);
        console.log(checkBox);
        checkBox.checked = true;
        this.parentNode.parentNode.remove();
        this.parentNode.remove();
        this.remove();
        num--;
        var currentLabel = document.getElementsByClassName('current');
        currentLabel[0].lastElementChild.setAttribute('id', `have-${num}-item`);
        if ( num < 6 ) {
          imagesLists2.classList.add('hidden');
          imagesContainer2.classList.add('hidden');
        }
      }, false);
    }


    var inputPrice = document.getElementById('product_price');
    var commission = document.getElementById('commission-result');
    var benefit = document.getElementById('benefit-result');
    var hundredsPattern = /^[3-9]\d{2}$/;
    var morePattern = /^[1-9]\d{3,6}$/;

    function priceContent() {
      if ( hundredsPattern.test(inputPrice.value) || morePattern.test(inputPrice.value) ) {
        var commissionResult = separate(Math.floor( inputPrice.value / 10 ));
        commission.textContent = "¥" + commissionResult;
        var benefitResult = separate( inputPrice.value - Math.floor( inputPrice.value / 10 ) );
        benefit.textContent = "¥" + benefitResult;
      }else {
        commission.textContent = "-";
        benefit.textContent = "-";
      };
    }
    priceContent();

    inputPrice.addEventListener('keyup', function() {
      priceContent();
    });

    function separate(num){
      return String(num).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
    }

    var parentCategory = document.getElementById('product_parent_category_id');
    var childCategory = document.getElementsByClassName('childCategory');
    var grandchildCategory = document.getElementsByClassName('grandchildCategory');
    var categoryForm = document.getElementById('category-form');
    var shippingMethod = document.getElementById('shipping-method-select');
    var feePayer = document.getElementById('product_delivery_fee_payer');
    feePayer.addEventListener('change', function() {
      if (feePayer.value !== "") {
        shippingMethod.classList.remove('hidden');
      }else if (feePayer.value === "") {
        shippingMethod.classList.add('hidden');
      };
    });
  };
});
