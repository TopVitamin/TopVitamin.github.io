{% if page.comments %}
  <div class="comments" id="comments"></div>
    {% if (theme.valine and theme.valine.enable)%}
    <script src="//cdn1.lncld.net/static/js/3.0.4/av-min.js"></script>
    <script src='//unpkg.com/valine/dist/Valine.min.js'></script>
    <script>
        new Valine({
            av: AV,
            el: '.comments',
            notify: false, 
            verify: false,
            app_id: '{{ theme.valine.appId }}',
            app_key: '{{ theme.valine.appKey }}',
			avatar: '{{ theme.valine.avatar }}',
			guest_info: ['nick'],
            placeholder: '谈谈你的看法？'
        });
    </script>
    {% endif %}
{% endif %}