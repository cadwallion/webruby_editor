# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.lines = []

window.Module = {}
window.Module['print'] = (x) ->
  window.lines.push x
  console.log "LINES", x

jQuery ->
  window.MRB = WEBRUBY
    print_level: 2


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



  if $("#console")[0]
    editor = ace.edit("console")
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

    window.editor = editor
