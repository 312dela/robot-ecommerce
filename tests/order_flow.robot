*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           ../libraries/api_auth.py    WITH NAME    AuthLib
Library           ../libraries/api_order.py   WITH NAME    OrderLib

Resource          ../resources/DashboardPage.resource
Resource          ../resources/CartPage.resource
Resource          ../resources/OrderPage.resource
Resource          ../resources/ThanksPage.resource
Resource          ../resources/MyOrdersPage.resource
Resource          ../resources/Keywords.resource

Variables         ../variables/test_data.py


*** Test Cases ***
Count Total Price of Cart
    ${token}    AuthLib.login_user    ${loginFlow["lowercaseEmail"]}    ${loginFlow["password"]}
    Open Application
    Set Token In Local Storage    ${token}
    Add Product To Cart           ${orderFlow["product1"]}
    Wait Toast Is Not Visible
    Add Product To Cart           ${orderFlow["product2"]}
    Wait Toast Is Not Visible
    Go To Cart
    ${sum}    Get Total Price From Cart
    ${actual}=    Get Displayed Total Price
    Should Be Equal As Numbers    ${sum}    ${actual}

Create Order With Respective Email
    ${token}=    AuthLib.login_user    ${loginFlow["lowercaseEmail"]}    ${loginFlow["password"]}
    Open Application
    Set Token In Local Storage    ${token}
    Add Product To Cart           ${orderFlow["product1"]}
    Wait Toast Is Not Visible
    Add Product To Cart           ${orderFlow["product2"]}
    Wait Toast Is Not Visible
    Go To Cart
    Sleep    2s
    Click Checkout
    Page Should Contain           ${orderFlow["respectiveEmail"]}
    Input Country Shipping Info   ${orderFlow["insertLocation"]}    ${orderFlow["selectLocation"]}
    Click Order
    Sleep    5s
    ${orderId}=    Get Order ID
    Go To My Orders
    Sleep    5s
    Click View Order              ${orderId}
    Sleep    5s
    ${email}=    Get Text    xpath=//div[div[text()=' Billing Address ']]//p[1]
    Should Contain               ${email}    ${orderFlow["respectiveEmail"]}

Create Order With Different Email
    ${token}=    AuthLib.login_user    ${loginFlow["lowercaseEmail"]}    ${loginFlow["password"]}
    Open Application
    Set Token In Local Storage    ${token}
    Add Product To Cart           ${orderFlow["product1"]}
    Wait Toast Is Not Visible
    Add Product To Cart           ${orderFlow["product2"]}
    Wait Toast Is Not Visible
    Go To Cart
    Sleep    2s
    Click Checkout
    Change Email Shipping Info    ${orderFlow["otherUserEmail"]}
    Page Should Contain           ${orderFlow["otherUserEmail"]}
    Input Country Shipping Info   ${orderFlow["insertLocation"]}    ${orderFlow["selectLocation"]}
    Click Order
    Sleep    3s
    ${orderId}=    Get Order ID
    Go To My Orders
    Sleep    3s
    Click View Order              ${orderId}
    Sleep    3s
    ${email}=    Get Text    xpath=//div[div[text()=' Billing Address ']]//p[1]
    Should Contain               ${email}    ${orderFlow["otherUserEmail"]}

Order Without Location Info
    ${token}=    AuthLib.login_user    ${loginFlow["lowercaseEmail"]}    ${loginFlow["password"]}
    Open Application
    Set Token In Local Storage    ${token}
    Add Product To Cart           ${orderFlow["product1"]}
    Wait Toast Is Not Visible
    Add Product To Cart           ${orderFlow["product2"]}
    Wait Toast Is Not Visible
    Go To Cart
    Sleep    2s
    Click Checkout
    Change Email Shipping Info    ${orderFlow["otherUserEmail"]}
    Page Should Contain           ${orderFlow["otherUserEmail"]}
    Click Order
    Page Should Contain           Please Enter Full Shipping Information

View Order From Different Account
    ${otherToken}=    AuthLib.login_user    ${orderFlow["otherUserEmail"]}    ${orderFlow["otherUserPassword"]}
    ${created}=       OrderLib.create_order    ${otherToken}
    ${orderId}=       Set Variable    ${created["orders"][0]}
    
    ${currentToken}=  AuthLib.login_user    ${loginFlow["lowercaseEmail"]}    ${loginFlow["password"]}
    ${response}=                   OrderLib.get_order_details    ${orderId}    ${currentToken}
    ${status}=                     Set Variable    ${response.status_code}
    Should Be Equal As Integers    ${status}    403

