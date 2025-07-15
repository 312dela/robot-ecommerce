*** Settings ***
Library     SeleniumLibrary

Resource    Keywords.resource


*** Variables ***
${SHIPPING_EMAIL_LABEL}    css=.user__name label
${SHIPPING_EMAIL_FIELD}    css=.user__name input[type="text"]
${COUNTRY_FIELD}           css=input[placeholder='Select Country']
${ORDER_BUTTON}            css=.action__submit


*** Keywords ***
Change Email Shipping Info
    [Arguments]           ${email}
    Clear Element Text    ${SHIPPING_EMAIL_FIELD}
    Input Text            ${SHIPPING_EMAIL_FIELD}    ${email}

Input Country Shipping Info
    [Arguments]                 ${locationInput}                                   ${selectLocation}
    Input Text                  ${COUNTRY_FIELD}                                   ${locationInput}
    Wait Until Page Contains    ${selectLocation}
    Click Element               xpath=//*[contains(text(),'${selectLocation}')]    

Click Order
    Safe Click Element      ${ORDER_BUTTON} 

Verify Shipping Email Label
    [Arguments]                       ${email}
    Wait For Element To Be Visible    ${SHIPPING_EMAIL_LABEL}
    Element Should Contain            ${SHIPPING_EMAIL_LABEL}    ${email}
    
Verify Full Shipping Info
    Wait For Element To Be Visible    ${TOAST}
    Element Should Contain            ${TOAST}    Please Enter Full Shipping Information