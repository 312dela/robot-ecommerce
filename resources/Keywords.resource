*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${toast}    css=#toast-container
${password}    Test12345

*** Keywords ***
Open Application
    Open Browser    https://rahulshettyacademy.com/client    chrome
    Maximize Browser Window

Set Token In Local Storage
    [Arguments]    ${token}
    Execute Javascript    window.localStorage.setItem("token", "${token}")
    Go To    https://rahulshettyacademy.com/client

Safe Click Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=4s
    Scroll Element Into View         ${locator}
    Wait Until Element Is Enabled    ${locator}    timeout=4s
    Click Element    ${locator}

Wait Toast Is Not Visible
    Wait Until Element Is Visible    ${toast}    timeout=5s
    Wait Until Element Is Not Visible    ${toast}    timeout=5s