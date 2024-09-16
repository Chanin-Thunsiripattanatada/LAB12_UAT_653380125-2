*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Firefox
${DELAY}          0.2
${VALID FIRSTNAME}     Somsri
${VALID LASTNAME}    Sodsai
${VALID ORGANIZATION}     CS KKU
${VALID EMAIL}    somsri@kkuamail.com
${VALID PHONE}    081-001-1234
${REGISTRATION URL}      http://${SERVER}/Lab12/Registration.html
${SUCCESS URL}    http://${SERVER}/Lab12/Success.html
# ${ERROR URL}      http://${SERVER}/error.html

*** Keywords ***
Open Browser To Registration Page
    Open Browser    ${REGISTRATION URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Registration Page Should Be Open

Registration Page Should Be Open
    Location Should Be    ${REGISTRATION URL}
    Title Should Be    Event Registration

Go To Registration Page
    Go To    ${REGISTRATION URL}
    Registration Page Should Be Open

Input Firstname
    [Arguments]    ${firstname}
    Input Text    firstname    ${firstname}

Input Lastname
    [Arguments]    ${lastname}
    Input Text    lastname    ${lastname}

Input Organization
    [Arguments]    ${organization}
    Input Text    organization    ${organization}

Input Email
    [Arguments]    ${email}
    Input Text    email    ${email}

Input Phone
    [Arguments]    ${phone}
    Input Text    phone    ${phone}

Submit Credentials
    Click Button    registerButton

Success Page Should Be Open
    # Location Should Be    ${SUCCESS URL}
    Title Should Be    Success
    ${h1_text}=    Get Text    xpath=//h1
    Should Be Equal As Strings    ${h1_text}    Success
    ${h2_text}=    Get Text    xpath=//h2
    Should Be Equal As Strings    ${h2_text}    Thank you for participating in our event

*** Test Cases ***
Open Event Registration Page
    Open Browser To Registration Page
    [Teardown]    Close Browser
Register Success
    Open Browser To Registration Page
    Input Firstname    ${VALID FIRSTNAME}
    Input Lastname    ${VALID LASTNAME}
    Input Organization    ${VALID ORGANIZATION}
    Input Email    ${VALID EMAIL}
    Input Phone    ${VALID PHONE}
    Submit Credentials
    Success Page Should Be Open
    [Teardown]    Close Browser

Register Success No Organization Info
    Open Browser To Registration Page
    Input Firstname    ${VALID FIRSTNAME}
    Input Lastname    ${VALID LASTNAME}
    Input Email    ${VALID EMAIL}
    Input Phone    ${VALID PHONE}
    Submit Credentials
    Success Page Should Be Open
    [Teardown]    Close Browser