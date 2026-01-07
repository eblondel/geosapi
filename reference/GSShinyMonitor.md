# Geoserver REST API DataStore

Geoserver REST API DataStore

Geoserver REST API DataStore

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
setting a GS Shiny monitoring app

## Note

Internal class used for `GSManager$monitor` method

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Methods

### Public methods

- [`GSShinyMonitor$new()`](#method-GSShinyMonitor-new)

- [`GSShinyMonitor$getMetric()`](#method-GSShinyMonitor-getMetric)

- [`GSShinyMonitor$run()`](#method-GSShinyMonitor-run)

- [`GSShinyMonitor$clone()`](#method-GSShinyMonitor-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes a Geoserver shiny monitoring tool

#### Usage

    GSShinyMonitor$new(manager, file = NULL, append = FALSE, sleep = 1)

#### Arguments

- `manager`:

  object of class
  [GSManager](https://eblondel.github.io/geosapi/reference/GSManager.md)

- `file`:

  file File where to store monitoring results

- `append`:

  append. Whether results should be appended to existing file

- `sleep`:

  sleep. Interval in seconds to trigger monitor calls

------------------------------------------------------------------------

### Method `getMetric()`

Get metric

#### Usage

    GSShinyMonitor$getMetric(name)

#### Arguments

- `name`:

  name

#### Returns

the Geoserver monitored metric

------------------------------------------------------------------------

### Method `run()`

Runs the application

#### Usage

    GSShinyMonitor$run()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    GSShinyMonitor$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
