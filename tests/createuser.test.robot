*** Settings ***
Library    RequestsLibrary
Library    ../FakerLibrary.py
Resource    ../resources/createuser.robot

Test Setup    Set Environment Variables

*** Test Cases ***
API POST Create New User Returns 201 createD
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EMAIL}    Generate Email
    Validate Create New User    ${NAME}   female    ${EMAIL}    active    201

API POST Create User With Empty Name Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${EMAIL}    Generate Email
    ${EXPECTED_ERROR}    Create Dictionary    field=name    message=can't be blank
    Validate Create New User With Invalid Value    ${EMPTY}   female    ${EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Name More Than 200 Characters Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Sentence    65
    ${EMAIL}    Generate Email
    ${EXPECTED_ERROR}    Create Dictionary    field=name    message=is too long (maximum is 200 characters)
    Validate Create New User With Invalid Value    ${NAME}   female    ${EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Empty Gender Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EMAIL}    Generate Email
    ${EXPECTED_ERROR}    Create Dictionary    field=gender    message=can't be blank, can be male of female
    Validate Create New User With Invalid Value    ${NAME}    ${EMPTY}    ${EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Other Gender Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EMAIL}    Generate Email
    ${EXPECTED_ERROR}    Create Dictionary    field=gender    message=can't be blank, can be male of female
    Validate Create New User With Invalid Value    ${NAME}    ${NAME}    ${EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Empty Email Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=can't be blank
    Validate Create New User With Invalid Value    ${NAME}    female    ${EMPTY}    active    422    ${EXPECTED_ERROR}

API POST Create User With Invalid Email Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=is invalid
    Validate Create New User With Invalid Value    ${NAME}    female    ${INVALID_EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Registered Email Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=has already been taken
    Validate Create New User With Invalid Value    ${NAME}    female    ${REGISTERED_EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Email More Than 200 Characters Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=is too long (maximum is 200 characters)
    Validate Create New User With Invalid Value    ${NAME}   female    ${LONG_EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Email More Than 200 Characters And Invalid Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EXPECTED_ERROR}    Create Dictionary    field=email    message=is too long (maximum is 200 characters), is invalid
    Validate Create New User With Invalid Value    ${NAME}   female    ${LONG_INVALID_EMAIL}    active    422    ${EXPECTED_ERROR}

API POST Create User With Empty Status Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EMAIL}    Generate Email
    ${EXPECTED_ERROR}    Create Dictionary    field=status    message=can't be blank
    Validate Create New User With Invalid Value    ${NAME}    female    ${EMAIL}    ${EMPTY}    422    ${EXPECTED_ERROR}

API POST Create User With Other Status Returns 422 UNPROCESSABLE ENTITY
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EMAIL}    Generate Email
    ${EXPECTED_ERROR}    Create Dictionary    field=status    message=can't be blank
    Validate Create New User With Invalid Value    ${NAME}    female    ${EMAIL}    ${NAME}    422    ${EXPECTED_ERROR}

API POST Create User With Invalid URL Returns 404 NOT FOUND
    [Tags]    create
    ${NAME}    Generate Female First Name
    ${EMAIL}    Generate Email
    Validate Create New User With Invalid URL    ${NAME}    female    ${EMAIL}    active    404