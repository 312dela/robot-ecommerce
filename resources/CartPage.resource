*** Settings ***
Library     SeleniumLibrary

Resource    Keywords.resource


*** Variables ***
${PRODUCT_PRICE}         css=.prodTotal     
${CHECKOUT_BUTTON}       css=.totalRow button
${ACTUAL_TOTAL_PRICE}    xpath=//span[text()='Total']/following-sibling::span[1]


*** Keywords ***
Click Checkout
    Safe Click Element    ${CHECKOUT_BUTTON}
    
Get Total Price From Cart
    Wait For Element To Be Visible    ${PRODUCT_PRICE}
    ${elements}                       Get WebElements    ${PRODUCT_PRICE}
    ${sum}                            Set Variable       0
    FOR    ${el}    IN    @{elements}
        ${text}     Get Text    ${el}
        ${price}    Evaluate    int('${text}'.split()[1])
        ${sum}      Evaluate    ${sum} + ${price}
    END
    RETURN    ${sum}

Get Actual Total Price
    Wait For Element To Be Visible    ${ACTUAL_TOTAL_PRICE}      
    ${text}                           Get Text                 ${ACTUAL_TOTAL_PRICE}
    ${total}                          Evaluate                 int('${text}'.split('$')[1])
    RETURN                            ${total}

Verify Total Price
    ${sum}                        Get Total Price From Cart
    ${actual}                     Get Actual Total Price
    Should Be Equal As Numbers    ${sum}                      ${actual}