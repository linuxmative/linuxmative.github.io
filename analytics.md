---
layout: page
title: Analytics Dashboard
subtitle: 
---

## Analytics Events

<ul>
  {% for event in site.data.analytics %}
    <li>
      📅 {{ event.timestamp }}<br>
      📄 Page: {{ event.path }}<br>
      🧭 Referrer: {{ event.referrer }}<br>
      💻 UA: {{ event.userAgent }}
      <hr>
    </li>
  {% endfor %}
</ul>

