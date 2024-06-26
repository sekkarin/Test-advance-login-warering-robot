*** Settings ***
Library    SeleniumLibrary


*** Keywords ***
Open Browser To Login Page
    Open Browser    url=http://www.warering.online    browser=Chrome
    Click Button    id:toggle-big-login-landing-drawer-btn
    Wait Until Element Is Visible    setup-user-drawer-title

Input Login Credentials
    [Arguments]    ${username}  ${password}
    Input Text      id=username    ${username}
    Input Text      id=password    ${password}
Logout
    Wait Until Element Is Visible    title-outlet
    Click Image    id=user-profile-image
    Wait Until Element Is Visible    account-user-drawer
    Click Button    id=logout-user-btn

*** Variables ***
${username_long_30}    usernnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn



*** Test Cases ***
Login with correct Username and Password
    Open Browser To Login Page
    Input Login Credentials    ken     Password123
    Click Button    id=setup-user-drawer-submit
    Logout
    Close Browser
Login with Incorrect Username not found
    Open Browser To Login Page
    Input Login Credentials    ken2     Password123
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    alert-setup-user-drawer    not found user
   
Login with Incorrect password 
    Open Browser To Login Page
    Input Login Credentials    ken     Password123Incorrect
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    alert-setup-user-drawer    Password is incorrect
Login with Incorrect Username not match ^[a-zA-Z0-9\s]+$ regular expression 
    Open Browser To Login Page
    Input Login Credentials    ken*     Password123
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    id=alert-setup-user-drawer    username must match
Login with Incorrect Username longer than 30 characters
    Open Browser To Login Page
    Input Login Credentials    ${username_long_30}    Password123
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    id=alert-setup-user-drawer    username must be shorter
Login with Incorrect Username empty
    Open Browser To Login Page
    Input Login Credentials    ${EMPTY}   Password123
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    id=alert-setup-user-drawer    Please provide all value
Login with Incorrect Username must be longer than or equal to 3 characters
    Open Browser To Login Page
    Input Login Credentials    us   Password123
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    id=alert-setup-user-drawer    username must be longer than or equal to 3 characters
Login with Incorrect Password must be longer than or equal to 8 characters
    Open Browser To Login Page
    Input Login Credentials    user   Pass
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    id=alert-setup-user-drawer    password must be longer than or equal to 8 characters
Login with Incorrect Password Three Times and Get Denied Access
    Open Browser To Login Page
    Input Login Credentials    user   Pass
    Click Button    id=setup-user-drawer-submit
    Input Login Credentials    user   Pass
    Click Button    id=setup-user-drawer-submit
    Input Login Credentials    user   Pass
    Click Button    id=setup-user-drawer-submit
    Wait Until Element Contains    id=alert-setup-user-drawer    You have made too many requests. Please wait a while and try again.




    
