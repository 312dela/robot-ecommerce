*** Settings ***
Library     SeleniumLibrary

Resource    Keywords.resource


*** Variables ***
${BILLING_ADDRESS}          xpath=//div[contains(text(),'Billing Address')]
${EMAIL_BILLING_ADDRESS}    xpath=//div[contains(text(),'Billing Address')]/following-sibling::p[1]

*** Keywords ***
Verify Email In Billing Address
    [Arguments]                       ${email}
    Wait For Element To Be Visible    ${BILLING_ADDRESS}
    Element Should Contain            ${EMAIL_BILLING_ADDRESS}    ${email}