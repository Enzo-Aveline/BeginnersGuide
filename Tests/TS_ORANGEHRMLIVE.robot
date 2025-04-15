*** Settings ***
Library             SeleniumLibrary
Library             DateTime
Library             Collections

Test Setup          Ouvrir Orangehrmlive
Test Teardown       Fermer Orangehrmlive

Test Tags           tnr


*** Variables ***
${ORANGEHRMLIVE_URL}    https://opensource-demo.orangehrmlive.com/web/index.php


*** Test Cases ***

Test Ajout d'un Utilisateur
    SeleniumLibrary.Click Element    xpath=//a[@href='/web/index.php/admin/viewAdminModule']




# Test case for adding a new employee to the system.
# This test navigates to the PIM module, clicks the "Add" button, fills out the employee form, and submits it.
Test Ajout d'un employé
    # Navigate to the PIM module
    SeleniumLibrary.Click Element    xpath=//a[@href='/web/index.php/pim/viewPimModule']

    ${first_name}    Set Variable    Coco
    ${middle_name}    Set Variable    Lapin
    ${last_name}    Set Variable    Au miel
    ${employee_id}    Set Variable    123456

    # Remplissage du formulaire
    SeleniumLibrary.Input Text    xpath=//input[@name='firstName']    ${first_name}
    SeleniumLibrary.Input Text    xpath=//input[@name='middleName']    ${middle_name}
    SeleniumLibrary.Input Text    xpath=//input[@name='lastName']    ${last_name}
    SeleniumLibrary.Input Text    xpath=//input[@name='employeeId']    ${employee_id}`

    # Click the "Add" button to open the employee form
    SeleniumLibrary.Click Element    xpath=//button[contains(., 'Add')]

    # Set variables for employee details
    ${first_name}    Set Variable    Coco
    ${middle_name}    Set Variable    Lapin
    ${last_name}    Set Variable    Au miel
    ${username}    Set Variable    CocoLapin
    ${password}    Set Variable    admin123
    ${confirm_password}    Set Variable    admin123

    # Fill out the employee form
    SeleniumLibrary.Input Text    xpath=//input[@name='firstName']    ${first_name}
    SeleniumLibrary.Input Text    xpath=//input[@name='middleName']    ${middle_name}
    SeleniumLibrary.Input Text    xpath=//input[@name='lastName']    ${last_name}

    # Enable login details and fill out the login form
    SeleniumLibrary.Click Element    xpath=//div[contains(@class, 'oxd-switch-wrapper')]//span[contains(@class, 'oxd-switch-input')]
    SeleniumLibrary.Input Text    xpath=//label[text()='Username']/following::input[1]    ${username}
    SeleniumLibrary.Input Password    xpath=//label[text()='Password']/following::input[1]    ${password}
    SeleniumLibrary.Input Password    xpath=//label[text()='Confirm Password']/following::input[1]    ${confirm_password}

    # Submit the form
    SeleniumLibrary.Click Element    xpath=//button[@type='submit']


# Test case for modifying an existing employee's details.
# This test searches for an employee, edits their details, and saves the changes.
Test Modification d'un employé
    # Search for the employee "Coco"
    Rechercher Employé    coco

    # Click the edit (pencil) icon for the employee
    SeleniumLibrary.Click Element    xpath=//div[text()='Coco Lapin']/ancestor::div[@role='row']//i[contains(@class, 'bi-pencil-fill')]

    # Modify the driver's license number
    BuiltIn.Sleep    1
    SeleniumLibrary.Click Element    xpath=//label[text()='Driver License Number']/following::input[1]
    BuiltIn.Sleep    1
    SeleniumLibrary.Press Keys       xpath=//label[text()='Driver License Number']/following::input[1]    CTRL+a+DELETE
    BuiltIn.Sleep    1
    SeleniumLibrary.Input Text       xpath=//label[text()='Driver License Number']/following::input[1]    DL123456789
    BuiltIn.Sleep    1

    # Save the changes
    SeleniumLibrary.Click Element    xpath=//button[@type='submit']


# Test case for deleting an employee from the system.
# This test searches for an employee and deletes them, handling the confirmation dialog if applicable.
Test Suppression d'un employé
    # Search for the employee "Coco"
    Rechercher Employé    coco

    # Click the delete (trash) icon for the employee
    SeleniumLibrary.Click Element    xpath=//div[text()='Coco Lapin']/ancestor::div[@role='row']//i[contains(@class, 'bi-trash')]

    # Handle the confirmation dialog
    BuiltIn.Sleep    1
    SeleniumLibrary.Click Button     xpath=//button[text()=' Yes, Delete ']

*** Keywords ***
Ouvrir Orangehrmlive
    [Documentation]
    ...    Ouverture de Chrome à l'adresse ${ORANGEHRMLIVE_URL} et connexion

    # ETAPE DE LANCEMENT DE L APPLICATION
    SeleniumLibrary.Open Browser    ${ORANGEHRMLIVE_URL}/auth/login
    ...    browser=chrome
    ...    options=add_experimental_option('excludeSwitches', ['enable-logging'])
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Implicit Wait    5s
    ${username}    Set Variable    Admin
    ${password}    Set Variable    admin123

    # Connexion à la page
    SeleniumLibrary.Input Text    xpath=//input[@name='username']    ${username}
    SeleniumLibrary.Input Text    xpath=//input[@name='password']    ${password}
    SeleniumLibrary.Click Button  xpath=//button[@type='submit']

    # Vérification de la connexion réussie
    SeleniumLibrary.Wait Until Page Contains Element    xpath=//span[text()='Dashboard']
    ${title}    SeleniumLibrary.Get Title
    BuiltIn.Should Contain    ${title}    OrangeHRM

*** Keywords ***
Rechercher Employé
    [Arguments]    ${employee_name}
    SeleniumLibrary.Click Element    xpath=//a[@href='/web/index.php/pim/viewPimModule']
    SeleniumLibrary.Input Text       xpath=//label[text()='Employee Name']/following::input[1]    ${employee_name}
    SeleniumLibrary.Click Button     xpath=//button[text()=' Search ']
    BuiltIn.Sleep    1

Fermer Orangehrmlive
    [Documentation]
    ...    Fermeture du navigateur
    ...    On laisse un peu de temps pour visualiser l'écran final
    BuiltIn.Sleep    3
    Capture Page Screenshot
    SeleniumLibrary.Close Browser

Scroll Element To Top
    [Documentation]    Permet de placer l'élément en haut de page avec delta
    ...    Par defaut le delta=0
    ...    Le delta peut être la hauteur d'un bandeau
    [Arguments]    ${locator}    ${delta_top}=0
    SeleniumLibrary.Wait Until Page Contains Element    ${locator}
    ${el_pos_y}    SeleniumLibrary.Get Vertical Position    ${locator}
    ${final_y}    BuiltIn.Evaluate    int(${el_pos_y}) -int(${delta_top})
    SeleniumLibrary.Execute Javascript    window.scrollTo(0, arguments[0])    ARGUMENTS    ${final_y}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}

Highlight Element
    [Arguments]    ${locator}
    # Change le style de couleur de l'élément pour le mettre en évidence (le bord en rouge et le fond en jaune)
    # Le style est repositionné par défault
    ${element}    SeleniumLibrary.Get WebElement    ${locator}
    ${original_style}    SeleniumLibrary.Execute Javascript
    ...    element = arguments[0];
    ...    original_style = element.getAttribute('style');
    ...    element.setAttribute('style', original_style + "; color: red; background: yellow; border: 2px solid red;");
    ...    return original_style;
    ...    ARGUMENTS
    ...    ${element}
    BuiltIn.Sleep    0.1s
    ${element}    SeleniumLibrary.Get WebElement    ${locator}
    SeleniumLibrary.Execute Javascript
    ...    element = arguments[0];
    ...    original_style = arguments[1];
    ...    element.setAttribute('style', original_style);
    ...    ARGUMENTS
    ...    ${element}
    ...    ${original_style}

