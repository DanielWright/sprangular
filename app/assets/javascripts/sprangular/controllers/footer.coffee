Sprangular.controller "FooterCtrl", ($scope, $state, Account, Catalog, Status) ->

  $scope.catalog = Catalog
  $scope.account = Account

  $scope.toggleCart = ->
    Status.bodyState = if Status.bodyState is "is-drw--open is-cart--open" then "" else "is-drw--open is-cart--open"

  $scope.goToMyAccount = ->
    $state.go 'account'
