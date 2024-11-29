var codeBlocks = document.querySelectorAll('pre.highlight');
codeBlocks.forEach(function(codeBlock) {
  var copyButton = document.createElement('button');
  copyButton.className = 'copy-to-clipboard';
  copyButton.type = 'button';
  //copyButton.ariaLabel = 'Copy code to clipboard';
  //copyButton.innerText = 'Copy';
  copyButton.innerHtml = '&nbsp;<i class="fa fa-copy" aria-hidden="true"></i>&nbsp;';
  codeBlock.append(copyButton);

  copyButton.addEventListener('click', function () {
    var code = codeBlock.querySelector('code').innerText.trim();
    window.navigator.clipboard.writeText(code);
    //copyButton.innerText = 'Copied';
    copyButton.innerHtml = '&nbsp;<i class="fa fa-check" aria-hidden="true"></i>&nbsp;';
    var fourSeconds = 4000;
    setTimeout(function () {
        //copyButton.innerText = 'Copy';
        copyButton.innerHtml = '&nbsp;<i class="fa fa-copy" aria-hidden="true"></i>&nbsp;';
    }, fourSeconds);
  });
});
