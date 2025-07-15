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

Wait For Element To Be Visible
    [Arguments]                      ${locator}
    Wait Until Element Is Visible    ${locator}          ${DEFAULT_TIMEOUT}
    Sleep                            ${DEFAULT_PAUSE}