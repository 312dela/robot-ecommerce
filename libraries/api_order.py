import requests

def create_order(token, product_id):
    headers = {"Authorization": token}
    body = {"orders": [{"country": "Indonesia", "productOrderedId": product_id}]}
    response = requests.post(
        "https://rahulshettyacademy.com/api/ecom/order/create-order",
        headers=headers, json=body
    )
    return response.json()

def get_order_details(order_id, token):
    headers = {"Authorization": token}
    params = {"id": order_id}
    response = requests.get(
        "https://rahulshettyacademy.com/api/ecom/order/get-orders-details",
        headers=headers, params=params
    )
    return response