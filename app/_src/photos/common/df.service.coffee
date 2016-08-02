photosApp.factory 'Df', [
  '$location', 
  ($location) ->
    service =
      model: false
      
      InitializeState: () ->
        if $location.search().df
          service.model = $location.search().df == '1'
        else if localStorage.df
          service.model = angular.fromJson(localStorage.df)
        localStorage.df = service.model
      
      GetState: () ->
        service.model
  
    return service
]