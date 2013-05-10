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


  window.addOutput = (lines) ->
    lines.each (line) ->
      window.lines.push line



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
        MRB.run_source editor.getValue()

      readOnly: true

    window.editor = editor
