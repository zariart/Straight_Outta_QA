*** Settings ***
Library           SeleniumLibrary
Library           SeleniumScreenshots
Library           Screenshot

*** Variables ***
${BROWSER}        Chrome
${MAIN URL}       https://about.gitlab.com

*** Keywords ***
Open Browser To GitLab Page
    [Tags]    selenium    demo
    Open Browser    ${MAIN URL}    ${BROWSER}
    Maximize Browser Window
    Capture Page Screenshot

Find Sarah Bailey on Organizational Chart    
    [Tags]    selenium    demo
    Open Browser    chrome://newtab/    ${BROWSER}
    Click Element    //h3[@class="LC20lb DKV0Md"]
    Click Link    //a[@href="/company/team/#sbailey1"]
    Click Link    //a[@href="https://gitlab.com/gitlab-com/www-gitlab-com/-/blob/master/data/team_members/person/s/sarahbailey.yml"]
    Capture Page Screenshot
    Close All Browsers
