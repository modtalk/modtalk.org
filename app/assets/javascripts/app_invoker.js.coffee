window.on_pageload = window.on_pageload || []
PageInitializer = () ->
  for d, i in window.on_pageload
    d()
  # Automatically call any late load handlers
  window.on_pageload = {
    push: (item) -> item()
  }
if document.readyState != "loading"
  page_inst = PageInitializer()
else
  document.addEventListener 'DOMContentLoaded', PageInitializer