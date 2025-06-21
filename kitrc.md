---

# 📂 Vault: исходные Markdown-файлы

vault:
  kit_folder: ./kit
  include: 
    - '^(kitrc|index|navbar).md$'
    - '^blog/'
    - '^notes/'
  exclude: 
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
  description: "Официальный сайт проекта LinuxMative — минимальные системы Ubuntu, кастомизация и сборка ISO"
  url: "https://linuxmative.github.io"
  keywords: ["linux", "ubuntu", "custom iso", "live cd", "minimal linux"]

# 🖼️ OG image

og:
  image: https://linuxmative.github.io/assets/og-image.png

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

