---
title: Font Awesome
tags: HTML font
---

Pretty amazing!

[How to add](https://docs.fontawesome.com/web/add-icons/how-to) some
[Icons in v4](https://fontawesome.com/v4/icons/).

to add style, include in the head:

```html
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
```

Usage: note it is [version-specific](https://docs.fontawesome.com/web/setup/upgrade/upgrade-from-v4)


[Available versions](https://fontawesome.com/versions)

This is a copy icon <i class="fa fa-copy" aria-hidden="true"></i>.

This is a check icon <i class="fa fa-check" aria-hidden="true"></i>.

More [icons](https://fontawesome.com/v4/icons/).


Use in a regular button:

<button>Test</button>

Use in a copy-to-clipboard button:

<button class="copy-to-clipboard">Test</button>
<button class="copy-to-clipboard"><i class="fa fa-thumbs-o-up"></i> Like</button>
<button class="copy-to-clipboard"><i class="fa fa-copy" aria-hidden="true"></i></button>
<button class="copy-to-clipboard"><i class="fa fa-check" aria-hidden="true"></i></button>


This JavaScript [code](/assets/js/codebutton.js) enumerates all the code
snippets and adds a copy to clipboard button:
```js
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
```
Note:
* to use font awesome I have to work with `innerHTML` button attribute;
* click handler, besides copying the code to the clipboard, temporarily changes
the button text to provide feedback.
