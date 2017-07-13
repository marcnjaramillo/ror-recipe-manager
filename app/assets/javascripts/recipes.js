// $(document).ready(function() {
//   $("#new_ingredient_button").click(function(event) {
//     var $button = $(this);
//     var url = $(this).data("url")
//
//     $.get(url, function(response) {
//       $button.before(response)
//     })
//     event.preventDefault();
//        addNewIngredient();
//   });
// });
//
// var addNewIngredient = function() {
//     var $new_ingredients = $("#new_ingredients");
//     var ingredientInput = `<name="recipe[ingredients_attributes][][name]">`;
//     ingredientInput += `< name="recipe[ingredients_attributes][][quantity]">`
//     $new_ingredients.append(ingredientInput);
// }


$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $('.all_recipes').on('click', event => {
    event.preventDefault()
    history.pushState(null, null, `/recipes`)
    fetch(`/recipes.json`)
      .then(response => response.json())
      .then(recipes => {
        $('.article').html('')
        recipes.forEach(recipe => {
          let newRecipe = new Recipe(recipe)
          let recipeHtml = newRecipe.formatIndex()
          $('.article').append(recipeHtml)
        })
      })
  })

  $(document).on('click', ".show", function(event) {
    event.preventDefault()
    let id = $(this).attr('data-id')
    history.pushState(null, null, `/recipes/${id}`)
    fetch(`/recipes/${id}.json`)
    .then(response => response.json())
    .then(recipe => {
      //$('.search-box').html('')
      $('.article').html('')
      let newRecipe = new Recipe(recipe)
      let recipeHtml = newRecipe.formatShow()
      $('.article').append(recipeHtml)
    })
  })
}

function Recipe(recipe) {
  this.id = recipe.id
  this.name = recipe.name
  this.prep_time = recipe.prep_time
  this.cook_time = recipe.cook_time
  this.recipe_ingredients = recipe.recipe_ingredients
  this.directions = recipe.directions
}

Recipe.prototype.formatIndex = function() {
  let recipeHtml = `
    <a href="/recipes/${this.id}" data-id="${this.id}" class="show"><h2>${this.name}</h2></a>
  `

  return recipeHtml
}

Recipe.prototype.formatShow = function() {
  let recipeHtml = `
    <h1>${this.name}</h1>
    <p>Prep Time: ${this.prep_time} minutes | Cook Time: ${this.cook_time} minutes</p>
    <h2>Ingredients</h2>
    <ul>
      ${this.recipe_ingredients.map(ri => `<li> ${ri.quantity} ${ri.ingredient} </li>` ).join("")}
    </ul>
    <h2> Directions </h2>
    <ul>
      ${this.directions.map(d => `<li> ${d.text} </li>` ).join("")}
    </ul>
  `

  return recipeHtml
}
