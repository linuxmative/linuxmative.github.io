---

# 📂 Vault: исходные Markdown-файлы

vault:
  kit_folder: kit
  include: 
    - '^index.md$'
    - '^navbar.md$'
    - '^blog/'
    - '^notes/'
    - '^assets/'
    - '^downloads/'
  exclude: 
    - '^kitrc.md$'
    - '^kitrc.json$'
    - '^kit/'
    - '^templates/'
    - '^blog/draft'

# 🧰 Kit

kit:
  version: latest
  dirs: false

# 🖥️ Site

site:
  id: linuxmative
  name: LinuxMative
  description: "Официальный сайт проекта LinuxMative"
  url: "https://linuxmative.github.io"
  keywords: ["linux", "ubuntu", "custom iso", "live cd", "minimal linux"]

# 🖼️ OG image

og:
  image: https://avatars.githubusercontent.com/u/143880431?s=200&v=4

# 🔌 Plugins

plugins:
  theme: "@default"
  header: true
  darkmode: true
  navbar: true
  toc: true
  search: true
  social: true

# ⚙️ Plugins settings

header:
  logo: /assets/logo.png      # логотип сайта
  title: LinuxMative          # название в шапке

social:
  github: https://github.com/linuxmative
---

