*** Settings ***
Documentation    To validate the order flow

Library          SeleniumLibrary
Library          RequestsLibrary
Library          ../libraries/api_order.py  
Library          ../libraries/api_auth.py 

Resource         ../resources/DashboardPage.resource
Resource         ../resources/CartPage.resource
Resource         ../resources/OrderPage.resource
Resource         ../resources/ThanksPage.resource
Resource         ../resources/MyOrdersPage.resource
Resource         ../resources/OrderDetails.resource
Resource         ../resources/Keywords.resource


Variables        ../variables/test_data.py


*** Test Cases ***
Count Total Price of Cart
    Open App With Token             ${loginFlow["email"]}       ${loginFlow["password"]}
    Add Product To Cart             ${orderFlow["product1"]}    
    Wait For Toast To Disappear
    Add Product To Cart             ${orderFlow["product2"]}
    Wait For Toast To Disappear    
    Go To Cart
    Verify Total Price

Create Order With Respective Email
    Open App With Token                ${loginFlow["email"]}             ${loginFlow["password"]}
    Add Product To Cart                ${orderFlow["product1"]}
    Wait For Toast To Disappear
    Add Product To Cart                ${orderFlow["product2"]}
    Wait For Toast To Disappear
    Go To Cart
    Click Checkout
    Verify Shipping Email Label        ${loginFlow["email"]}
    Input Country Shipping Info        ${orderFlow["insertLocation"]}    ${orderFlow["selectLocation"]}
    Click Order
    ${orderId}=                        Get Order ID
    Go To My Orders
    Click View Order                   ${orderId}
    Verify Email In Billing Address    ${loginFlow["email"]}

Create Order With Different Email
    Open App With Token                ${loginFlow["email"]}             ${loginFlow["password"]}
    Add Product To Cart                ${orderFlow["product1"]}
    Wait For Toast To Disappear
    Add Product To Cart                ${orderFlow["product2"]}
    Wait For Toast To Disappear
    Go To Cart
    Click Checkout
    Change Email Shipping Info         ${loginFlow["otherUserEmail"]}
    Verify Shipping Email Label        ${loginFlow["otherUserEmail"]}
    Input Country Shipping Info        ${orderFlow["insertLocation"]}    ${orderFlow["selectLocation"]}
    Click Order
    ${orderId}=                        Get Order ID
    Go To My Orders
    Click View Order                   ${orderId}
    Verify Email In Billing Address    ${loginFlow["otherUserEmail"]}

Order Without Location Info
    Open App With Token            ${loginFlow["email"]}    ${loginFlow["password"]}
    Add Product To Cart            ${orderFlow["product1"]}
    Wait For Toast To Disappear
    Add Product To Cart            ${orderFlow["product2"]}
    Wait For Toast To Disappear
    Go To Cart
    Click Checkout
    Click Order
    Verify Full Shipping Info

View Order From Different Account
    ${otherToken}=                 Login User           ${loginFlow["otherUserEmail"]}    ${loginFlow["password"]}
    ${created}=                    Create Order         ${otherToken}                     ${orderFlow["productId"]}
    ${orderId}=                    Set Variable         ${created["orders"][0]}
    
    ${currentToken}=               Login User           ${loginFlow["email"]}             ${loginFlow["password"]}    
    ${response}=                   Get Order Details    ${orderId}                        ${currentToken}
    ${status}=                     Set Variable         ${response.status_code}   
    Should Be Equal As Integers    ${status}            403