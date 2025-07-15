*** Settings ***
Library     SeleniumLibrary

Resource    ../resources/Keywords.resource


*** Variables ***
${REGISTER_LAUNCHER}         css=a[routerlink="/auth/register"]
${FIRST_NAME_FIELD}          css=#firstName
${LAST_NAME_FIELD}           css=#lastName 
${EMAIL_FIELD}               css=#userEmail
${PHONE_FIELD}               css=#userMobile
${OCCUPATION_FIELD}          css=[formcontrolname="occupation"]
${GENDER_FIELD}              css=[value="Female"]  
${PASSWORD_FIELD}            css=#userPassword
${CONFIRM_PASSWORD_FIELD}    css=#confirmPassword
${REQUIRED_FIELD}            css=[formcontrolname="required"]
${REGISTER_BUTTON}           css=#login

  
*** Keywords ***
Fill Registration Form
    [Arguments]                  ${email}
    Safe Click Element           ${REGISTER_LAUNCHER}
    Input Text                   ${FIRST_NAME_FIELD}          John
    Input Text                   ${LAST_NAME_FIELD}           Doe
    Input Text                   ${EMAIL_FIELD}               ${email}
    Input Text                   ${PHONE_FIELD}               1234567890
    Select From List By Value    ${OCCUPATION_FIELD}          2: Student
    Click Element                ${GENDER_FIELD}
    Input Password               ${PASSWORD_FIELD}            Test12345
    Input Password               ${CONFIRM_PASSWORD_FIELD}    Test12345
    Click Element                ${REQUIRED_FIELD}
    Click Button                 ${REGISTER_BUTTON}

Verify Successfully Registered
    Wait For Element To Be Visible    ${TOAST}    
    Element Should Contain            ${TOAST}    Successfully

Verify Already Registered
    Wait For Element To Be Visible    ${TOAST}    
    Element Should Contain            ${TOAST}    Already    ignore_case= True 