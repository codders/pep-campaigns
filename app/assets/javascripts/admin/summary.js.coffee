jQuery ->
  jQuery('body').on 'submit', 'form.toggle-answer', (e) ->
    e.preventDefault()
    form = jQuery(@)
    jQuery.ajax
      url: form.attr('action')
      method: 'PUT'
      success: (data) ->
        form.replaceWith(jQuery(data).find('form'))
