
# Blog Posts

{% for post in site.posts %}
### {{post.date}} [{{ post.title }}]({{ post.url }})

> {{ post.excerpt }}

{% endfor %}



[More details on Jekyll posts](https://jekyllrb.com/docs/posts/)
