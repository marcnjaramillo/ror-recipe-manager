$(document).ready(function() {
  $("#new_ingredient_button").click(function(event) {
    var $button = $(this);
    var url = $(this).data("url")

    $.get(url, function(response) {
      $button.before(response)
    })
    event.preventDefault();
      // addNewIngredient();
  });
});

// var addNewIngredient = function() {
//    var $new_ingredients = $("#new_ingredients");
//    var new_index = $("#new_ingredients input").length / 2;
//    var ingredientInput = `<name="recipe[ingredients_attributes][${new_index}][name]" id="recipe_ingredients_attributes_${new_index}_name"> `;
//    ingredientInput += `< name="recipe[ingredients_attributes][${new_index}][recipe_ingredients_attributes][0][quantity]" id="recipe_ingredients_attributes_${new_index}_recipe_ingredients_attributes_0_quantity">`
//    $new_ingredients.append(ingredientInput);
// }
