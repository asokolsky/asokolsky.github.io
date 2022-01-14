
# Blog Posts

{% for post in site.posts %}
### {{post.date.strftime("%F")}} [{{ post.title }}]({{ post.url }})

> {{ post.excerpt }}

{% endfor %}



[More details on Jekyll posts](https://jekyllrb.com/docs/posts/)
