# Matrix inversion is usually a costly computation and there may be some benefit
# to caching the inverse of a matrix rather than compute it repeatedly. 
# Below R functions are completing the following tasks. 
# The first function is getting value of the inverse of the matrix
# The second function returns the inverse of the matrix from cache
# if exists or computes the inverse of a matrix and caches the result
#
# makeCacheMatrix
#  
# Features
# set the value of the matrix
# get the value of the matrix
# set the value of inverse of the matrix
# get the value of inverse of the matrix
makeCacheMatrix <- function(x = matrix()) {
  var_rev <- NULL
  set <- function(y) {
    x <<- y
    var_rev <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) var_rev <<- inverse
  getinverse <- function() var_rev
  list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}

# cacheSolve
#  
# Features
# The function calculates inverse of the matrix set in the previous function
# Firstly checks if inverse of the matrix has been calculated already.
# If so, it gets the inverse of the matrix from the cache and ships the calcualtion.
# Else If not the calculates the inverse of the matrix and set the value of inverse of the matrix
# in the cache via the setinverse function.


cacheSolve <- function(x, ...) {
  var_rev <- x$getinverse()
  if(!is.null(var_rev)) {
    ## returns data from the cache
    message("returns data from the cache")
     return(var_rev)
  }
  message("first run calculates inverse of the matrix")
  data <- x$get()
  var_rev <- solve(data)
  x$setinverse(var_rev)
  var_rev
}
