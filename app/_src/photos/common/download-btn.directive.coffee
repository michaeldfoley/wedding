photosApp.directive 'mfdownload', ['$filter', ($filter) ->
  restrict: "A"
  replace: false
  scope: {}
  template: '<svg version="1.1" class="download-btn" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 100 125" xml:space="preserve">
      <path class="download-path" d="M80,85 L80,110" />
      <path class="download-base" d="m13,102 h15.2 c2.4,0 4.8,0 6.6,0 l8.5,0 c3.8,0 9.5,0 13.3,0 l8.5,0 c1.8,0 4.2,0 6.6,0 h15.2"/>
      <g class="download-arrow"><line x1="50" y1="20.4" x2="50" y2="80.6"/><line x1="50" y1="80.6" x2="71.4" y2="59.2"/><line x1="50" y1="80.6" x2="28.6" y2="59.2"/></g>
    </svg>'
  link: (scope, element) ->
    element.on 'click', () ->
      animate 0, 0, 0, false, 0.1, 0
      
    path = element[0].querySelector('.download-path')
    arrow = element[0].querySelector('.download-arrow')
    base = element[0].querySelector('.download-base')
    baseTop = base.getBBox().y - (parseInt(window.getComputedStyle(base).getPropertyValue('stroke-width')) / 2)
    morphTo = 'm13,102 h15.2 c2.4,0 4.8,0.9 6.6,2.5 l8.5,7.6 c3.8,3.4 9.5,3.4 13.3,0 l8.5-7.6 c1.8-1.6 4.2-2.5 6.6-2.5 h15.2'.match(/([MLHVCSQTA]+)|(-?[\d\.]+)z?/gi)
    morphFrom = base.getAttribute('d').match(/([MLHVCSQTA]+)|(-?[\d\.]+)z?/gi)
    
    getPathPosition = (counter, path) ->
      path.getPointAtLength(path.getTotalLength() * counter).y
    
    movePath = (elem, path, amount) ->
      elem.setAttribute 'transform', 'translate(0,' + (getPathPosition(amount, path) - path.getBBox().y) + ')'
    
    morph = (elem, from, to, amount) ->
      if from.length != to.length
        console.error 'From path and to path need to have the same number of points'
      adjusted = to.map((item, i) ->
        if isNaN(item) or item == from[i] then item else item * amount
      )
      elem.setAttribute 'd', adjusted.join(' ')
    
    animate = (t, counter, counterBase, reverse, increment, incrementBase) ->
      if getPathPosition(counter, path) >= baseTop and incrementBase == 0
        incrementBase = increment / (1 - counter)
      if counter >= 1
        reverse = true
      else if reverse and counter <= 0
        return false
      if reverse
        counter -= increment
        counterBase -= incrementBase
      else
        counter += increment
        counterBase += incrementBase
      if counterBase >= 0
        morph base, morphFrom, morphTo, counterBase
      movePath arrow, path, counter
      requestAnimationFrame ->
        animate t, counter, counterBase, reverse, increment, incrementBase
]