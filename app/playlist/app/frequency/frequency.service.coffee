angular.module 'spotifyPlaylistCollab'
  .factory 'frequency', () ->
    
    setup = false
    audioCtx = new ((window.AudioContext or window.webkitAudioContext))
    analyser = audioCtx.createAnalyser()
    frequencyData = new Uint8Array(50)
    svgHeight = 250
    svgWidth = 250
    barPadding = 1
    request = null
    svg = null
    
    # Get the average frequency amplitudes
    getAverageVolume = (array) ->
      values = 0
      average = undefined
      length = array.length
      # get all the frequency amplitudes
      i = 0
      while i < length
        values += array[i]
        i++
      average = values / length
      average
    
    # Create the svg
    createSvg = (parent, height, width) ->
      d3.select(parent.context)
        .append('svg')
        .attr('height', height)
        .attr('width', width)
    
    draw = 
      setup: (audio) ->
        audio.crossOrigin = 'anonymous'
        audioSrc = audioCtx.createMediaElementSource(audio)
        
        # Bind our analyser to the media element source.
        audioSrc.connect(analyser)
        audioSrc.connect(audioCtx.destination)
        
        setup = true
        
      draw: (element, audio) ->
        if !setup
          draw.setup(audio)
        
        svg = createSvg(element, svgHeight, svgWidth)
        svg.selectAll('rect')
          .data(frequencyData)
          .enter()
          .append('rect')
          .attr 'x', (d, i) ->
            i * svgWidth / frequencyData.length
          .attr 'width', svgWidth / frequencyData.length - barPadding
        
        
      renderChart: () ->
        draw.startDrawing()
        
        analyser.getByteFrequencyData(frequencyData)
        average = Math.ceil(getAverageVolume(frequencyData) / 10) * 10
        
        svg.selectAll('rect')
          .data(frequencyData)
          .attr 'y', (d) ->
            svgHeight - (d * 0.75)
          .attr 'height', (d) ->
            d * 0.75
        return
          
      startDrawing: () ->  
        request = window.requestAnimationFrame(draw.renderChart)
        
      stopDrawing: () ->
        svg.transition().duration(700).each('end', () ->
          window.cancelAnimationFrame(request)
        )
        
    
    return draw
    
    
  