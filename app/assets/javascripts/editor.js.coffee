# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.lines = []
window.sessions = {}

window.Module = {}
window.Module['print'] = (x) ->
  window.lines.push x

jQuery ->
  window.MRB = WEBRUBY
    print_level: 1

  window.EditSession = ace.require("ace/edit_session").EditSession
  window.UndoManager = ace.require("ace/undomanager").UndoManager

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

  $("#run").click ->
    interpretCode editor.getValue()

  window.interpretCode = (code) ->
    result = MRB.run_source code
    renderOutput()

  window.MRB = WEBRUBY
    print_level: 1

  window.switchTab = (num) ->
    filename = $(".session_tab[data-order='#{num}']").data('filename')
    next_session = sessions[filename]
    editor.setSession(next_session)
    next_session.setUndoManager new UndoManager()
    $("#viewing").html("<h1 class='current_filename'>#{filename}</h1>")
    $(".session_tab").each ->
      $(@).removeClass("current")
    $(".session_tab[data-filename='#{filename}']").addClass("current")



  $(document).ready ->
    editor.focus()
    interpretCode editor.getValue()

  interpretCode $('script[type="text/ruby"]').text()


  if $("#editor")[0]
    editor = ace.edit("editor")
    editor.getSession().setMode("ace/mode/ruby")
    editor.setTheme("ace/theme/monokai")
    editor.commands.addCommand
      eindKey:
        win: 'Ctrl-Enter',
        mac: 'Ctrl-Enter'
      exec: (e) ->
        window.lines = []
        interpretCode e.getValue()

    #needs some serious refactoring
    editor.commands.addCommand
      name: 'tab1',
      bindKey:
        win: 'Ctrl-1',
        mac: 'Ctrl-1'
      exec: (e) ->
        switchTab(1)
        return false

    editor.commands.addCommand
      name: 'tab2',
      bindKey:
        win: 'Ctrl-2',
        mac: 'Ctrl-2'
      exec: (e) ->
        switchTab(2)
        return false

    editor.commands.addCommand
      name: 'tab3',
      bindKey:
        win: 'Ctrl-3',
        mac: 'Ctrl-3'
      exec: (e) ->
        switchTab(3)
        return false

    editor.commands.addCommand
      name: 'tab4',
      bindKey:
        win: 'Ctrl-4',
        mac: 'Ctrl-4'
      exec: (e) ->
        switchTab(4)
        return false

    editor.commands.addCommand
      name: 'tab5',
      bindKey:
        win: 'Ctrl-5',
        mac: 'Ctrl-5'
      exec: (e) ->
        switchTab(5)
        return false

    editor.commands.addCommand
      name: 'tab6',
      bindKey:
        win: 'Ctrl-6',
        mac: 'Ctrl-6'
      exec: (e) ->
        switchTab(6)
        return false

    editor.commands.addCommand
      name: 'tab7',
      bindKey:
        win: 'Ctrl-7',
        mac: 'Ctrl-7'
      exec: (e) ->
        switchTab(7)
        return false

    editor.commands.addCommand
      name: 'tab8',
      bindKey:
        win: 'Ctrl-8',
        mac: 'Ctrl-8'
      exec: (e) ->
        switchTab(8)
        return false

    editor.commands.addCommand
      name: 'tab9',
      bindKey:
        win: 'Ctrl-9',
        mac: 'Ctrl-9'
      exec: (e) ->
        filename = $(".session_tab:last").data('filename')
        next_session = sessions[filename]
        editor.setSession(next_session)
        next_session.setUndoManager new UndoManager()
        $("#viewing").html("<h1 class='current_filename'>#{filename}</h1>")
        $(".session_tab").each ->
          $(@).removeClass("current")
        $(".session_tab[data-filename='#{filename}']").addClass("current")
        return false

    editor.commands.addCommand
      name: 'addfile',
      bindKey:
        win: 'Ctrl-0',
        mac: 'Ctrl-0'
      exec: (e) ->
        new_session = new EditSession('')
        new_session.setMode("ace/mode/ruby")
        session_id = Object.keys(sessions).length+1
        filename = "untitled#{session_id}.rb"
        window.sessions[filename] = new_session
        editor.setSession new_session
        new_session.setUndoManager new UndoManager()
        editor.focus()
        $('#files').append("<a class='session_tab' data-filename='#{filename}' data-order='#{session_id}' href='#' title='#{filename}'>#{filename}</a>")
        $("#viewing").html("<h1 class='current_filename'>#{filename}</h1>")
        $(".session_tab").each ->
          $(@).removeClass("current")
        $(".session_tab[data-filename='#{filename}']").addClass("current")
        return false


      readOnly: true

    window.sessions['untitled1.rb'] = editor.getSession()
    window.editor = editor

  $('#add_file').click ->
    new_session = new EditSession('')
    new_session.setMode("ace/mode/ruby")
    session_id = Object.keys(sessions).length+1
    filename = "untitled#{session_id}.rb"
    window.sessions[filename] = new_session
    editor.setSession new_session
    new_session.setUndoManager new UndoManager()
    editor.focus()
    $('#files').append("<a class='session_tab' data-filename='#{filename}' data-order='#{session_id}' href='#' title='#{filename}'>#{filename}</a>")
    $("#viewing").html("<h1 class='current_filename'>#{filename}</h1>")
    $(".session_tab").each ->
      $(@).removeClass("current")
    $(".session_tab[data-filename='#{filename}']").addClass("current")
    return false

  $(document).on 'click', '.session_tab', ->
    filename = $(@).data('filename')
    next_session = sessions[filename]
    editor.setSession(next_session)
    editor.focus()
    $("#viewing").html("<h1 class='current_filename'>#{filename}</h1>")
    $(".session_tab").each ->
      $(@).removeClass("current")
    $(@).addClass("current")
    return false

  $('#none').click ->
    editor.setKeyboardHandler()
    $("#toolbar a.bind").each ->
      $(@).removeClass("current")
    $(@).addClass("current")
    return false

  $('#vim').click ->
    editor.setKeyboardHandler(ace.require("ace/keyboard/vim").handler)
    $("#toolbar a.bind").each ->
      $(@).removeClass("current")
    $(@).addClass("current")
    return false

  $('#emacs').click ->
    editor.setKeyboardHandler(ace.require("ace/keyboard/emacs").handler)
    $("#toolbar a.bind").each ->
      $(@).removeClass("current")
    $(@).addClass("current")
    return false

  $('#show_shortcuts').click ->
    $('#shortcuts').toggle()
    return false

  $('#shortcuts').click ->
    $('#shortcuts').toggle()
    return false
