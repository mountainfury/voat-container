# voat-container
Containerized version of https://voat.co

# About this fork
I am attempting to create a git repo that will facilitate the migration of voat code into a workable python microservice that will hopefully work in parallel to efforts to reduce voat bloat!

- Stack: https://docs.docker.com/compose/aspnet-mssql-compose/
- App: https://github.com/voat/voat/tree/Dev

#### Dependencies
- Markdowndeep: http://www.toptensoftware.com/markdowndeep
- Entity Framework: https://github.com/aspnet/EntityFramework6
- WebApiThrottle: https://github.com/stefanprodan/WebApiThrottle
- SignalR: https://github.com/SignalR/SignalR
- OpenGraph-Net: https://github.com/ghorsey/OpenGraph-Net
- .NET Image Library: https://www.nuget.org/packages/ImageLibrary
- HtmlAgilityPack: http://www.nuget.org/packages/HtmlAgilityPack
- Bootstrap: http://getbootstrap.com
- jQuery: http://jquery.com


## Migration list

### Python
These will need to be researched probably, but it might also just be fine!

- .NET Image Library to Python: http://pythonware.com/products/pil/
- Markdowndeep to Python https://pypi.python.org/pypi/Markdown
- ORM is possibly not needed in python, native DB access can be used?
- WebAPiThrottle - DJANGO has this built in with asyncronous and delay
- DJANGO dumps the need for SignalR too

To Keep:
- Bootstrap: http://getbootstrap.com
- jQuery: http://jquery.com

Find a replacement for:
- HtmlAgilityPack: http://www.nuget.org/packages/HtmlAgilityPack

## Let me know if anything has been missed! 
