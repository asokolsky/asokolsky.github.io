
# Blog Posts

{% for post in site.posts %}
### [{{ post.title }}]({{ post.url }})
{{ post.excerpt }}
{% endfor %}

[More details](https://jekyllrb.com/docs/posts/)
