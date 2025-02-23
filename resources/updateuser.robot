*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    ../EnvLoader.py

Resource    ../resources/listuser.robot
Resource    variables.robot

*** Keywords ***
Update User
    [Arguments]    ${name}    ${email}    ${status}
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${PAYLOAD}    Create Dictionary   
	...    name=${name}        
	...    email=${email}    
	...    status=${status}
    ${response}    PATCH    ${BASE_URL}${USER_ID}    json=${PAYLOAD}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}

Validate Update User
    [Arguments]    ${name}    ${email}    ${status}    ${expected_status_code}
    
    ${status_code}    ${response_body}=    Update User    ${name}    ${email}    ${status}

    Should Be Equal As Numbers    ${status_code}    ${expected_status_code}

    Should Contain    ${response_body["name"]}    ${name}
    Should Contain    ${response_body["email"]}    ${email}
    Should Contain    ${response_body["status"]}    ${status}

Validate Update User With Invalid Value
    [Arguments]    ${name}    ${email}    ${status}    ${expected_status_code}    ${expected_error}
    
    ${status_code}    ${response_body}=    Update User    ${name}    ${email}    ${status}

    Should Be Equal As Numbers    ${status_code}    ${expected_status_code}

    Should Be Equal As Strings    ${response_body[0]["field"]}    ${expected_error["field"]}
    Should Be Equal As Strings    ${response_body[0]["message"]}    ${expected_error["message"]}

Update User With Invalid URL
    [Arguments]    ${name}    ${email}    ${status}
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${PAYLOAD}    Create Dictionary   
	...    name=${name}        
	...    email=${email}    
	...    status=${status}
    ${response}    PATCH    ${BASE_URL}${NON_NUMERIC_ID}    json=${PAYLOAD}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}


Validate Update User With Invalid URL
    [Arguments]    ${name}    ${email}    ${status}    ${expected_status_code}
    
    ${status_code}    ${response_body}=    Update User With Invalid URL    ${name}    ${email}    ${status}

    Should Be Equal As Numbers    ${status_code}    ${expected_status_code}