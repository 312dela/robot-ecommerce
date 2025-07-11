*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/Keywords.resource

*** Keywords ***
Fill Login Form
    [Arguments]       ${email}
    Input Text        css:#userEmail         ${email}
    Input Password    css:#userPassword      ${password}
    Click Button      css:#login

Verify Successful Login
    Wait Until Element Is Visible    ${toast}    timeout=5s
    Element Should Contain            ${toast}         Successfully    ignore_case = True



