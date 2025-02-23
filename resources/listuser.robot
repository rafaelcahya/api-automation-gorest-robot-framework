*** Settings ***
Library    EnvLoader
Library    RequestsLibrary

Resource    variables.robot

*** Keywords ***

Get Users
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${response}    GET    ${BASE_URL}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}

Get Specific User
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${response}    GET    ${BASE_URL}${USER_ID}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}

Get Nonexistent Specific User
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${response}    GET    ${BASE_URL}${NON_NUMERIC_ID}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}

Get User with Non-Numeric ID
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${BEARER_TOKEN}
    ${response}    GET    ${BASE_URL}${USER_NOT_FOUND_ID}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}

Get Users With Invalid Token
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ...            Authorization=Bearer ${INVALID_TOKEN}
    ${response}    GET    ${BASE_URL}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}

Get Users With Empty Token
    ${headers}    Create Dictionary    
	...            Accept=${ACCEPT}
    ...            Content-Type=${CONTENT_TYPE}
    ${response}    GET    ${BASE_URL}    headers=${headers}    expected_status=any
    RETURN    ${response.status_code}    ${response.json()}