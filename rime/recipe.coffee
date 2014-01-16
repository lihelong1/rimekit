exports.cook = cook = (recipe, ingredients) ->
  unless recipe instanceof Recipe
    recipe = new Recipe recipe
  try
    if recipe.props.files
      recipe.downloadFiles()
    if recipe.props.params
      recipe.collectParams(ingredients)
    if recipe.props.setup
      recipe.props.setup.call recipe
  catch e
    console.error 'error cooking recipe: ' + e
    return false
  return true

exports.Recipe = class Recipe

  constructor: (@props) ->
    @validate()

  validate: ->
    throw Error('missing recipe name.') unless @props.name
    throw Error('missing recipe version.') unless @props.version
    unless /^[_0-9A-Za-z]+$/.test @props.name
      throw Error('recipe name should be alpha_numeric.')
    unless typeof @props.version is 'string'
      throw Error('recipe version should be string type.')
    # TODO

  collectParams: (ingredients) ->
    for param in @props.params
      unless param and typeof param is 'object'
        throw Error('invalid parameter definition.')
      if param.required and typeof ingredients[param.name] is 'undefined'
        throw Error("missing ingredient: #{param.name}")
    # TODO

  downloadFiles: ->
    # TODO

  installSchema: (schemaId, options) ->
    # TODO

  enableSchema: (schemaId, enabled = true) ->
    # TODO

  customize: (configId, proc) ->
    # TODO