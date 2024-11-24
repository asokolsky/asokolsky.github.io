var codeBlocks = document.querySelectorAll('pre.highlight');
codeBlocks.forEach(function (codeBlock) {
  var copyButton = document.createElement('button');
  copyButton.className = 'copy-to-clipboard';
  copyButton.type = 'button';
  copyButton.ariaLabel = 'Copy code to clipboard';
  //copyButton.innerText = 'Copy';
  copyButton.innerHtml = '<i class="fa fa-solid fa-copy" aria-hidden="true"></i>';
  codeBlock.append(copyButton);

  copyButton.addEventListener('click', function () {
    var code = codeBlock.querySelector('code').innerText.trim();
    window.navigator.clipboard.writeText(code);
    //copyButton.innerText = 'Copied';
    copyButton.innerHtml = '<i class="fa fa-solid fa-check" aria-hidden="true"></i>';
    var fourSeconds = 4000;
    setTimeout(function () {
        copyButton.innerHtml = '<i class="fa fa-solid fa-copy" aria-hidden="true"></i>';
    }, fourSeconds);
  });
});
