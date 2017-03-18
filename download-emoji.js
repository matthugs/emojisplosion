var $body = $('body');
$('.emoji_row')
  .filter(
    function(i, selection) {
      return $(selection).find('[headers="custom_emoji_name"]').html().match(/^:basketball/) ;
    })
  .find('td[headers="custom_emoji_image"] span')
  .map(
    function(i, selection) {
      return $(selection).data('original');
    })
  .each(
    function(i, selection) {
      var match = selection.match(/basketball_[^/]*/),
          emojiName = match[0].replace('_', '-'),
          emojiURI = selection;
      fetch("https://crossorigin.me/" + emojiURI)
        .then(res => res.blob())
        .then(blob => {
            $("<a>").attr({
                download: emojiName,
                href: URL.createObjectURL(blob)
            })[0].click();
          //$body.append($('<a class="js-download">download meeeeee</a>').attr("download", emojiName + '.png').attr("href", emojiURI));
        });
    });

$('.js-download')
  .each(function(i, selection) {
    selection.click();
  });
