*** Settings ***
Library    SeleniumLibrary
Resource    Keywords.resource

*** Keywords ***
Get Order ID
    Wait Until Element Is Visible    css=.ng-star-inserted label[class='ng-star-inserted']:first-of-type 
    ${text}=    Get Text    css=.ng-star-inserted label[class='ng-star-inserted']:first-of-type 
    ${orderId}=    Evaluate    '${text}'.split('|')[1].strip()
    RETURN    ${orderId}

Go To My Orders
    ${locator}=    Set Variable    css=button[routerlink='/dashboard/myorders']
    Safe Click Element    ${locator}
