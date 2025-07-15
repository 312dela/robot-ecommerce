*** Settings ***
Documentation    To validate the login flow

Library          SeleniumLibrary

Resource         ../resources/Keywords.resource
Resource         ../resources/LoginPage.resource

Test Setup       Open Application

Test Template    Login using registered account


*** Test Cases ***    email
uppercase       Email1@yopmail.com
lowercase       email1@yopmail.com

*** Keywords ***
Login using registered account
    [Arguments]                    ${email}
    Fill Login Form                ${email}
    Verify Successful Login