/*=========================================================================================
    File Name: app-todo.js
    Description: app-todo
    ----------------------------------------------------------------------------------------
    Item Name: Modern Admin - Clean Bootstrap 4 Dashboard HTML Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

// Todo App variables
var todoNewTasksidebar = $(".todo-new-task-sidebar"),
  appContentOverlay = $(".app-content-overlay"),
  todoTaskListWrapper = $(".todo-task-list-wrapper"),
  todoItem = $(".todo-item"),
  markCompleteBtn = $(".mark-complete-btn"),
  taskTitle = $(".task-title"),
  noResults = $(".no-results"),
  assignedAvatarContent = $(".assigned .avatar .avatar-content"),
  todoAppMenu = $(".todo-app-menu");

// badge colors object define here for badge color
var badgeColors = {
  "Frontend": "badge-primary",
  "Backend": "badge-success",
  "Issue": "badge-danger",
  "Design": "badge-warning",
  "Wireframe": "badge-info",
}

$(function () {
  "use strict";

  //perfect scrollbar
  if (!$.app.menu.is_touch_device()) {

    // Sidebar scrollbar
    if ($('.todo-application .sidebar-menu-list').length > 0) {
      new PerfectScrollbar('.sidebar-menu-list', {
        theme: "dark",
        wheelPropagation: false
      });
    }

    //  New task scrollbar
    if (todoNewTasksidebar.length > 0) {
      new PerfectScrollbar('.todo-new-task-sidebar', {
        theme: "dark",
        wheelPropagation: false
      });
    }
  } else {
    $('.sidebar-menu-list').css('overflow', 'scroll');
    $('.todo-new-task-sidebar').css('overflow', 'scroll');
    $('.todo-task-list').css('overflow', 'scroll');
  }

  // **************Sidebar Left**************//
  // -----------------------------------------

  // Main menu toggle should hide app menu
  $('.menu-toggle').on('click', function () {
    sideBarLeft.removeClass('show');
    appContentOverlay.removeClass('show');
    todoNewTasksidebar.removeClass('show');
  });

  //on click of app overlay removeclass show from sidebar left and overlay
  appContentOverlay.on('click', function () {
    sideBarLeft.removeClass('show');
    appContentOverlay.removeClass('show');
  });

  // Add class active on click of sidebar menu's filters
  todoAppMenu.find(".list-group a").on('click', function () {
    var $this = $(this);
    todoAppMenu.find(".active").removeClass('active');
    $this.addClass("active")
  });

  
  $('.property-card2').on('click', function () {
	$("#updateVO").find("input[name='property_name']").val($(this).find(".card-text").text());
	$("#updateVO").find("input[name='property_id']").val($(this).find("input[type=hidden]").val());
    todoNewTasksidebar.addClass('show');
    appContentOverlay.addClass('show');
  });

  // On sidebar close click hide sidebarleft and overlay
  $(".todo-application .sidebar-close-icon").on('click', function () {
    sideBarLeft.removeClass('show');
    appContentOverlay.removeClass('show');
  });

  // **************New Task sidebar**************//
  // ---------------------------------------------

  // On Click of Close Icon btn, cancel btn and overlay remove show class from new task sidebar and overlay
  // and reset all form fields
  $(".close-icon, .cancel-btn, .app-content-overlay, .mark-complete-btn").on('click', function () {
    todoNewTasksidebar.removeClass('show');
    appContentOverlay.removeClass('show');
    setTimeout(function () {
      todoNewTasksidebar.find('textarea').val("");
      var compose_editor = $(".compose-editor .ql-editor");
      compose_editor[0].innerHTML = "";
      var comment_editor = $(".comment-editor .ql-editor");
      comment_editor[0].innerHTML = "";
      selectAssignLable.attr("disabled", "true");
    }, 100)
  });

  // on click of add label icon select 2 display
  $(".add-tags").on("click", function () {
    if (selectAssignLable.is('[disabled]')) {
      selectAssignLable.removeAttr("disabled");
    } else {
      selectAssignLable.attr("disabled", "true");
    }
  });

  // ************Rightside content************//
  // -----------------------------------------

  // Search filter for task list
  $(document).on("keyup", ".todo-search", function () {
    todoItem = $(".todo-item");
    $('.todo-item').css('animation', 'none')
    var value = $(this).val().toLowerCase();
    if (value != "") {
      todoItem.filter(function () {
        $(this).toggle($(this).text().toLowerCase().includes(value));
      });
      var tbl_row = $(".todo-item:visible").length; //here tbl_test is table name

      //Check if table has row or not
      if (tbl_row == 0) {
        if (!noResults.hasClass('show')) {
          noResults.addClass('show');
        }
      } else {
        noResults.removeClass('show');
      }
    } else {
      // If filter box is empty
      todoItem.show();
      if (noResults.hasClass('show')) {
        noResults.removeClass('show');
      }
    }
  });
  // on Todo Item click show data in sidebar
  var globalThis = ""; // Global variable use in multiple function
  todoTaskListWrapper.on('click', '.todo-item', function (e) {
    var $this = $(this);
    globalThis = $this;

    todoNewTasksidebar.addClass('show');
    appContentOverlay.addClass('show');

    var todoTitle = $this.find(".todo-title").text();
    taskTitle.val(todoTitle);
    var compose_editor = $(".compose-editor .ql-editor");
    compose_editor[0].innerHTML = todoTitle;

    // if avatar is available
    if ($this.find(".avatar img").length) {
      avatarUserImage.removeClass("d-none");
      assignedAvatarContent.addClass("d-none");
    } else {
      avatarUserImage.addClass("d-none");
      assignedAvatarContent.removeClass("d-none");
    }
    //current task's image source assign to variable
    var avatarSrc = $this.find(".avatar img").attr('src');

    avatarUserImage.attr("src", avatarSrc);
    var assignName = $this.attr('data-name');

    $(".select2-users-name").val(assignName).trigger('change');

    // badge selected value check
    if ($(this).find('.badge').length) {
      //if badge available in current task
      var badgevalAll = [];
      var selected = $(this).find('.badge');

      selected.each(function () {
        var badgeVal = $(this).text();
        badgevalAll.push(badgeVal);
        selectAssignLable.val(badgevalAll).trigger("change");
      });
    } else {
      selectAssignLable.val(null).trigger("change");
    }
    // update button has remove class d-none & add class d-none in add todo button
    updateTodo.removeClass("d-none");
    addTodo.addClass("d-none");
    markCompleteBtn.removeClass("d-none");
    newTaskTitle.addClass("d-none");

  }).on('click', '.todo-item-favorite', function (e) {
    e.stopPropagation();
    $(this).toggleClass("warning");
    $(this).find("i").toggleClass("bxs-star");
  }).on('click', '.todo-item-delete', function (e) {
    e.stopPropagation();
    $(this).closest('.todo-item').remove();
  }).on('click', '.custom-checkbox', function (e) {
    e.stopPropagation();
  });

  // Complete task strike through
  todoTaskListWrapper.on('click', ".todo-item .custom-control-input", function (e) {
    $(this).closest('.todo-item').toggleClass("completed");
  });

  // Complete button click action
  markCompleteBtn.on("click", function () {
    globalThis.addClass("completed");
    globalThis.find(".custom-control-input").prop("checked", true);
    selectAssignLable.attr("disabled", "true");
  });

  // Todo sidebar toggle
  $('.sidebar-toggle').on('click', function (e) {
    e.stopPropagation();
    sideBarLeft.toggleClass('show');
    appContentOverlay.addClass('show');
  });

  // sorting task list item
  $(".ascending").on("click", function () {
    todoItem = $(".todo-item");
    $('.todo-item').css('animation', 'none')
    todoItem.sort(sort_li).appendTo(todoTaskListWrapper);

    function sort_li(a, b) {
      return ($(b).find('.todo-title').text()) < ($(a).find('.todo-title').text()) ? 1 : -1;
    }
  });

  // descending sorting
  $(".descending").on("click", function () {
    todoItem = $(".todo-item");
    $('.todo-item').css('animation', 'none')
    todoItem.sort(sort_li).appendTo(todoTaskListWrapper);

    function sort_li(a, b) {
      return ($(b).find('.todo-title').text()) > ($(a).find('.todo-title').text()) ? 1 : -1;
    }
  });
});

$(window).on("resize", function () {
  // remove show classes from sidebar and overlay if size is > 992
  if ($(window).width() > 992) {
    if (appContentOverlay.hasClass('show')) {
      sideBarLeft.removeClass('show');
      appContentOverlay.removeClass('show');
      todoNewTasksidebar.removeClass("show");
    }
  }
});