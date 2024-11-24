var codeBlocks = document.querySelectorAll('pre.highlight');
codeBlocks.forEach(function (codeBlock) {
  var copyButton = document.createElement('button');
  copyButton.className = 'copy-to-clipboard';
  copyButton.type = 'button';
  //copyButton.ariaLabel = 'Copy code to clipboard';
  copyButton.innerText = 'Copy';
  //copyButton.innerHtml = '<i class="fa fa-solid fa-copy" aria-hidden="true"></i>Copy';
  codeBlock.append(copyButton);

  copyButton.addEventListener('click', function () {
    var code = codeBlock.querySelector('code').innerText.trim();
    window.navigator.clipboard.writeText(code);
    copyButton.innerText = '&#2713;';
    //copyButton.innerHtml = '<i class="fa fa-solid fa-check" aria-hidden="true"></i>Copied';
    var fourSeconds = 4000;
    setTimeout(function () {
        copyButton.innerText = 'Copy';
        //copyButton.innerHtml = '<i class="fa fa-solid fa-copy" aria-hidden="true"></i>Copy';
    }, fourSeconds);
  });
});
