*** Settings ***
Library      SeleniumLibrary


*** Variables ***
${TOAST}              css=#toast-container
${URL}                https://rahulshettyacademy.com/client
${BROWSER}            chrome
${DEFAULT_TIMEOUT}    4s
${DEFAULT_PAUSE}      1s

  
*** Keywords ***
Open Application
    Open Browser               ${URL}    ${BROWSER}
    Maximize Browser Window    

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