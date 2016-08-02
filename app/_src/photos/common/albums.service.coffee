photosApp.factory 'Albums', [
  '$firebaseObject', 
  '$q',
  'Df',
  ($firebaseObject, $q, Df) ->
  
    state = {}
    
    albums =
      get: () ->
        if Object.getOwnPropertyNames(state).length > 0
          return $q.when(state)
          
        ref = firebase.database().ref('/albums/')
        photoAlbums = $firebaseObject(ref)
        photoAlbums.$loaded().then (data) ->
          return state = data
        .catch (error) ->
          return $q.reject(error)
      
      getArray: () ->
        albums.get().then (data) ->
          albms = []
          angular.forEach data, (val, key)->
            albms.push(val)
          return albms
        
      getAlbum: (albumId) ->
        albums.isAlbum(albumId).then (isAlbum) ->
          
          if !isAlbum
            return false
            
          if state[albumId].images
            return state[albumId]
          
          ref = firebase.database().ref('/photos/' + albumId)
          photoAlbum = $firebaseObject(ref)
          photoAlbum.$loaded().then (currentAlbum) ->
            state[albumId].images = currentAlbum.images.filter (image) ->
              image.ratio = image.width / image.height
              return !Df.GetState() || image.df != true
            
            return state[albumId]
          .catch (error) ->
            return $q.reject(error)
      
      getDownloadLink: (albumId, src) ->
        index = albums.getImagePosition(state[albumId].images, src)
        downloadUrl = state[albumId].images[index].downloadUrl
        if downloadUrl
          return $q.when(downloadUrl)
          
        firebase.storage().ref(albumId + "/" + src + ".jpg").getDownloadURL().then (url)->
          state[albumId].images[index].downloadUrl = url
          return url
      
      getCurrentImage: (images, id) ->
        current = images.filter (image) ->
          image.src == id
        current[0]
      
      getImagePosition: (images, id) ->
        current = images.filter (image) ->
          image.src == id
        return images.indexOf( current[0] )
      
      getAdjacent: (album, index) ->
        direction = {}
        if index > 0
          direction['prev'] = 
            id: album.id
            photo: album.images[index - 1].src
        
        if index < album.images.length - 1
          direction['next'] = 
            id: album.id
            photo: album.images[index + 1].src
        return direction
            
      isAlbum: (albumId) ->
        albums.get().then (data) ->
          !!data[albumId]
      
      loginRequired: (albumId) ->
        albums.get().then (data) ->
          if data[albumId]
            data[albumId].login
]