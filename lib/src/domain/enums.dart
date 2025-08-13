enum SignInFailure {
  notFound,
  unauthorized,
  unknown,
  network,
}

enum HttpMethod {
  get,
  post,
  delete,
}

enum GeneralFailure {
  noData,
  unknown,
  network,
  clientError,
  serverError,
}

enum LicenceStatus {
  initial,
  loading,
  loaded,
  error,
}

enum DataStatus {
  initial,
  loading,
  loaded,
  error,
  noData,
  success,
}
