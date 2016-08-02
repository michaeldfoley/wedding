photosApp.factory 'Authentication', [
  '$firebaseAuth', 
  '$q', 
  ($firebaseAuth, $q) ->
    authObj = $firebaseAuth()
    
    auth =
      login: (user) ->
        authObj.$signInWithEmailAndPassword(user.email,user.password)
        .catch (error) ->
          return $q.reject(error)
        
      logout: () ->
        authObj.$signOut();
      
      signedIn: () ->
        authObj.$getAuth() != null
]