photosApp.directive 'mfpreload', [
  '$filter', 
  ($filter) ->
    restrict: "A"
    replace: true
    scope:
      images: "="
    link: (scope, element) ->
      element.on 'load', (e) ->
        currentImage = e.currentTarget.currentSrc || e.currentTarget.src
        if typeof currentImage != "undefined"
          size = currentImage.substring(currentImage.lastIndexOf('-') + 1, currentImage.length - 4)
          for key, val of scope.images
            res = document.createElement("link");
            res.rel = "prefetch";
            res.as = "image";
            res.href = $filter('src')(val.photo, size);
            document.head.appendChild(res);
]