/**
 * JS for mass-uploading emoji, to be copied-and-pasted into the
 * browser javascript console on
 * <$your_organization>.slack.com/customize/emoji. Tested primarily on
 * Chrome. (Yes, jQuery is already on the page.)
 *
 * Once this is loaded you can drag and drop files from your OS's file
 * explorer (e.g. Finder or Windows Explorer) onto the emoji name text
 * input on the page. The emoji will be uploaded under the name of the
 * file. You can select as many files as you like to drag and drop
 * (but try not to overload slack, or they'll surely break this for
 * everyone).
 */
$('form').on('drop', function(e) {
  e.preventDefault();
  e.stopPropagation();
  const files = e.originalEvent.dataTransfer.files;
  for(let i = 0; i < files.length; i++) {
    const file = files[i];
    const ajaxData = new FormData($('form').get(0));
    ajaxData.append('img', file);
    const fileName = file.name,
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
