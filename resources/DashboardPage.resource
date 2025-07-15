*** Settings ***
Library     SeleniumLibrary

Resource    Keywords.resource


*** Variables ***
${CART_NAVBAR}    css=button[routerlink='/dashboard/cart']


*** Keywords ***
Add Product To Cart
    [Arguments]    ${product}
    Wait For Element To Be Visible    xpath=//b[text()='${product}']    
    ${addToCartButton}                Set Variable                      xpath=//b[contains(text(),'${product}')]/parent::h5/following-sibling::button[contains(text(),'Add To Cart')]
    Safe Click Element                ${addToCartButton}
    
Go To Cart
    Safe Click Element    ${CART_NAVBAR}
    