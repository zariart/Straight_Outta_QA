*** Settings ***

Library  SeleniumLibrary

Suite Teardown  Close all browsers

*** Keywords ***

Highlight heading
    [Arguments]  ${locator}
    Update element style  ${locator}  margin-top  0.75em
    Highlight  ${locator}

*** Test Cases ***

Take an annotated screenshot of Gitlab.com
    [Tags]    selenium    demo
    Open browser  http://gitlab.com
    Bootstrap jQuery
    Highlight heading  css=.main-header h1
    ${note1} =  Add pointy note
    ...    css=.main-header
    ...    This screenshot was generated using Robot Framework and Selenium.
    ...    width=250  position=bottom
    Capture and crop page screenshot  robotframework.png
    ...    css=.main-header  ${note1}
