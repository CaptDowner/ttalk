$ ->
  flashCallback = ->
    $(".alert-success#flash_notice").fadeOut()
  $(".alert-success#flash_notice").bind 'click', (ev) =>
    $(".alert-success#flash_notice").fadeOut()
  setTimeout flashCallback, 3000

$ ->
  flashCallback = ->
    $(".flash-message").fadeOut()
  $(".flash-message").bind 'click', (ev) =>
    $(".flash-message").fadeOut()
  setTimeout flashCallback, 3000

