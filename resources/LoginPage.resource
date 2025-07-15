*** Settings ***
Library      SeleniumLibrary

Resource     ../resources/Keywords.resource

Variables    ../variables/test_data.py


*** Variables ***
${EMAIL_FIELD}       css=#userEmail
${PASSWORD_FIELD}    css=#userPassword
${LOGIN_BUTTON}      css=#login


*** Keywords ***
Fill Login Form
    [Arguments]       ${email}
    Input Text        ${EMAIL_FIELD}         ${email}
    Input Password    ${PASSWORD_FIELD}      ${loginFlow["password"]}
    Click Button      ${LOGIN_BUTTON}

Verify Successful Login
    Wait For Element To Be Visible    ${TOAST}  
    Element Should Contain            ${TOAST}         Successfully