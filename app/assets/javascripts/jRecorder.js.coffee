#
# * jRecorder Plugin for jQuery JavaScript Library (Alpha)
# * http://www.sajithmr.me/jrecorder
# *
# * Copyright (c) 2011 - 2013 Sajithmr.ME
# * Dual licensed under the MIT and GPL licenses.
# *  - http://www.opensource.org/licenses/mit-license.php
# *  - http://www.gnu.org/copyleft/gpl.html
# *
# * Author: Sajith Amma
# * Modification by: Gabriel Cebrian / Harrison Gordon
# * Version: 1.1
# * Date: 18 March 2013
#

jQuery ->
  # Allow instantiation without initializing for simple inheritance
  # If the element to be appended is not defined, append to body
  # Default settings

  # If option array is passed, merge the values
  # Non-zero
  # Non-zero

  # Function call to start a recording

  # Change z-index to make it top

  # Function call to stop recording

  #function call to send wav data to server url from the init configuration

  # Put back flash while recording

  # Function to return flash object from name
  getFlashMovie = (movieName) ->
    isIE = navigator.appName.indexOf("Microsoft") isnt -1
    (if (isIE) then window[movieName] else document[movieName])
  methods =
    play: (options) ->
      alert options

    pause: ->

  jRecorderSettings = {}
  $.jRecorder = (options, element) ->
    if typeof (options) is "string"
      return methods[options].apply(this, Array::slice.call(arguments_, 1))  if methods[options]
      return false
    element = $("body")  if element is `undefined`
    settings =
      rec_width: "220"
      rec_height: "200"
      rec_top: "0px"
      rec_left: "0px"
      recorderlayout_id: "flashrecarea"
      recorder_id: "audiorecorder"
      recorder_name: "audiorecorder"
      wmode: "transparent"
      bgcolor: "#ff0000"
      swf_path: "jRecorder.swf"
      host: "acceptfile.php?filename=hello.wav"
      callback_started_recording: ->

      callback_finished_recording: ->

      callback_stopped_recording: ->

      callback_error_recording: ->

      callback_activityTime: (time) ->

      callback_activityLevel: (level) ->

      log: (info) ->
        console.log info

      debug: false

    $.extend settings, options  if options
    jRecorderSettings = settings
    unless $.support.leadingWhitespace
      objStr = "<object  name=\"" + settings["recorder_name"] + "\" id=\"" + settings["recorder_id"] + "\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" width=\"" + settings["rec_width"] + "\" height=\"" + settings["rec_height"] + "\"></object>"
      paramStr = ["<param name=\"movie\" value=\"" + settings["swf_path"] + "?host=" + settings["host"] + "\" />", "<param name=\"allowScriptAccess\" value=\"always\" />", "<param name=\"bgcolor\" value=\"" + settings["bgcolor"] + "\" />", "<param name=\"wmode\" value=\"" + settings["wmode"] + "\" />"]
      htmlObj = document.createElement(objStr)
      i = 0

      while i < paramStr.length
        htmlObj.appendChild document.createElement(paramStr[i])
        i++
    else
      createParam = (el, n, v) ->
        p = document.createElement("param")
        p.setAttribute "name", n
        p.setAttribute "value", v
        el.appendChild p

      htmlObj = document.createElement("object")
      htmlObj.setAttribute "id", settings["recorder_id"]
      htmlObj.setAttribute "name", settings["recorder_name"]
      htmlObj.setAttribute "data", settings["swf_path"] + "?host=" + settings["host"]
      htmlObj.setAttribute "type", "application/x-shockwave-flash"
      htmlObj.setAttribute "width", settings["rec_width"]
      htmlObj.setAttribute "height", settings["rec_height"]
      createParam htmlObj, "allowscriptaccess", "always"
      createParam htmlObj, "bgcolor", settings["bgcolor"]
      createParam htmlObj, "wmode", settings["wmode"]
    divObj = document.createElement("div")
    divObj.setAttribute "id", settings["recorderlayout_id"]
    divObj.setAttribute "style", "text-align: center; top:" + settings["rec_top"] + ";left:" + settings["rec_left"] + ";z-index:-1"
    divObj.appendChild htmlObj
    element.append divObj

  $.jRecorder.record = (max_time) ->
    $("#" + jRecorderSettings["recorderlayout_id"]).css "z-index", 1000
    getFlashMovie(jRecorderSettings["recorder_name"]).jStartRecording max_time

  $.jRecorder.stop = ->
    getFlashMovie(jRecorderSettings["recorder_name"]).jStopRecording()

  $.jRecorder.playPreview = ->
    getFlashMovie(jRecorderSettings["recorder_name"]).jStartPreview()

  $.jRecorder.stopPreview = ->
    getFlashMovie(jRecorderSettings["recorder_name"]).jStopPreview()

  $.jRecorder.addParameter = (key, val) ->
    getFlashMovie(jRecorderSettings["recorder_name"]).jAddParameter key, val

  $.jRecorder.removeParameter = (key) ->
    getFlashMovie(jRecorderSettings["recorder_name"]).jRemoveParameter key

  $.jRecorder.sendData = ->
    getFlashMovie(jRecorderSettings["recorder_name"]).jSendFileToServer()

  $.jRecorder.callback_started_recording = ->
    jRecorderSettings["callback_started_recording"]()

  $.jRecorder.callback_finished_recording = ->
    jRecorderSettings["callback_finished_recording"]()

  $.jRecorder.callback_error_recording = ->
    jRecorderSettings["callback_error_recording"]()

  $.jRecorder.callback_stopped_recording = ->
    jRecorderSettings["callback_stopped_recording"]()

  $.jRecorder.callback_finished_sending = (data) ->
    jRecorderSettings["callback_finished_sending"] data

  $.jRecorder.callback_activityLevel = (level) ->
    jRecorderSettings["callback_activityLevel"] level

  $.jRecorder.callback_activityTime = (time) ->
    $("#" + jRecorderSettings["recorderlayout_id"]).css "z-index", -1
    jRecorderSettings["callback_activityTime"] time

  $.jRecorder.callback_preview_complete = ->
    jRecorderSettings["callback_preview_complete"]()

  $.jRecorder.log = (log) ->
    jRecorderSettings["log"] log  if jRecorderSettings["debug"]
