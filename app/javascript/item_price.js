window.addEventListener('load', function(){

const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
const inputValue = priceInput.value;
console.log(inputValue);

const addTaxDom = document.getElementById("add-tax-price");
addTaxDom.innerHTML = Math.floor(inputValue*0.1)

const profit = document.getElementById("profit");
profit.innerHTML = Math.floor(inputValue - addTaxDom.innerHTML);


})
})

// 引き算できない
// 確認実施300-9,999,999


