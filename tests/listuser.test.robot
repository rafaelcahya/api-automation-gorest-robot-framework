*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    ../EnvLoader.py

Resource    ../resources/listuser.robot

Test Setup    Set Environment Variables

*** Test Cases ***
API GET Users Returns 200 OK
    [Tags]    list
    ${status}    ${response_body}    Get Users
	Should Be Equal As Numbers    ${status}    200
    Should Be True    ${response_body} != []
    Should Be True    isinstance(${response_body}, list)

    FOR    ${user}    IN    @{response_body}
        Should Contain    ${user}    id
        Should Contain    ${user}    name
        Should Contain    ${user}    email
        Should Contain    ${user}    gender
        Should Contain    ${user}    status
    END

API GET Specific User Returns 200 OK
    [Tags]    list
    ${status}    ${response_body}    Get Specific User
	Should Be Equal As Numbers    ${status}    200
    Should Be True    isinstance(${response_body}, dict)
    Should Contain    ${response_body}    id
    Should Contain    ${response_body}    name
    Should Contain    ${response_body}    email
    Should Contain    ${response_body}    gender
    Should Contain    ${response_body}    status
    Should Be Equal As Numbers    ${response_body["id"]}    ${user_id}

API GET Nonexistent Specific User Returns 404 NOT FOUND
    [Tags]    list
    ${expected_message}    Get Env    RESOURCE_NOT_FOUND_MESSAGE
    ${status}    ${response_body}    Get Nonexistent Specific User
	Should Be Equal As Numbers    ${status}    404
	Dictionary Should Contain Key    ${response_body}    message
	Should Be Equal As Strings    ${response_body["message"]}    ${expected_message}

API GET User With Non-Numeric ID Returns 404 NOT FOUND
    [Tags]    list
    ${expected_message}    Get Env    RESOURCE_NOT_FOUND_MESSAGE
    ${status}    ${response_body}    Get User with Non-Numeric ID
	Should Be Equal As Numbers    ${status}    404
	Dictionary Should Contain Key    ${response_body}    message
	Should Be Equal As Strings    ${response_body["message"]}    ${expected_message}

API GET Users With Invalid Token Returns 401 UNAUTHORIZED
    [Tags]    list
    ${expected_message}    Get Env    INVALID_TOKEN_MESSAGE
    ${status}    ${response_body}    Get Users With Invalid Token
	Should Be Equal As Numbers    ${status}    401
	Dictionary Should Contain Key    ${response_body}    message
	Should Be Equal As Strings    ${response_body["message"]}    ${expected_message}