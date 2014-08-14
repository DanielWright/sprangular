Sprangular.controller 'SigninCtrl', ($scope, $state, Account, Facebook, Status) ->

  # Open Drawer !!! Refactor
  if $state.is "gateKeeper"
    Status.bodyState = "is-drw--open is-signin--open"
  $scope.toggleSignin = ->
    Status.bodyState = if Status.bodyState is "is-drw--open is-signin--open" then "" else "is-drw--open is-signin--open"

  # signin = { email: 'user@example.com', password: '1234' }
  signin = {}

  $scope.loading = true
  $scope.signingUp = false
  $scope.askForEmail = false

  $scope.signin = signin
  $scope.signinError = null

  $scope.facebookEmail = null

  $scope.account = Account

  # Get properties
  Account.fetch().then (content) ->
    $scope.accountLoaded content

  $scope.$watch ->
    Account.email
  , (newVal) ->
    signin.email = newVal if newVal

  $scope.login = ->
    $scope.signinError = null
    Account.login(signin)
      .then (content) ->
        $scope.accountLoaded content
      , (error) ->
        console.log error
        $scope.signinError = error

  $scope.forgotPassword = ->
    $state.go 'forgotPassword'

  $scope.toggleSigninUp = ->
    $scope.signingUp = !$scope.signingUp

  $scope.connectWithFacebook = ->
    Facebook.login($scope.facebookEmail)
      .then (content) ->
        Account.reload()
          .then (content) ->
            $scope.accountLoaded content
            $scope.askForEmail = false
      , (error) ->
        console.log error
        if error.status == 404
          $scope.askForEmail = true

  $scope.cancelEmailAsking = ->
    $scope.askForEmail = false
    $scope.facebookEmail = null

  $scope.accountLoaded = (accountContent) ->
    $scope.loading = false
    $scope.signingUp = false
    if $scope.account.isLogged and $state.params.nextState
      Status.bodyState = ""
      $state.go $state.params.nextState,
        id: $state.params.productId,
        location: true
        notify: true
