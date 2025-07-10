*** Settings ***
Library    SeleniumLibrary
Resource    Keywords.resource

*** Keywords ***
Click View Order
    [Arguments]    ${orderId}
    ${locator}=    Set Variable    xpath=//th[text()='${orderId}']/parent::tr//button[contains(@class,'btn-primary')]
    Safe Click Element    ${locator}
