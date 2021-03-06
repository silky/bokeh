
define [
  "underscore",
  "backbone",
  "./object_array_data_source"
], (_, Backbone, ObjectArrayDataSource) ->

  class ColumnDataSource extends ObjectArrayDataSource.Model
    # Datasource where the data is defined column-wise, i.e. each key in the
    # the data attribute is a column name, and its value is an array of scalars.
    # Each column should be the same length.
    type: 'ColumnDataSource'
    initialize: (attrs, options) ->
      super(attrs, options)
      @cont_ranges = {}
      @discrete_ranges = {}

    getcolumn: (colname) ->
      return @get('data')[colname]

    datapoints: () ->
      data = @get('data')
      fields = _.keys(data)
      points = []
      for i in [0..data[fields[0]].length-1]
        point = {}
        for field in fields
          point[field] = data[field][i]
        points.push(point)
      return points

    defaults: () ->
      super()

  class ColumnDataSources extends Backbone.Collection
    model: ColumnDataSource

  return {
    "Model": ColumnDataSource,
    "Collection": new ColumnDataSources()
  }

