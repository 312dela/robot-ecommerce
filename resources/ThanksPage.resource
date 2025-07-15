*** Settings ***
Library     SeleniumLibrary

Resource    Keywords.resource


*** Variables ***
${ORDER_ID_LABEL}    css=.ng-star-inserted label[class='ng-star-inserted']:first-of-type 
${ORDERS_NAVBAR}     css=button[routerlink='/dashboard/myorders']


*** Keywords ***
Get Order ID
    Wait For Element To Be Visible    ${ORDER_ID_LABEL}    
    ${text}                           Get Text             ${ORDER_ID_LABEL}
    ${orderId}                        Evaluate             '${text}'.split('|')[1].strip()
    RETURN                            ${orderId}

Go To My Orders
    Safe Click Element    ${ORDERS_NAVBAR}