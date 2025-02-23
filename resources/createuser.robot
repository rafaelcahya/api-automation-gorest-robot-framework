*** Settings ***
Library    RequestsLibrary

Resource    variables.robot

*** Keywords ***
Create New User
    [Arguments]    ${name}    ${gender}    ${email}    ${status}
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${PAYLOAD}    Create Dictionary   
	...    name=${name}    
	...    gender=${gender}    
	...    email=${email}    
	...    status=${status}
    ${response}    POST    ${BASE_URL}    json=${PAYLOAD}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}

Validate Create New User
    [Arguments]    ${name}    ${gender}    ${email}    ${status}    ${expected_status_code}
    
    ${status_code}    ${response_body}=    Create New User    ${name}    ${gender}    ${email}    ${status}

    Should Be Equal As Numbers    ${status_code}    ${expected_status_code}

    Should Contain    ${response_body["name"]}    ${name}
    Should Contain    ${response_body["gender"]}    ${gender}
    Should Contain    ${response_body["email"]}    ${email}
    Should Contain    ${response_body["status"]}    ${status}

Validate Create New User With Invalid Value
    [Arguments]    ${name}    ${gender}    ${email}    ${status}    ${expected_status_code}    ${expected_error}
    
    ${status_code}    ${response_body}=    Create New User    ${name}    ${gender}    ${email}    ${status}

    Should Be Equal As Numbers    ${status_code}    ${expected_status_code}

    Should Be Equal As Strings    ${response_body[0]["field"]}    ${expected_error["field"]}
    Should Be Equal As Strings    ${response_body[0]["message"]}    ${expected_error["message"]}

Create New User With Invalid URL
    [Arguments]    ${name}    ${gender}    ${email}    ${status}
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${PAYLOAD}    Create Dictionary   
	...    name=${name}    
	...    gender=${gender}    
	...    email=${email}    
	...    status=${status}
    ${response}    POST    ${BASE_URL}${NON_NUMERIC_ID}    json=${PAYLOAD}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.request.body}


Validate Create New User With Invalid URL
    [Arguments]    ${name}    ${gender}    ${email}    ${status}    ${expected_status_code}
    
    ${status_code}    ${response_body}=    Create New User With Invalid URL    ${name}    ${gender}    ${email}    ${status}

    Should Be Equal As Numbers    ${status_code}    ${expected_status_code}