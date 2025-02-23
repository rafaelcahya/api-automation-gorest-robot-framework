*** Settings ***
Library    ../EnvLoader.py

*** Keywords ***
Set Environment Variables
    ${BASE_URL}    Get Env    BASE_URL
    ${BEARER_TOKEN}    Get Env    BEARER_TOKEN
    ${ACCEPT}    Get Env    ACCEPT
    ${CONTENT_TYPE}    Get Env    CONTENT_TYPE
    ${USER_ID}    Get Env    USER_ID
    ${USER_ID2}    Get Env    USER_ID2
    ${NON_NUMERIC_ID}    Get Env    NON_NUMERIC_ID
    ${USER_NOT_FOUND_ID}    Get Env    USER_NOT_FOUND_ID
    ${INVALID_TOKEN}    Get Env    INVALID_TOKEN
    ${REGISTERED_EMAIL}    Get Env    REGISTERED_EMAIL
    ${INVALID_EMAIL}    Get Env    INVALID_EMAIL
    ${LONG_EMAIL}    Get Env    LONG_EMAIL
    ${lONG_INVALID_EMAIL}    Get Env    lONG_INVALID_EMAIL

    Set Global Variable    ${BASE_URL}
    Set Global Variable    ${BEARER_TOKEN}
    Set Global Variable    ${ACCEPT}
    Set Global Variable    ${CONTENT_TYPE}
    Set Global Variable    ${USER_ID}
    Set Global Variable    ${USER_ID2}
    Set Global Variable    ${NON_NUMERIC_ID}
    Set Global Variable    ${USER_NOT_FOUND_ID}
    Set Global Variable    ${INVALID_TOKEN}
    Set Global Variable    ${REGISTERED_EMAIL}
    Set Global Variable    ${INVALID_EMAIL}
    Set Global Variable    ${LONG_EMAIL}
    Set Global Variable    ${lONG_INVALID_EMAIL}