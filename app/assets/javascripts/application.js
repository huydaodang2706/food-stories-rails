// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, ut if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs

//= require_tree .

$(function () {
  var storyArray = [];
  var id = parseInt($(".js-next").attr("data-id"));

  if ($("#storiesInfo").length) {
    loadAllStories();
  }

  function loadAllStories() {
    $.ajax({
      url: "/stories.json",
      method: 'GET'
    })
    // promise
    .then(function(data) {
       storyArray = data;
       $.each(
         storyArray, function(index, story) {
           var storyData = "<p><a href='/stories/" + story.id + "'>"
            + story.title + "</a><div id='content-" + story.id + "'>"
            + story.content.substring(0, 250) + "..."
            + "<a href='#' data-id='" + story.id + "' class='js-more'>Read More</a></div><br>";
           $('#storiesInfo').append(storyData);
         }
       )
     });
  }


// For the stories index page

  $("#storiesInfo").on('click', '.js-more', function(e) {
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/stories/" + id + ".json", function(data) {
      $("#content-" + id).html(data.content)
    });
  });

// For the Users stories Page

  $("#userStoriesInfo").on('click', '.js-more', function(e) {
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/stories/" + id + ".json", function(data) {
     $("#content-" + id).html(data.content);

    });
  });

// For the Users Show Page

  $("#userStoriesShowInfo").on('click', '.js-more', function(e) {
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/stories/" + id + ".json", function(data) {
     $("#content-" + id).html(data.content);

    });
  });

// For the stories Show page

  function loadStory(data) {
      history.pushState({}, "", "/stories/" + data.id)
      var storyCommentPath = '/stories/' + data.id + '/comments/';
      $("#new_comment").attr('action', storyCommentPath);
      $(".storyTitle").text(data["title"]);
      $(".storyUserName").text(data["user"]["name"]);
      $(".storyLocation").text(data["location"]);
      $(".storyFoodName").text(data["food"]["name"]);
      $(".storyFoodCategory").text(data["food"]["category"]);
      $(".storyContent").text(data["content"]);
      $(".storyRecommendation").text(data["recommendation"]);
      $(".js-next").attr("data-id", data["id"]);
      $(".js-previous").attr("data-id",data["id"]);
      $("#submitted-comments").empty();
      data["comment_list"].forEach(function(element){
        var comment = new Comment(element);
        comment.renderDisplay();
      });


  }

  $(".js-next").on("click", function(event) {
    var id = $(".js-next").attr("data-id")
    $.get("/stories/" + id + "/next", function(data) {
      console.log(data)
      loadStory(data);
    });
    event.preventDefault();
  });

  $(".js-previous").on("click", function(event) {
    var id = $(".js-previous").attr("data-id")
    $.get("/stories/" + id + "/previous", function(data) {
      console.log(data)
      loadStory(data);
    });
    event.preventDefault();

  });

});



function Comment(data) {
  this.id = data.id;
  this.content = data.content;
  this.user = data.user;
}



Comment.prototype.renderDisplay = function() {
  var html = "" ;
  html += "<div class=\'well well-white\' id=\'comment-\' + comment.id + '\'>" +  "<strong>" + this.user.name + "</strong>" + " says: " + this.content + "</div>";
  $("#submitted-comments").append(html);
}

$(function() {
  $("form#new_comment").on("submit", function(event) {
    event.preventDefault();
    var $form = $(this);
    var action = $form.attr("action");
    // in order to process the comment(form data), its need to be converted from an object to a string.
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
      comment.renderDisplay();

    })
  })
})
