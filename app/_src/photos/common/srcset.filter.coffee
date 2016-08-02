photosApp.filter 'srcset', [
  "FIREBASE_PHOTOS", 
  (FIREBASE_PHOTOS) ->
  
    (input) ->
      photoUrl = FIREBASE_PHOTOS + '/' + input
      photoUrl + '-small.jpg 480w, ' + photoUrl + '-medium.jpg 768w, ' + photoUrl + '-large.jpg 1200w, ' + photoUrl + '-xlarge.jpg 2000w'
]