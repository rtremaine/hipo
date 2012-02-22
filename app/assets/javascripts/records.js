// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require best_in_place
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-ui
//= require shadowbox
//

(function ($) {
    'use strict';

  $.widget('blueimpUIX.fileupload', $.blueimpUI.fileupload, {

      options: {
          errorMessages: {
              maxFileSize: 'File is too big',
              minFileSize: 'File is too small',
              acceptFileTypes: 'Filetype not allowed',
              maxNumberOfFiles: 'Max number of files exceeded'
          }
      },
      
      _initFileUploadButtonBar: function () {
          var fileUploadButtonBar = this.element.find('.fileupload-buttonbar'),
              filesList = this.element.find('.files'),
              ns = this.options.namespace;
          fileUploadButtonBar
              .addClass('ui-widget-header ui-corner-top');
          this.element.find('.fileinput-button').each(function () {
              var fileInput = $(this).find('input:file').detach();
              $(this).button({icons: {primary: 'ui-icon-plusthick'}})
                  .append(fileInput);
          });
          fileUploadButtonBar.find('.start')
              .button({icons: {primary: 'ui-icon-circle-arrow-e'}})
              .bind('click.' + ns, function (e) {
                  e.preventDefault();
                  filesList.find('.start button').click();
              });
          fileUploadButtonBar.find('.cancel')
              .button({icons: {primary: 'ui-icon-cancel'}})
              .bind('click.' + ns, function (e) {
                  e.preventDefault();
                  filesList.find('.cancel button').click();
              });
          fileUploadButtonBar.find('.delete')
              .button({icons: {primary: 'ui-icon-trash'}})
              .bind('click.' + ns, function (e) {
                  e.preventDefault();
                  if (confirm("Are you sure you want to delete all files?")) {
                    filesList.find('.delete').addClass("all");
                    filesList.find('.all button').click();
                  }
                  else {
                    return false;
                  }
              });
      },
      
      _deleteHandler: function (e) {
          e.preventDefault();
          var button = $(this);
          if ($(this).parent().hasClass("all")) {
            e.data.fileupload._trigger('destroy', e, {
                context: button.closest('.template-download'),
                url: button.attr('data-url'),
                type: button.attr('data-type'),
                dataType: e.data.fileupload.options.dataType
            });
          }
          else {
            if ( confirm("Are you sure you want to delete this file ?") == true) {
              e.data.fileupload._trigger('destroy', e, {
                  context: button.closest('.template-download'),
                  url: button.attr('data-url'),
                  type: button.attr('data-type'),
                  dataType: e.data.fileupload.options.dataType
              });
              console.info($(this).parent());
            }
            else {
              return false;
            }
          }
      },

      _renderUploadTemplate: function (files) {
          var that = this,
              rows = $();
          $.each(files, function (index, file) {
              file = that._uploadTemplateHelper(file);
              var row = $('<tr class="template-upload">' + 
                  '<td class="preview"></td>' +
                  '<td class="name"></td>' +
                  '<td class="size"></td>' +
                  (file.error ?
                      '<td class="error" colspan="2"></td>'
                  :
                      '<td class="progress"><div></div></td>' +
                      '<td class="start"><button>Start</button></td>'
                  ) + 
                  '<td class="cancel"><button>Cancel</button></td>' +
                  '</tr>');
              row.find('.name').text(file.name);
              row.find('.size').text(file.sizef);
              if (file.error) {
                  row.addClass('ui-state-error');
                  row.find('.error').text(
                      that.options.errorMessages[file.error] || file.error
                  );
              }
              rows = rows.add(row);
          });
          return rows;
      }

  });
  
}(jQuery));


$(function () {
    //$('.fileupload-content').append('<div id="loading"></div>');

    var inputs = $('#new_picture :input[type=text]');
    
    clearFields(inputs);
    
    function clearFields (inputs) {
      $('.ui-state-error-text').remove();
      $.each(inputs, function(index, field){
        $(field).focus(function(){
          $(field).removeClass("ui-state-error");
          $(field).next().remove();
        });
      });
    };
  
    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
      maxNumberOfFiles: 10,
      acceptFileTypes: /\.(jpg|jpeg|gif|png|JPG|JPEG|GIF|PNG)$/
    });
    
    // 
    // Load existing files:
    /*
    $.getJSON($('#fileupload form').prop('action'), function (files) {
        var fu = $('#fileupload').data('fileupload');
        //fu._adjustMaxNumberOfFiles(-files.length);
        fu._renderDownload(files)
            .appendTo($('#fileupload .files'))
            .fadeIn(function () {
                // Fix for IE7 and lower:
                $(this).show();
            });
            
            $(".best_in_place").best_in_place();
            Shadowbox.init();
            $('#loading').hide();
    });

    // Open download dialogs via iframes,
    // to prevent aborting current uploads:
    $('#fileupload .files a:not([target^=_blank])').live('click', function (e) {
        e.preventDefault();
        $('<iframe style="display:none;"></iframe>')
            .prop('src', this.href)
            .appendTo('body');
    });
    */
    
    $('#fileupload').bind('fileuploadsend', function (e, data) {
      
      var values = {};
      
      $.each($('#new_picture').serializeArray(), function(i, field) {
          values[field.name] = field.value;
      });

      var title = values["picture[title]"]
      var description = values["picture[description]"]
      
      $.each( values, function(k, v){
        if (v == 0) {
          $('input[name="' + k + '"]').addClass("ui-state-error");
          $('input[name="' + k + '"]').after("<span class=\"ui-state-error-text\"> can't be blank!</span>");
        }
       });

    });
    
    $('#fileupload').bind('fileuploadprogressall', function (e,data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      //$('.progress-bar').find('div').css('width',  progress + '%').find('span').html(progress + '%');
      console.info(progress);
    });

});


