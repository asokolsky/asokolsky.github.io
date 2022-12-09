---
title: Markdown with Mermaid
tags: linux
comments: true
---

[Mermaid](https://mermaid-js.github.io) is [now on
github](https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/)!

Is this awesome or what?

```mermaid
graph TD;
A[start]-->B{Q?};
B-- Yes -->C[foo];
B-- No -->D[bar];
C-->E[finish!];
D-->E[finish!];
```

```mermaid
graph LR;
A[start]-->B{Q?};
B-- Yes -->C[foo];
B-- No -->D[bar];
C-->E[finish!];
D-->E[finish!];
```

Links:
* [Repository](https://github.com/mermaid-js/mermaid)
* [Editor](https://mermaid-js.github.io/mermaid-live-editor/)
