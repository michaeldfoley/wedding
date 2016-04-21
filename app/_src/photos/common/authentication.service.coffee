photosApp.factory 'Authentication', ($rootScope, $firebase, $firebaseAuth, FIREBASE_URL, $q) ->
  ref = new Firebase(FIREBASE_URL)
  authObj = $firebaseAuth(ref);
  
  auth =
    login: (user) ->
      authObj.$authWithPassword 
        email: user.email,
        password: user.password
      .then (user) ->
        $rootScope.$emit('loggedin', user)
      .catch (error) ->
        return $q.reject(error)
      
    logout: () ->
      authObj.$unauth();
    
    signedIn: () ->
      authObj.$getAuth() != null