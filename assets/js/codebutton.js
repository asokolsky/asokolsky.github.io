var codeBlocks = document.querySelectorAll('pre.highlight');
codeBlocks.forEach(function(codeBlock) {
  var copyButton = document.createElement('button');
  copyButton.className = 'copy-to-clipboard';
  copyButton.type = 'button';
  //copyButton.ariaLabel = 'Copy code to clipboard';
  //copyButton.innerText = 'Copy';
  var copyHtml = '<i class="fa fa-copy" aria-hidden="true"></i>';
  var checkHtml = '<i class="fa fa-check" aria-hidden="true"></i>';
  //copyButton.innerHtml = copyHtml;
  copyButton.innerText = 'Copy';
  codeBlock.append(copyButton);

  copyButton.addEventListener('click', function () {
    var code = codeBlock.querySelector('code').innerText.trim();
    window.navigator.clipboard.writeText(code);
    //copyButton.innerHtml = checkHtml;
    copyButton.innerText = 'Copied';
    var fourSeconds = 4000;
    setTimeout(function () {
        //copyButton.innerHtml = copyHtml;
        copyButton.innerText = 'Copy';
      }, fourSeconds);
  });
});
