** Settings ***
Library           Collections
Library           Process
Library           RequestsLibrary
Library           SeleniumLibrary

*** Variables ***
${TESTS_DIR}   tests
${GRID_URL}   http://selenium:4444/wd/hub
${BROWSER}   Chrome
${RF_SENSITIVE_VARIABLE}   ${EMPTY}

*** Test Cases ***
Test Selenium library
    [Tags]    selenium    demo
    Given Open Browser	 https://www.google.com   ${BROWSER} 	remote_url=${GRID_URL}
    And Set Screenshot Directory	 EMBED
    And Wait Until Page Contains Element  name=q
    When Input text   name=q   robot framework
    And Wait Until Element Is Enabled  name=btnI
    And Scroll Element Into View   name=btnI
    And Click Element   name=btnI
    Then Wait Until Page Contains   Robot Framework
    And Capture Page Screenshot
    [Teardown]  Close All Browsers

