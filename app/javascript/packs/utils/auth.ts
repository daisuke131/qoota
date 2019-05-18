const ACCESS_TOKEN_KEY = "access-token"
const CLIENT_KEY = "client"
const UID_KEY = "uid"

export function getHeaders() {
  return {
    headers: {
      "access-token": localStorage.getItem(ACCESS_TOKEN_KEY),
      "client": localStorage.getItem(CLIENT_KEY),
      "uid": localStorage.getItem(UID_KEY)
    }
  }
}

export function localStorageSetitem(response_data) {
  localStorage.setItem("current-user-id", response_data.data.data.id);
  localStorage.setItem("access-token", response_data.headers[ACCESS_TOKEN_KEY]);
  localStorage.setItem("client", response_data.headers[CLIENT_KEY]);
  localStorage.setItem("uid", response_data.headers[UID_KEY]);
}

export function isSignIn() {
  if (localStorage.getItem(ACCESS_TOKEN_KEY) != null &&
  localStorage.getItem("current-user-id") != null) {
    return true
  } else {
    return false
  }
}
