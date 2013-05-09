# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  window.MRB = WEBRUBY()
  
  if $("#editor")[0]
    editor = ace.edit("editor")
    editor.commands.addCommand
      name: 'runCode',
      bindKey:
        win: 'Ctrl-Enter',
        mac: 'Command-Enter'
      exec: (e) ->
        MRB.run_source editor.getValue()
      readOnly: true

    window.editor = editor
