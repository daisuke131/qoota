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

export function localStorageGetitem(responseData) {
  localStorage.setItem("current-user-id", responseData.data.data.id);
  localStorage.setItem("access-token", responseData.headers[ACCESS_TOKEN_KEY]);
  localStorage.setItem("client", responseData.headers[CLIENT_KEY]);
  localStorage.setItem("uid", responseData.headers[UID_KEY]);
}

export function isSignIn() {
  if (localStorage.getItem(ACCESS_TOKEN_KEY) != null &&
  localStorage.getItem("current-user-id") != null) {
    return true
  } else {
    return false
  }
}
