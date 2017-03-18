$('form').on('drop', function(e) {
  e.preventDefault();
  e.stopPropagation();
  var files = e.originalEvent.dataTransfer.files;
  for(var i = 0; i < files.length; i++) {
    var file = files[i];
    var ajaxData = new FormData($('form').get(0));
    ajaxData.append('img', file);
    var fileName = file.name,
        name = fileName.substr(0, fileName.lastIndexOf('.')) || fileName;
    ajaxData.append('name', name);
    $.ajax({
      url: 'https://wayfair.slack.com/customize/emoji',
      type: 'POST',
      data: ajaxData,
      cache: false,
      contentType: false,
      processData: false
    });
  }
});

