document.addEventListener('DOMContentLoaded', function(e) {
  var inputFile = document.getElementById('product_images_attributes_0_image');
  var some = document.getElementById('erasing-sentence');
  var imagesLists = document.getElementById('images-lists');
  var postArea = document.getElementById('post-images');
  var imagesContainer = document.getElementById('item-images-container');
  var imagesLists2 = document.getElementById('images-lists2');
  var imagesContainer2 = document.getElementById('item-images-container2');
  var num = 0;

  function handleFileSelect(evt) {
    var files = evt.target.files;
    for (var i = 0, f; f = files[i]; i++) {
      if (!f.type.match('image.*')) {
        continue;
      }
      var reader = new FileReader();

      reader.onload = (function(theFile) {
        return function(e) {
          num++;
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
              postArea.classList.remove(`have-${num}-item`);
              this.parentNode.parentNode.remove();
              this.parentNode.remove();
              this.remove();
              num--;
              postArea.classList.add(`have-${num}-item`);
              if ( num < 6 ) {
                imagesLists2.classList.add('hidden');
                imagesContainer2.classList.add('hidden');
              }
            }, false);
            return li;
          };

          function changePostArea() {
            postArea.classList.remove(`have-${num - 1}-item`);
            postArea.classList.add(`have-${num}-item`);
          };

          if ( num <= 5 ) {
            var list = createList();
            imagesLists.appendChild(list);
            changePostArea();
          }else if ( num == 6 ) {
            imagesLists2.classList.remove('hidden');
            imagesContainer2.classList.remove('hidden');
            var list = createList();
            imagesLists2.appendChild(list);
            changePostArea();
          }else if ( num > 6 ) {
            var list = createList();
            imagesLists2.appendChild(list);
            changePostArea();
          }
        };
      })(f);
      reader.readAsDataURL(f);
    }
  }
  inputFile.addEventListener('change', handleFileSelect, false);

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

  // parentCategory.addEventListener('change', function() {
  //   if (this.value !== "" && document.getElementById('item_child_category_id') === null) {
  //     var selectWrap = document.createElement('div');
  //     selectWrap.classList.add('select-wrap');
  //     selectWrap.innerHTML = `<select id="second-category">
  //     <option value="">---</value>
  //     <option value="レディース">レディース</value>
  //     <option value="メンズ">メンズ</value>
  //     <option value="ベビー・キッズ">ベビー・キッズ</value>
  //     <option value="インテリア・住まい・小物">インテリア・住まい・小物</value>
  //     <option value="本・音楽・ゲーム">本・音楽・ゲーム</value>
  //     </select>`;
  //     categoryForm.appendChild(selectWrap);
  //     var childCategory = document.getElementById('item_child_category_id');
  //     childCategory.addEventListener('change', function() {
  //       if (this.value !== "" && document.getElementById('item_grandchild_category_id') === null) {
  //         var selectWrap = document.createElement('div');
  //         selectWrap.classList.add('select-wrap');
  //         selectWrap.innerHTML = `<select id="third-category">
  //         <option value="">---</value>
  //         <option value="">レディース</value>
  //         <option value="">メンズ</value>
  //         <option value="">ベビー・キッズ</value>
  //         <option value="">インテリア・住まい・小物</value>
  //         <option value="">本・音楽・ゲーム</value>
  //         </select>`;
  //         var grandchildCategory = document.getElementById('item_grandchild_category_id');
  //         categoryForm.appendChild(selectWrap);
  //       };
  //     });
  //     childCategory.addEventListener('change', function() {
  //       var grandchildCategory = document.getElementById('item_grandchild_category_id');
  //       if (this.value === "" && grandchildCategory != null) {
  //         grandchildCategory.parentNode.remove();
  //         grandchildCategory.remove();
  //       };
  //     });
  //   }else if (this.value === "") {
  //     var childCategory = document.getElementById('item_child_category_id');
  //     childCategory.parentNode.remove();
  //     childCategory.remove();
  //     if (document.getElementById('item_grandchild_category_id') !== null) {
  //       var grandchildCategory = document.getElementById('item_grandchild_category_id');
  //       grandchildCategory.parentNode.remove();
  //       grandchildCategory.remove();
  //     };
  //   };
  // });

  // var deliveryCost = document.getElementById('item_delivery_fee_payer');
  // var deliveryBox = document.getElementById('delivery-box');
  // deliveryCost.addEventListener('change', function() {
  //   if (this.value !== "" && document.getElementById('how-to-delivery') === null) {
  //     var formHowDelivery = document.createElement('div');
  //     formHowDelivery.classList.add('form-group');
  //     var h3 = document.createElement('h3');
  //     h3.textContent = "配送の方法";
  //     var span = document.createElement('span');
  //     span.textContent = "必須";
  //     h3.appendChild(span);
  //     formHowDelivery.appendChild(h3);
  //     var selectWrap = document.createElement('div');
  //     selectWrap.classList.add('select-wrap');
  //     selectWrap.innerHTML = `<select id="how-to-delivery">
  //     <option value="">---</value>
  //     <option value="0">未定</value>
  //     <option value="1">らくらくメルカリ便</value>
  //     <option value="2">ゆうメール</value>
  //     <option value="3">レターパック</value>
  //     <option value="4">普通郵便（定型・定型外）</value>
  //     <option value="5">クロネコヤマト</value>
  //     <option value="6">ゆうパック</value>
  //     <option value="7">クリックポスト</value>
  //     <option value="8">ゆうパケット</value>
  //     </select>`;
  //     deliveryBox.appendChild(formHowDelivery);
  //     deliveryBox.appendChild(selectWrap);
  //   }else if (this.value === "" && document.getElementById('how-to-delivery') !== null) {
  //     document.getElementById('how-to-delivery').parentNode.previousElementSibling.remove();
  //     document.getElementById('how-to-delivery').parentNode.remove();
  //     document.getElementById('how-to-delivery').remove();
  //   };
  // });
});
