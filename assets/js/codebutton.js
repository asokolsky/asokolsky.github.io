var codeBlocks = document.querySelectorAll('pre.highlight');
codeBlocks.forEach(function(codeBlock) {
  var copyButton = document.createElement('button');
  copyButton.className = 'copy-to-clipboard';
  copyButton.type = 'button';
  var copyHtml = '<i class="fa fa-copy" aria-hidden="true"></i>';
  copyButton.innerHTML = copyHtml;
  codeBlock.append(copyButton);

  copyButton.addEventListener('click', function () {
    var code = codeBlock.querySelector('code').innerText.trim();
    window.navigator.clipboard.writeText(code);
    copyButton.innerHTML = '<i class="fa fa-check" aria-hidden="true"></i>';
    var fourSeconds = 4000;
    setTimeout(function () {
        copyButton.innerHTML = copyHtml;
      }, fourSeconds);
  });
});
