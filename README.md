# Shlick

## Static site generator using pandoc.

**PS: Work In Progress. Not ready for use.**

Source directory structure:

```
.
├── assets
│   ├── images
│   │   ├── img-1.png
│   │   ├── img-2.png
│   │   └── img-3.png
│   ├── style.css
│   └── script.js
├── blog
│   ├── index.md
│   └── posts
│       ├── post-1.md
│       ├── post-2.md
│       └── post-3.md
├── about.md
├── contact.md
├── index.md
└── favicon.ico
```

Target directory structure:

```
.
├── assets
│   ├── images
│   │   ├── img-1.png
│   │   ├── img-2.png
│   │   └── img-3.png
│   ├── style.css
│   └── script.js
├── blog
│   ├── index.html
│   └── posts
│       ├── post-1.html
│       ├── post-2.html
│       └── post-3.html
├── about.html
├── contact.html
├── index.html
└── favicon.ico
```

---

## Credits

- [Guide](https://www.romangeber.com/static_websites_with_pandoc/) by [Roman Geber](https://github.com/rgeber/).
