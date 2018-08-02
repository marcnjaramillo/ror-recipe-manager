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
        $('.container-page').html('')
        recipes.forEach(recipe => {
          let newRecipe = new Recipe(recipe)
          let recipeHtml = newRecipe.formatIndex()
          $('.container-page').append(recipeHtml)
        })
      })
  })
}
//=======This function is firing because BS4 has a .show in the dropdown menu======
  // $(document).on('click', ".show", function(event) {
  //   event.preventDefault()
  //   let id = $(this).attr('data-id')
  //   history.pushState(null, null, `/recipes/${id}`)
  //   fetch(`/recipes/${id}.json`)
  //   .then(response => response.json())
  //   .then(recipe => {
  //     //$('.search-box').html('')
  //     $('.container-page').html('')
  //     let newRecipe = new Recipe(recipe)
  //     let recipeHtml = newRecipe.formatShow()
  //     $('.container-page').append(recipeHtml)
  //   })
  // })

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


function Comment(comment) {
  this.id = comment.id;
  this.content = comment.content;
  this.user = comment.user;
}

Comment.prototype.formatShow = function() {
  var html = "" ;
  html += "<div id=\'comment-\' + comment.id + '\'>" +  "<strong>" + this.user.username + "</strong>" + ": " + this.content + "</div>";
  $("#submitted-comments").append(html);
}

$(function() {
  $("form#new_comment").on("submit", function(event) {
    event.preventDefault();
    var $form = $(this);
    var action = $form.attr("action");

    var params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      dataType: "json",
      method: "POST"
    })
    .success(function(json) {
      $(".commentBox").val("");
      var comment = new Comment(json);
      comment.formatShow();

    })
  })
})
