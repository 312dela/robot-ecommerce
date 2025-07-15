*** Settings ***
Documentation    To validate the registration flow

Library          SeleniumLibrary
Library          String
Library          ../utils/generate_email.py

Resource         ../resources/RegistrationPage.resource

Suite Setup      Email Setup

Test Setup       Open Application 


*** Test Cases ***
Create account using unregistered email
    Fill Registration Form        ${EMAIL_LOWER}
    Verify Successfully Registered

Create account using registered email - lowercase
    Fill Registration Form        ${EMAIL_LOWER}
    Verify Already Registered

Create account using registered email - uppercase
    Fill Registration Form        ${EMAIL_UPPER}
    Verify Already Registered 


*** Keywords ***
Email Setup
    ${email}               Generate Email
    Set Global Variable    ${EMAIL_LOWER}    ${email}
    ${upper}=              Evaluate          '${email}'[0].upper() + '${email}'[1:]
    Set Global Variable    ${EMAIL_UPPER}    ${upper}
    