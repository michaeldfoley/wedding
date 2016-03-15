playlistApp.factory 'frequency', () ->
    AudioContext = (window.AudioContext || false)
    if !AudioContext
      return false
    else
      setup = false
      audioCtx = new AudioContext
      audioSrc = null
      analyser = audioCtx.createAnalyser()
      frequencyData = new Uint8Array(50)
      svgHeight = 250
      svgWidth = 250
      barPadding = 1
      request = null
      svg = null
      requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame
      cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame
      
      
      createSvg = (parent, height, width) ->
        d3.select(parent[0])
          .append('svg')
          .attr('height', height)
          .attr('width', width)
      
      draw = 
        setup: (audio) ->
          if !setup
            audioSrc = audioCtx.createMediaElementSource(audio)
            audioSrc.connect(analyser)
            audioSrc.connect(audioCtx.destination)
          setup = true
          
        draw: (element, audio) ->
          draw.setup(audio)
          svg = createSvg(element, svgHeight, svgWidth)
          svg.selectAll('rect')
            .data(frequencyData)
            .enter()
            .append('rect')
            .attr 'x', (d, i) ->
              i * svgWidth / frequencyData.length
            .attr 'width', svgWidth / frequencyData.length - barPadding
          return
          
          
        renderChart: () ->
          analyser.getByteFrequencyData(frequencyData)
          svg.selectAll('rect')
            .data(frequencyData)
            .attr 'y', (d) ->
              svgHeight - (d * 0.75)
            .attr 'height', (d) ->
              d * 0.75
              
          draw.startDrawing()
          return
        
        startDrawing: () ->  
          request = window.requestAnimationFrame(draw.renderChart)
          
        stopDrawing: () ->
          window.cancelAnimationFrame(request)
          
      
      return draw