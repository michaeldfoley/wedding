photosApp.factory 'Authentication', ($firebase, $firebaseAuth, FIREBASE_URL, $rootScope, $q) ->
  ref = new Firebase(FIREBASE_URL)
  authObj = $firebaseAuth(ref);
  
  myObject =
    login: (user) ->
      authObj.$authWithPassword 
        email: user.email,
        password: user.password
      .catch (error) ->
        return $q.reject(error)
      
    logout: () ->
      authObj.$unauth();
    
    signedIn: () ->
      authObj.$getAuth() != null
  
  $rootScope.signedIn = () ->
    myObject.signedIn()
  
  myObject