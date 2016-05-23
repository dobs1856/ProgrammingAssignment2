## Release 23 May 2016 9:20 PM
## functions calculates inverse of the matrix


makeCacheMatrix <- function(x = matrix()) {
  v_inv <- NULL
  set <- function(y) {
    x <<- y
    v_inv <<- NULL
  }
  get <- function() x
  setinverse<- function(inverse) v_inv <<-inverse
  getinverse <- function() v_inv
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This function computes the inverse of the special "matrix" 
## returned by makeCacheMatrix above

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  v_inv <- x$getinverse()
  if (!is.null(v_inv)) {
    message("getting cached data")
    return(v_inv)
  } 
  data <- solve(x$get())
  v_inv <- inverse(data, ...)     
  x$setinverse(v_inv)
  v_inv
}
