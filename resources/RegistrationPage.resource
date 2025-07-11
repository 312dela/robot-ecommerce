*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/Keywords.resource

*** Keywords ***
Fill Registration Form
    [Arguments]                       ${email}
    Click Element                     css:a[routerlink="/auth/register"]
    Input Text                        css:#firstName                        John
    Input Text                        css:#lastName                         Doe
    Input Text                        css:#userEmail                        ${email}
    Input Text                        css:#userMobile                       1234567890
    Select From List By Value         css:[formcontrolname="occupation"]    2: Student
    Click Element                     css:[value="Female"]
    Input Password                    css:#userPassword                     ${password}
    Input Password                    css:#confirmPassword                  ${password}
    Click Element                     css:[formcontrolname="required"]
    Click Button                      css:#login

Verify Successfully Registered
    Wait Until Element Is Visible    ${toast}    timeout=5s
    Element Should Contain             ${toast}        Successfully        ignore_case = True

Verify Already Registered
    Wait Until Element Is Visible    ${toast}    timeout=5s    
    ${toast_text}=                    Get Text        ${toast}
    Should Contain                    ${toast_text}   already             ignore_case = True
