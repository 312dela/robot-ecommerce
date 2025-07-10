*** Settings ***
Library    SeleniumLibrary
Resource    Keywords.resource

*** Keywords ***
Add Product To Cart
    [Arguments]    ${product}
    Wait Until Element Is Visible     xpath=//b[text()='${product}']
    ${locator}=    Set Variable   //b[text()='${product}']/ancestor::div[contains(@class,'card')]//button[contains(.,'Add To Cart')]
    Safe Click Element    ${locator}
    
Go To Cart
    ${locator}=    Set Variable   css=button[routerlink='/dashboard/cart']
    Safe Click Element    ${locator}
    
