*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary
Resource    ../resources/variables.robot
Resource    ../resources/updateuser.robot

Test Setup    Set Environment Variables

*** Test Cases ***
API PATCH Update User Returns 200 OK
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EMAIL}    FakerLibrary.Email
    Validate Update User    ${NAME}    ${EMAIL}    active    200

API PATCH Update User With Empty Name Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${EMAIL}    FakerLibrary.Email
    ${EXPECTED_ERROR}    Create Dictionary    field=name    message=can't be blank
    Validate Update User With Invalid Value    ${EMPTY}    ${EMAIL}    active    422    ${EXPECTED_ERROR}

API PATCH Update User With Name More Than 200 Characters Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.Sentence    nb_words=65
    ${EMAIL}    FakerLibrary.Email
    ${EXPECTED_ERROR}    Create Dictionary    field=name    message=is too long (maximum is 200 characters)
    Validate Update User With Invalid Value    ${NAME}    ${EMAIL}    active    422    ${EXPECTED_ERROR}

API PATCH Update User With Empty Email Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=can't be blank
    Validate Update User With Invalid Value    ${NAME}    ${EMPTY}    active    422    ${EXPECTED_ERROR}

API PATCH Update User With Invalid Email Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=is invalid
    Validate Update User With Invalid Value    ${NAME}    ${INVALID_EMAIL}    active    422    ${EXPECTED_ERROR}

API PATCH Update User With Registered Email Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=has already been taken
    Validate Update User With Invalid Value    ${NAME}    ${REGISTERED_EMAIL}    active    422    ${EXPECTED_ERROR}

API PATCH Update User With Email More Than 200 Characters And Invalid Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=is too long (maximum is 200 characters), is invalid
    Validate Update User With Invalid Value    ${NAME}    ${LONG_INVALID_EMAIL}    active    422    ${EXPECTED_ERROR}

API PATCH Update User With Empty Status Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EMAIL}    FakerLibrary.Email
    ${EXPECTED_ERROR}    Create Dictionary    field=status    message=can't be blank
    Validate Update User With Invalid Value    ${NAME}    ${EMAIL}    ${EMPTY}    422    ${EXPECTED_ERROR}


API PATCH Update User With Other Status Returns 422 UNPROCESSABLE ENTITY
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EMAIL}    FakerLibrary.Email
    ${EXPECTED_ERROR}    Create Dictionary    field=status    message=can't be blank
    Validate Update User With Invalid Value    ${NAME}    ${EMAIL}    ${NAME}    422    ${EXPECTED_ERROR}

API PATCH Update User With Invalid URL Returns 404 NOT FOUND
    [Tags]    UPDATE
    ${NAME}    FakerLibrary.First Name Female
    ${EMAIL}    FakerLibrary.Email
    Validate Update User With Invalid URL    ${NAME}    ${EMAIL}    active    404