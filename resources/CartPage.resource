*** Settings ***
Library    SeleniumLibrary
Resource    Keywords.resource

*** Keywords ***
Click Checkout
    ${locator}=    Set Variable   css=.totalRow button
    Safe Click Element    ${locator}
    
Get Total Price From Cart
    Wait Until Element Is Visible    css=.prodTotal    timeout=2s
    ${elements}=    Get WebElements    css=.prodTotal
    ${sum}=    Set Variable    0
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${price}=    Evaluate    int('${text}'.split()[1])
        ${sum}=    Evaluate    ${sum} + ${price}
    END
    RETURN    ${sum}

Get Displayed Total Price
    Wait Until Element Is Visible    xpath=//li[.//span[text()='Subtotal']]//span[@class='value']    timeout=5s
    ${text}=    Get Text    xpath=//li[.//span[text()='Subtotal']]//span[@class='value']
    ${total}=    Evaluate    int('${text}'.split('$')[1])
    RETURN    ${total}

