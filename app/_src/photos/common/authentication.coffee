photosApp.factory 'Authentication', ($firebase, $firebaseAuth, FIREBASE_URL, $rootScope) ->
  ref = new Firebase(FIREBASE_URL)
  authObj = $firebaseAuth(ref);
  
  myObject =
    login: (user) ->
      console.log('Logging in:', user)
      authObj.$authWithPassword 
        email: user.email,
        password: user.password
      .then (authData) ->
        console.log authData
      .catch (error) ->
        console.error('Authentication failed:', error)
      
    logout: () ->
      $rootScope.auth.$unauth();
    
    signedIn: () ->
      $rootScope.auth.$getAuth() != null
  
  $rootScope.signedIn = () ->
    myObject.signedIn()
  
  myObject