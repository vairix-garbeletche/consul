App.CustomDocumentable =

  initialize: ->

    inputFiles = $('.js-document-attachment')
    $.each inputFiles, (index, input) ->
      App.CustomDocumentable.initializeDirectUploadInput(input)

    $('[id^="nested-documents"]').on 'cocoon:after-remove', (e, insertedItem) ->
      App.CustomDocumentable.unlockUploads()

    $('[id^="nested-documents"]').on 'cocoon:after-insert', (e, nested_document) ->
      input = $(nested_document).find('.js-document-attachment')
      App.CustomDocumentable.initializeDirectUploadInput(input)

      if $(nested_document).closest('[id^="nested-documents"]').find('.document:visible').length >= $('[id^="nested-documents"]').data('max-documents-allowed')
        App.CustomDocumentable.lockUploads()

  initializeDirectUploadInput: (input) ->

    inputData = @buildData([], input)

    @initializeRemoveCachedDocumentLink(input, inputData)

    $(input).fileupload

      paramName: "attachment"

      formData: null

      add: (e, data) ->
        data = App.CustomDocumentable.buildFileUploadData(e, data)
        App.CustomDocumentable.clearProgressBar(data)
        App.CustomDocumentable.setProgressBar(data, 'uploading')
        data.submit()

      change: (e, data) ->
        $.each data.files, (index, file) ->
          App.CustomDocumentable.setFilename(inputData, file.name)

      fail: (e, data) ->
        $(data.cachedAttachmentField).val("")
        App.CustomDocumentable.clearFilename(data)
        App.CustomDocumentable.setProgressBar(data, 'errors')
        App.CustomDocumentable.clearInputErrors(data)
        App.CustomDocumentable.setInputErrors(data)
        $(data.destroyAttachmentLinkContainer).find("a.delete:not(.remove-nested)").remove()
        $(data.addAttachmentLabel).addClass('error')
        $(data.addAttachmentLabel).show()

      done: (e, data) ->
        $(data.cachedAttachmentField).val(data.result.cached_attachment)
        App.CustomDocumentable.setTitleFromFile(data, data.result.filename)
        App.CustomDocumentable.setProgressBar(data, 'complete')
        App.CustomDocumentable.setFilename(data, data.result.filename)
        App.CustomDocumentable.clearInputErrors(data)
        $(data.addAttachmentLabel).hide()
        $(data.wrapper).find(".attachment-actions").removeClass('small-12').addClass('small-6 float-right')
        $(data.wrapper).find(".attachment-actions .action-remove").removeClass('small-3').addClass('small-12')

        destroyAttachmentLink = $(data.result.destroy_link)
        $(data.destroyAttachmentLinkContainer).html(destroyAttachmentLink)
        $(destroyAttachmentLink).on 'click', (e) ->
          e.preventDefault()
          e.stopPropagation()
          App.CustomDocumentable.doDeleteCachedAttachmentRequest(this.href, data)

      progress: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $(data.progressBar).find('.loading-bar').css 'width', progress + '%'
        return

  buildFileUploadData: (e, data) ->
    data = @buildData(data, e.target)
    return data

  buildData: (data, input) ->
    wrapper = $(input).closest('.direct-upload')
    data.input = input
    data.wrapper = wrapper
    data.progressBar = $(wrapper).find('.progress-bar-placeholder')
    data.errorContainer = $(wrapper).find('.attachment-errors')
    data.fileNameContainer = $(wrapper).find('p.file-name')
    data.destroyAttachmentLinkContainer = $(wrapper).find('.action-remove')
    data.addAttachmentLabel = $(wrapper).find('.action-add label')
    data.cachedAttachmentField = $(wrapper).find("input[name$='[cached_attachment]']")
    data.titleField = $(wrapper).find("input[name$='[title]']")
    $(wrapper).find('.progress-bar-placeholder').css('display', 'block')
    return data

  clearFilename: (data) ->
    $(data.fileNameContainer).text('')
    $(data.fileNameContainer).hide()

  clearInputErrors: (data) ->
    $(data.errorContainer).find('small.error').remove()

  clearProgressBar: (data) ->
    $(data.progressBar).find('.loading-bar').removeClass('complete errors uploading').css('width', "0px")

  setFilename: (data, file_name) ->
    $(data.fileNameContainer).text(file_name)
    $(data.fileNameContainer).show()

  setProgressBar: (data, klass) ->
    $(data.progressBar).find('.loading-bar').addClass(klass)

  setTitleFromFile: (data, title) ->
    if $(data.titleField).val() == ""
      $(data.titleField).val(title)

  setInputErrors: (data) ->
    errors = '<small class="error">' + data.jqXHR.responseJSON.errors + '</small>'
    $(data.errorContainer).append(errors)

  lockUploads: ->
    $('#max-documents-notice').removeClass('hide')
    $('.new-document-link').addClass('hide')

  unlockUploads: ->
    $('#max-documents-notice').addClass('hide')
    $('.new-document-link').removeClass('hide')

  doDeleteCachedAttachmentRequest: (url, data) ->
    $.ajax
      type: "POST"
      url: url
      dataType: "json"
      data: { "_method": "delete" }
      complete: ->
        $(data.cachedAttachmentField).val("")
        $(data.addAttachmentLabel).show()

        App.CustomDocumentable.clearFilename(data)
        App.CustomDocumentable.clearInputErrors(data)
        App.CustomDocumentable.clearProgressBar(data)

        App.CustomDocumentable.unlockUploads()
        $(data.wrapper).find(".attachment-actions").addClass('small-12').removeClass('small-6 float-right')
        $(data.wrapper).find(".attachment-actions .action-remove").addClass('small-3').removeClass('small-12')

        if $(data.input).data('nested-document') == true
          $(data.wrapper).remove()
        else
          $(data.wrapper).find('a.remove-cached-attachment').remove()

  initializeRemoveCachedDocumentLink: (input, data) ->
    wrapper = $(input).closest(".direct-upload")
    remove_document_link = $(wrapper).find('a.remove-cached-attachment')
    $(remove_document_link).on 'click', (e) ->
      e.preventDefault()
      e.stopPropagation()
      App.CustomDocumentable.doDeleteCachedAttachmentRequest(this.href, data)

  removeDocument: (id) ->
    $('#' + id).remove()
