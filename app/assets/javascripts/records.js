// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require tmpl.min.js
//= require canvas-to-blob.min.js
//= require load-image.min.js
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-ip
//= require jquery.fileupload-ui

$(function () {
    'use strict';
//debugger;
    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload();

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
        'option',
        'redirect',
        window.location.href.replace(
            /\/[^\/]*$/,
            '/cors/result.html?%s'
        )
    );

    $('#fileupload').fileupload('option', {
      autoUpload: true,
    });
//        });
//        // Upload server status check for browsers with CORS support:
//        if ($.ajaxSettings.xhr().withCredentials !== undefined) {
//            $.ajax({
//                url: '//jquery-file-upload.appspot.com/',
//                type: 'HEAD'
//            }).fail(function () {
//                $('<span class="alert alert-error"/>')
//                    .text('Upload server currently unavailable - ' +
//                            new Date())
//                    .appendTo('#fileupload');
//            });
//        }
//    } else {
        // Load existing files:
        $('#fileupload').each(function () {
            var that = this;
            var recordSetId = $('#record_record_set_id');
            if (!recordSetId.length) {
              alert('invalid record set id');
            }

            $.getJSON(this.action + '?format=json&record_set_id=' + recordSetId.val(), function (result) {
                if (result && result.length) {
                    $(that).fileupload('option', 'done')
                        .call(that, null, {result: result});
                }
            });
        });
//    }

});

window.locale = {
    "fileupload": {
        "errors": {
            "maxFileSize": "File is too big",
            "minFileSize": "File is too small",
            "acceptFileTypes": "Filetype not allowed",
            "maxNumberOfFiles": "Max number of files exceeded",
            "uploadedBytes": "Uploaded bytes exceed file size",
            "emptyResult": "Empty file upload result"
        },
        "error": "Error",
        "start": "Start",
        "cancel": "Cancel",
        "destroy": "Delete"
    }
};

