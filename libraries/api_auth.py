import requests

def login_user(email, password):
    response = requests.post(
        "https://rahulshettyacademy.com/api/ecom/auth/login",
        json={"userEmail": email, "userPassword": password}
    )
    response.raise_for_status()
    return response.json()["token"]
