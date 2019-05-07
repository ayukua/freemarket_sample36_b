document.addEventListener('DOMContentLoaded', function(e) {
  var inputFile0 = document.getElementById('product_images_attributes_0_image');
  var imagesLists = document.getElementById('images-lists');
  var postArea = document.getElementsByClassName('post-images')[0];
  var imagesContainer = document.getElementById('item-images-container');
  var imagesLists2 = document.getElementById('images-lists2');
  var imagesContainer2 = document.getElementById('item-images-container2');
  var imagePostClearfix = document.getElementById('images-post-clearfix');
  var erasingSentence = document.getElementById('erasing-sentence');
  var num = 0;

  function AddInputFile(evt) {
    var files = evt.target.files;
    for (var i = 0, f; f = files[i]; i++) {
      if (!f.type.match('image.*')) {
        continue;
      }
      var reader = new FileReader();

      reader.onload = (function(theFile) {
        return function(e) {
          num++;
          console.log(num);
          document.getElementById(`images_attributes_${num - 1}_label`).classList.add('hidden');
          var newLabel = document.createElement('label');
          newLabel.setAttribute('for', `product_images_attributes_${num}_image`);
          newLabel.setAttribute('id', `images_attributes_${num}_label`);
          newLabel.innerHTML = `
  <input type="file" name="product[images_attributes][${num}][image]" id="product_images_attributes_${num}_image">
  <div id="have-${num}-item" class="post-images">
    <h4 id="erasing-sentence">
      ドラッグアンドドロップ
      <br>
      クリックしてファイルをアップロード
    </h4>
  </div>`
          console.log(newLabel);
          imagePostClearfix.appendChild(newLabel);
          document.getElementById(`product_images_attributes_${num}_image`).addEventListener('change', AddInputFile, false);
          function createList() {
            var li = document.createElement('li');
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
            remove.addEventListener('click', function() {
              console.log(num);
              this.parentNode.parentNode.remove();
              this.parentNode.remove();
              this.remove();
              document.getElementById(`images_attributes_${num - 1}_label`).remove();
              document.getElementById(`images_attributes_${num}_label`).remove();
              // document.getElementById('erasing-sentence').parentNode.previousSibling.remove();
              // document.getElementById('erasing-sentence').parentNode.remove();
              // document.getElementById('erasing-sentence').remove();
              num--;
              console.log(num);
              var newLabel = document.createElement('label');
              newLabel.setAttribute('for', `product_images_attributes_${num}_image`);
              newLabel.setAttribute('id', `images_attributes_${num}_label`);
              newLabel.innerHTML = `
      <input type="file" name="product[images_attributes][${num}][image]" id="product_images_attributes_${num}_image">
      <div id="have-${num}-item" class="post-images">
        <h4 id="erasing-sentence">
          ドラッグアンドドロップ
          <br>
          クリックしてファイルをアップロード
        </h4>
      </div>`
              imagePostClearfix.appendChild(newLabel);
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
            // changePostArea();
          }else if ( num == 6 ) {
            imagesLists2.classList.remove('hidden');
            imagesContainer2.classList.remove('hidden');
            var list = createList();
            imagesLists2.appendChild(list);
            // changePostArea();
          }else if ( num > 6 ) {
            var list = createList();
            imagesLists2.appendChild(list);
            // changePostArea();
          }
        };
      })(f);
      reader.readAsDataURL(f);
    }
  }
  inputFile0.addEventListener('change', AddInputFile, false);

  var inputPrice = document.getElementById('product_price');
  var commission = document.getElementById('commission-result');
  var benefit = document.getElementById('benefit-result');
  var hundredsPattern = /^[3-9]\d{2}$/;
  var morePattern = /^[1-9]\d{3,6}$/;
  inputPrice.addEventListener('keyup', function() {
    if ( hundredsPattern.test(inputPrice.value) || morePattern.test(inputPrice.value) ) {
      var commissionResult = separate(Math.floor( inputPrice.value / 10 ));
      commission.textContent = "¥" + commissionResult;
      var benefitResult = separate( inputPrice.value - Math.floor( inputPrice.value / 10 ) );
      benefit.textContent = "¥" + benefitResult;
    }else {
      commission.textContent = "-";
      benefit.textContent = "-";
    };
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
});

