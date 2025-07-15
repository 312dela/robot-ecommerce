import requests

def login_user(email, password):
    response = requests.post(
        "https://rahulshettyacademy.com/api/ecom/auth/login",
        json={"userEmail": email, "userPassword": password}
    )
    
    return response.json()["token"]