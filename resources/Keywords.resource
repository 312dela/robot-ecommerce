*** Settings ***
Library      SeleniumLibrary
Library      ../libraries/api_auth.py


*** Variables ***
${TOAST}              css=#toast-container
${URL}                https://rahulshettyacademy.com/client
${BROWSER}            chrome
${DEFAULT_TIMEOUT}    4s
${DEFAULT_PAUSE}      1s


*** Keywords ***
Open App With Token
    [Arguments]                   ${email}      ${password}
    ${token}                      Login User    ${email}    ${password}
    Open Application
    Set Token In Local Storage    ${token}

Open Application
    Open Browser               ${URL}    ${BROWSER}
    Maximize Browser Window    

Set Token In Local Storage
    [Arguments]           ${token}
    Execute Javascript    window.localStorage.setItem("token", "${token}")
    Go To                 ${URL}

Safe Click Element
    [Arguments]                      ${locator}
    Wait Until Element Is Visible    ${locator}          ${DEFAULT_TIMEOUT}
    Scroll Element Into View         ${locator}
    Wait Until Element Is Enabled    ${locator}          ${DEFAULT_TIMEOUT}
    Sleep                            ${DEFAULT_PAUSE}    
    Click Element                    ${locator}

Wait For Element To Be Visible
    [Arguments]                      ${locator}
    Wait Until Element Is Visible    ${locator}          ${DEFAULT_TIMEOUT}
    Sleep                            ${DEFAULT_PAUSE}

Wait For Toast To Disappear
    Wait Until Element Is Visible        ${TOAST}    ${DEFAULT_TIMEOUT}
    Wait Until Element Is Not Visible    ${TOAST}    ${DEFAULT_TIMEOUT}