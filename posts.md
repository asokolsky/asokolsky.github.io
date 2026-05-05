---
layout: default
comments: false
---

# Blog Posts

{% for post in site.posts %}

### {{post.date | date: "%Y-%m-%d"}} <a href="{{ post.url }}">{{ post.title }}</a>

> {{ post.excerpt }}

{% endfor %}

[More details on Jekyll posts](https://jekyllrb.com/docs/posts/)
