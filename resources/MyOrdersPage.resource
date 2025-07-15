*** Settings ***
Library     SeleniumLibrary

Resource    Keywords.resource


*** Keywords ***
Click View Order
    [Arguments]           ${orderId}
    ${viewButton}         Set Variable    xpath://th[text()='${orderId}']/parent::tr//button[contains(@class,'btn-primary')]
    Safe Click Element    ${viewButton}
    