*** Settings ***
Library    SeleniumLibrary
Resource    Keywords.resource

*** Keywords ***
Change Email Shipping Info
    [Arguments]    ${email}
    Clear Element Text    css=.user__name input[type="text"]
    Input Text    css=.user__name input[type="text"]    ${email}

Input Country Shipping Info
    [Arguments]    ${locationInput}    ${selectLocation}
    Input Text    css=input[placeholder='Select Country']    ${locationInput}
    Wait Until Page Contains    ${selectLocation}
    Click Element    xpath=//*[contains(text(),'${selectLocation}')]

Click Order
    ${locator}=    Set Variable    css=.action__submit
    Safe Click Element      ${locator}

