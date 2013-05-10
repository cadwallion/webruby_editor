# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.lines = []
window.sessions = {}

window.Module = {}
window.Module['print'] = (x) ->
  window.lines.push x
  console.log "LINES", x

jQuery ->
  window.MRB = WEBRUBY
    print_level: 1

  window.EditSession = ace.require("ace/edit_session").EditSession

  MRB.run_source($('script[type="text/ruby"]').text())

  window.addOutput = ->
    $(lines).each (index) ->
      $("#output").append("<p>")

      if index == $(lines).length-1
        $("#output").append("=> ")

      $("#output").append(lines[index])

      $("#output").append("</p>")

  window.resetOutput = ->
    $("#output").html(' ')

  window.renderOutput = ->
    resetOutput()
    addOutput()

  if $("#editor")[0]
    editor = ace.edit("editor")
    editor.getSession().setMode("ace/mode/ruby")
    editor.setTheme("ace/theme/monokai")
    editor.commands.addCommand
      name: 'runCode',
      bindKey:
        win: 'Ctrl-Enter',
        mac: 'Command-Enter'
      exec: (e) ->
        window.lines = []
        MRB.run_source editor.getValue()
        renderOutput()

      readOnly: true

    window.sessions['default.rb'] = editor.getSession()
    window.editor = editor

  $('#add_file').click ->
    new_session = new EditSession('')
    new_session.setMode("ace/mode/ruby")
    filename = "untitled#{Object.keys(sessions).length}"
    window.sessions[filename] = new_session
    editor.setSession new_session
    $('#files').append("<a class='session_tab' href='#' data-filename='#{filename}'>#{filename}</a>")

    return false

  $(document).on 'click', '.session_tab', ->
    filename = $(@).data('filename')
    next_session = sessions[filename]
    editor.setSession(next_session)
    return false

  $('#vim').click ->
    editor.setKeyboardHandler(ace.require("ace/keyboard/vim").handler)
    return false

  $('#emacs').click ->
    editor.setKeyboardHandler(ace.require("ace/keyboard/emacs").handler)
    return false

  $('#nokeybindings').click ->
    editor.setKeyboardHandler()
    return false
